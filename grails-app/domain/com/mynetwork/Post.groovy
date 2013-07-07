package com.mynetwork

class Post {

    String text
    Date dateCreated

    static belongsTo = [user: User]

    static constraints = {
        text(blank: false, maxSize: 4000)
    }

    def String toString() {
        text
    }
}
