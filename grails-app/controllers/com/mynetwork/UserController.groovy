package com.mynetwork

import grails.events.Listener
import org.springframework.amqp.rabbit.connection.RabbitUtils
import org.springframework.dao.DataIntegrityViolationException
import grails.plugins.springsecurity.Secured
import grails.converters.JSON
import uk.co.desirableobjects.ajaxuploader.exception.FileUploadException
import javax.servlet.http.HttpServletRequest
import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.MultipartFile
import javax.activation.MimetypesFileTypeMap

class UserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    final SESSION_AVATAR = "uploaded_avatar"

    def springSecurityService
    def ajaxUploaderService

    def index() {
        redirect(action: "list", params: params)
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        def currentUser = springSecurityService.currentUser as User
        def role = UserRole.findByUser(currentUser).role
        if(role.authority == 'ROLE_ADMIN') {
            [users: User.list(params), userInstanceTotal: User.count()]
        } else {
            [users: currentUser.following, userInstanceTotal: User.count()]
        }
    }

    def create() {
        [userInstance: new User(params)]
    }

    def save() {
        def userInstance = new User(params)
        if (!userInstance.save(flush: true)) {
            render(view: "create", model: [userInstance: userInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "show", id: userInstance.id)
    }

    def show() {
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect(action: "list")
            return
        }

        [user: userInstance, loggedUser: springSecurityService.currentUser as User]
    }

    def edit() {
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect(action: "list")
            return
        }

        [userInstance: userInstance]
    }

    def update() {
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect(action: "list")
            return
        }

        if (params.version) {
            def version = params.version.toLong()
            if (userInstance.version > version) {
                userInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'user.label', default: 'User')] as Object[],
                        "Another user has updated this User while you were editing")
                render(view: "edit", model: [userInstance: userInstance])
                return
            }
        }

        userInstance.properties = params

        if (session[SESSION_AVATAR]) {       // was avatar uploaded via the uploadAvatar ajax action?
            File avatar = new File((String) session[SESSION_AVATAR])
            userInstance.profile.avatar = avatar.getBytes()
            MimetypesFileTypeMap mimeTypesMap = new MimetypesFileTypeMap()
            userInstance.profile.avatarType = mimeTypesMap.getContentType((String) session[SESSION_AVATAR]);
            session[SESSION_AVATAR] = null
        }

        if (!userInstance.save(flush: true)) {
            render(view: "edit", model: [userInstance: userInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "show", id: userInstance.id)
    }

    def delete() {
        def userInstance = User.get(params.id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect(action: "list")
            return
        }

        try {
            userInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), params.id])
            redirect(action: "show", id: params.id)
        }
    }

    @Secured(['ROLE_ADMIN', 'ROLE_USER', 'IS_AUTHENTICATED_REMEMBERED'])
    def uploadAvatar() {
        try {
            File dest = File.createTempFile("${params.userId}_" + System.currentTimeMillis(),".jpg")
            session[SESSION_AVATAR] = dest.path
            InputStream inputStream = selectInputStream(request)
            ajaxUploaderService.upload(inputStream, dest)
            return render(text: [success:true] as JSON, contentType:'text/json')
        } catch (FileUploadException e) {
            log.error("Failed to upload file.", e)
            return render(text: [success:false] as JSON, contentType:'text/json')
        }
    }

    def addPost = { Post post ->
        if(post.text.isEmpty()) {
            return
        } else {
        def user = User.get(params.id)

        User.withTransaction { status ->

            post.dateCreated = new Date()

            user.addToPosts(post)
            user.save(flush: true)
            rabbitSend 'myQueueName', "${params.id} ${post.id}"
            TreeSet<Post> posts = new TreeSet<Post>()
            posts.addAll(user.posts)

            user.following.each {

                posts.addAll(it.posts)

            }
        }
        render(template: "/common/posts", model:[posts:posts])
        }
    }

    def getPosts = {
        def user = springSecurityService.getCurrentUser()
        TreeSet<Post> posts = new TreeSet<Post>()
        posts.addAll(user.posts)
        user.following.each {

            posts.addAll(it.posts)

        }
        render(template: "/common/posts", model:[posts:posts])
    }

    def getPost = {
        TreeSet<Post> posts = new TreeSet<Post>()
        posts.add(Post.get(params.id))
        render(template: "/common/posts", model:[posts:posts, newpost:params.new ? "newpost" : null])
    }

    @Secured(['ROLE_ADMIN', 'ROLE_USER', 'IS_AUTHENTICATED_REMEMBERED'])
    def followToggle() {
        User user = User.get(params.id)
        User loggedUser = springSecurityService.currentUser as User
        if (!user) {
            render "User not found!"
        }
        Thread.sleep(1000L)
        if (loggedUser?.following?.contains(user)) {
            loggedUser.following.remove(user)
            user.followers.remove(loggedUser)
            render "You are no longer following ${user.username}"
        } else {
            loggedUser.addToFollowing(user)
            user.addToFollowers(loggedUser)
            render "You are now following ${user.username}"
        }
    }

    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
    def viewAvatar() {
        def avatarFile
        avatarFile = session[SESSION_AVATAR] != null ? (new File((String) session[SESSION_AVATAR]))?.bytes : null
        def user = User.get(params.id)
        def avatarContentType = 'image/jpeg'
        if (!avatarFile || !params.temporary) {
            avatarFile = user?.profile.avatar
            avatarContentType = user?.profile.avatarType
        }
        if (!avatarFile) {
            avatarFile = ((!user.profile.gender || user.profile.gender == Gender.MALE) ? servletContext.getResource("/images/users/default_man.jpg")?.bytes : servletContext.getResource("/images/users/default_woman.jpg")?.bytes)
        }
        response.setHeader("Content-disposition", "attachment; filename=avatar.jpg")
        response.contentType = avatarContentType ?:  'image/jpeg'
        response.outputStream << avatarFile
        response.outputStream.flush()
    }

    private static InputStream selectInputStream(HttpServletRequest request) {
        if (request instanceof MultipartHttpServletRequest) {
            MultipartFile uploadedFile = ((MultipartHttpServletRequest) request).getFile('qqfile')
            return uploadedFile.inputStream
        }
        return request.inputStream
    }
}
