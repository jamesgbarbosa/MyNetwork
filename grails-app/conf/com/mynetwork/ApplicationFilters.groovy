package com.mynetwork

class ApplicationFilters {

    def springSecurityService

    def filters = {
        all(uri: "/") {

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
    }
}
