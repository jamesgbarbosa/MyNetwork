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

        if (!(admin = User.findByUsername('Admin'))) {

            admin = new User(username: "admin", email: "reptst@gmail.com", password: "admin", enabled: true)
            admin.profile = adminProfile
            admin.save(failOnError: true)
        }
        if (!admin?.authorities?.contains(adminRole)) {
            UserRole.create admin, adminRole
        }
    }
    def destroy = {
    }
}
