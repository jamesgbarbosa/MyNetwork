import com.mynetwork.Post
import com.mynetwork.User
import com.mynetwork.Role
import com.mynetwork.UserRole
import com.mynetwork.Gender
import com.mynetwork.Profile

class BootStrap {

    def init = { servletContext ->
        def userRole = Role.findByAuthority('ROLE_USER') ?: new Role(authority: 'ROLE_USER').save(failOnError: true)
        def adminRole = Role.findByAuthority('ROLE_ADMIN') ?: new Role(authority: 'ROLE_ADMIN').save(failOnError: true)

        def admin
        Profile adminProfile = new Profile(country: 'PH', email: 'james@admin.com').save(failOnError: true)

        def user
        Profile userProfile = new Profile(country: 'PH', email: 'james@user.com').save(failOnError: true)

        def james
        Profile jamesProfile = new Profile(country: 'PH', email: 'james@james.com').save(failOnError: true)

        def podferio
        Profile podferioProfile = new Profile(country: 'PH', email: 'james@podferio.com').save(failOnError: true)

        if (!(james = User.findByUsername('james'))) {

            james = new User(username: "james", email: "james@gmail.com", password: "james", enabled: true)
            james.profile = jamesProfile
            james.save(failOnError: true)
        }

        if (!(podferio = User.findByUsername('podferio'))) {

            podferio = new User(username: "podferio", email: "podferio@gmail.com", password: "podferio", enabled: true)
            podferio.profile = podferioProfile
            podferio.save(failOnError: true)
        }

        if (!(admin = User.findByUsername('admin'))) {

            admin = new User(username: "admin", email: "reptst@gmail.com", password: "admin", enabled: true)
            admin.profile = adminProfile
            admin.save(failOnError: true)
        }

        Post post1 = new Post(text: "Hello World", dateCreated: new Date())
        Post post2 = new Post(text: "Hello James", dateCreated: new Date())

        if (!(user = User.findByUsername('user'))) {

            user = new User(username: "user", email: "user@gmail.com", password: "user", enabled: true)
            user.profile = userProfile
            user.addToFollowing(admin)
            user.addToPosts(post1)
            user.addToPosts(post2)
            user.save(failOnError: true)
        }

        if (!admin?.authorities?.contains(adminRole)) {
            UserRole.create admin, adminRole
        }
        if (!user?.authorities?.contains(userRole)) {
            UserRole.create user, userRole
        }

        if (!james?.authorities?.contains(userRole)) {
            UserRole.create james, userRole
        }

        if (!podferio?.authorities?.contains(userRole)) {
            UserRole.create podferio, userRole
        }
    }
    def destroy = {
    }
}
