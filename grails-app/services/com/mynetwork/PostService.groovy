package com.mynetwork

import grails.converters.JSON
import grails.events.Listener
import grails.events.*
import com.mynetwork.User
class PostService {
   static rabbitQueue = 'myQueueName'
   def springSecurityService

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

    void post(def userId) {
        event(topic:"savedTodo_${userId}")
    }

    void handleMessage(userId) {
        Thread.sleep(3000)
        println("[x] Message Received: " + userId)
        User user = User.get(userId)
        for(User thisUser: user.following) {
            post(thisUser.id)
        }
        println("[x] Post processed: " + userId)
    }

}