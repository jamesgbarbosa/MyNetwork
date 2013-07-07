package com.mynetwork

public enum Gender {
    MALE("MALE"),
    FEMALE("FEMALE")

    Gender(String id) { this.id = id; }
    private String id

    def getId() { id }

}