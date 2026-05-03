package com.sliit.courseregproject.model;

public class Registration {

    private String id;
    private String studentId;
    private String courseId;
    private String registrationDate;
    private String status; 

    public Registration() {}

    public Registration(String id, String studentId, String courseId,
                        String registrationDate, String status) {
        this.id = id;
        this.studentId = studentId;
        this.courseId = courseId;
        this.registrationDate = registrationDate;
        this.status = status;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }

    public String getCourseId() { return courseId; }
    public void setCourseId(String courseId) { this.courseId = courseId; }

    public String getRegistrationDate() { return registrationDate; }
    public void setRegistrationDate(String registrationDate) { this.registrationDate = registrationDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String toFileString() {
        return id + "," + studentId + "," + courseId + "," + registrationDate + "," + status;
    }

    public static Registration fromFileString(String line) {
        String[] parts = line.split(",", -1);
        if (parts.length < 5) return null;
        return new Registration(parts[0], parts[1], parts[2], parts[3], parts[4]);
    }
}
