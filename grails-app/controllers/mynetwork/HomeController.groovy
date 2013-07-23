package mynetwork

class HomeController {
    def springSecurityService

    def index = {
        if(springSecurityService.isLoggedIn()) {

        }
        else {
//            redirect(action:'auth',controller:'login')
        }
    }
}
