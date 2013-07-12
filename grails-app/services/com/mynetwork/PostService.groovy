package com.mynetwork

import grails.converters.JSON
import grails.events.Listener
import grails.events.*
import com.mynetwork.User
class PostService {
    static rabbitQueue = 'myQueueName'
//    @Listener(namespace = 'browser')
//   def saveTodo(Map data) {
//
//     def userIds = User.list().id
//
//     try {
//             println(data)
//
//
//            data.num = (Math.random() * (userIds.size()+1)).toInteger()
//            data.random = (Math.random() * 100).toInteger()+",\n"
//            event(topic:"savedTodo_${data.num}", data:data)
//     } catch(Exception e) {
//         println e
//     }
//    }

    void post(def userId, def postId) {
        def data = [:]
        data.as = postId
        event(topic:"savedTodo_${userId}", data:data)
    }

    void handleMessage(data) {
        Thread.sleep(2000)
        def ar = data.split()
        def userId = ar[0]
        def postId = ar[1]
        println("[x] Message Received: " + userId)
        User user = User.get(userId)
        for(User thisUser: user.followers) {
            post(thisUser.id, postId)
        }
        println("[x] Post processed: " + userId)
    }

}