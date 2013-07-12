package com.mynetwork

class UserTagLib {
    def springSecurityService

    static namespace = "user"

    def followIndicator = { attrs, body ->
        def loggedUser = springSecurityService.currentUser as User
//        if ((attrs.user as User)?.following?.contains(loggedUser)) {
        if (loggedUser?.following?.contains((attrs.user as User))) {
            out << attrs.stopFollowText
        } else {
            out << attrs.followText
        }
    }
}
