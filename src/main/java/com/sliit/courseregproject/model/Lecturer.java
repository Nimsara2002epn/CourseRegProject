package com.sliit.courseregproject.model;

public class Lecturer extends User {

    private String staffId;
    private String department;
    private String specialization;

    public Lecturer() {
        super();
        setRole("LECTURER");
    }

    public Lecturer(String id, String name, String email, String phone,
                    String password, String staffId, String department, String specialization) {
        super(id, name, email, phone, password, "LECTURER");
        this.staffId = staffId;
        this.department = department;
        this.specialization = specialization;
    }

    public String getStaffId() { return staffId; }
    public void setStaffId(String staffId) { this.staffId = staffId; }

    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }

    public String getSpecialization() { return specialization; }
    public void setSpecialization(String specialization) { this.specialization = specialization; }

    @Override
    public String getDisplayInformation() {
        return "Lecturer: " + getName() + " [" + staffId + "] | " + department + " | " + specialization;
    }

    @Override
    public String toFileString() {
        return super.toFileString() + "," + staffId + "," + department + "," + specialization;
    }

    public static Lecturer fromFileString(String line) {
        String[] parts = line.split(",", -1);
        if (parts.length < 9) return null;
        Lecturer l = new Lecturer();
        l.setId(parts[0]);
        l.setName(parts[1]);
        l.setEmail(parts[2]);
        l.setPhone(parts[3]);
        l.setPassword(parts[4]);
        l.setRole(parts[5]);
        l.setStaffId(parts[6]);
        l.setDepartment(parts[7]);
        l.setSpecialization(parts[8]);
        return l;
    }
}
