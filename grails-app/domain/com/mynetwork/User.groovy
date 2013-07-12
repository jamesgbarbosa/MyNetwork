package com.mynetwork

class User {

	transient springSecurityService

	String username
	String password
    String email
	boolean enabled
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired
    Profile profile

    static hasMany = [posts: Post, following: User, followers: User]

	static constraints = {
		username blank: false, unique: true
		password blank: false
        profile nullable: true
        email(blank: false, maxSize: 50, email: true)
	}

	static mapping = {
		password column: '`password`'
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this).collect { it.role } as Set
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService.encodePassword(password)
	}
}
