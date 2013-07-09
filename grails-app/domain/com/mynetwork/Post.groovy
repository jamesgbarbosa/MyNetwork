package com.mynetwork

class Post implements Comparable<Post> {

    String text
    Date dateCreated

    static belongsTo = [user: User]

    static constraints = {
        text(blank: false, maxSize: 4000)
    }

    static mapping = {
        autoTimestamp true
        sort dateCreated: "desc"
    }

    def String toString() {
        text
    }

    @Override
    int compareTo(Post o) {
        return o.dateCreated <=> dateCreated
    }
}
