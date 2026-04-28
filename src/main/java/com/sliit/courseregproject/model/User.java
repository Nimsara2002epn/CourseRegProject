package com.sliit.courseregproject.model;

public class User {

    private String id;
    private String name;
    private String email;
    private String phone;
    private String password;
    private String role; // STUDENT, LECTURER, ADMIN

    // Constructor
    public User(String id, String name, String email, String phone, String password, String role) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.role = role;
    }

    // Default constructor
    public User() {}

    // ---- Getters & Setters (Encapsulation) ----

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    /**
     * POLYMORPHISM — overridden in subclasses to show role-specific info
     */
    public String getDisplayInformation() {
        return "User[" + role + "]: " + name + " | " + email;
    }

    /**
     * Convert to CSV line for file storage
     * Format: id,name,email,phone,password,role
     */
    public String toFileString() {
        return id + "," + name + "," + email + "," + phone + "," + password + "," + role;
    }

    /**
     * Create a User object from a CSV line
     */
    public static User fromFileString(String line) {
        String[] parts = line.split(",", -1);
        if (parts.length < 6) return null;
        User user = new User();
        user.setId(parts[0]);
        user.setName(parts[1]);
        user.setEmail(parts[2]);
        user.setPhone(parts[3]);
        user.setPassword(parts[4]);
        user.setRole(parts[5]);
        return user;
    }

    @Override
    public String toString() {
        return getDisplayInformation();
    }
}
