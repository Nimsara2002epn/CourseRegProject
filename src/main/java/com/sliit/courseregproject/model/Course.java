package com.sliit.courseregproject.model;

public class Course {

    private String id;
    private String name;
    private String code;       // e.g., SE1020
    private String departmentId;
    private String lecturerId;
    private String credits;
    private String description;

    public Course() {}

    public Course(String id, String name, String code, String departmentId,
                  String lecturerId, String credits, String description) {
        this.id = id;
        this.name = name;
        this.code = code;
        this.departmentId = departmentId;
        this.lecturerId = lecturerId;
        this.credits = credits;
        this.description = description;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }

    public String getDepartmentId() { return departmentId; }
    public void setDepartmentId(String departmentId) { this.departmentId = departmentId; }

    public String getLecturerId() { return lecturerId; }
    public void setLecturerId(String lecturerId) { this.lecturerId = lecturerId; }

    public String getCredits() { return credits; }
    public void setCredits(String credits) { this.credits = credits; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String toFileString() {
        return id + "," + name + "," + code + "," + departmentId + "," +
                lecturerId + "," + credits + "," + description;
    }

    public static Course fromFileString(String line) {
        String[] parts = line.split(",", -1);
        if (parts.length < 7) return null;
        return new Course(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6]);
    }
}
