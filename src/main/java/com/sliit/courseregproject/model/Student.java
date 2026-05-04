package com.sliit.courseregproject.model;

public class Student extends User {

    private String indexNumber; 
    private String department;

    public Student() {
        super();
        setRole("STUDENT");
    }

    public Student(String id, String name, String email, String phone,
                   String password, String indexNumber, String department) {
        super(id, name, email, phone, password, "STUDENT");
        this.indexNumber = indexNumber;
        this.department = department;
    }

    public String getIndexNumber() { return indexNumber; }
    public void setIndexNumber(String indexNumber) { this.indexNumber = indexNumber; }

    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }
    
    @Override
    public String getDisplayInfo() {
        return "Student: " + getName() + " [" + indexNumber + "] | " + getDepartment();
    }
    
    @Override
    public String toFileString() {
        return super.toFileString() + "," + indexNumber + "," + department;
    }

    public static Student fromFileString(String line) {
        String[] parts = line.split(",", -1);
        if (parts.length < 8) return null;
        Student s = new Student();
        s.setId(parts[0]);
        s.setName(parts[1]);
        s.setEmail(parts[2]);
        s.setPhone(parts[3]);
        s.setPassword(parts[4]);
        s.setRole(parts[5]);
        s.setIndexNumber(parts[6]);
        s.setDepartment(parts[7]);
        return s;
    }
}
