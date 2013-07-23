package com.mynetwork

import javax.servlet.http.Cookie

class ApplicationFilters {

    def springSecurityService

    def filters = {
        index(uri: "/") {

            after = { def models ->
                def currentUser = springSecurityService.getCurrentUser() as User
                if(currentUser) {
                    models.user = currentUser

                    TreeSet<Post> posts = new TreeSet<Post>()
                    posts.addAll(currentUser.posts)

                    currentUser.following.each {

                        posts.addAll(it.posts)

                    }
                    models.posts = posts
                    models.currentUser = currentUser
                }
            }
         }

        securityFilter(controller: '(login|logout)', action: '*', find:true, invert:true){
            before = {
                if (!springSecurityService.isLoggedIn()) {
                    redirect(action:'auth',controller:'login')
                }
            }
        }
    }


}
