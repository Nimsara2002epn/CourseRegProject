package com.sliit.courseregproject.model;

public class Department {

    private String id;
    private String name;
    private String description;

    public Department() {}

    public Department(String id, String name, String description) {
        this.id = id;
        this.name = name;
        this.description = description;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String toFileString() {
        return id + "," + name + "," + description;
    }

    public static Department fromFileString(String line) {
        String[] parts = line.split(",", -1);
        if (parts.length < 3) return null;
        return new Department(parts[0], parts[1], parts[2]);
    }

}
