package com.mynetwork
import com.mynetwork.Gender

class Profile {
    static belongsTo = User

    String email
    String country
    String town
    Gender gender
    String info
    Integer yearBorn
    Date dateCreated
    byte[] avatar
    String avatarType

    static constraints = {
        email(blank: false, maxSize: 50, email: true)
        country(nullable: true, maxSize: 60)
        town(nullable: true, maxSize: 60)
        gender(nullable: true)
        info(nullable: true, maxSize: 4000)
        yearBorn(nullable: true)
        avatar(nullable: true, maxSize: 16000)
        avatarType(nullable: true)
    }

}
