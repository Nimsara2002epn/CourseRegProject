package com.sliit.courseregproject.util;

import com.sliit.courseregproject.model;
import java.util.*;

public class UserService {
    public static boolean addUser(User user) {
        if (FileHandler.valueExists(FileHandler.USERS_FILE, 2, user.getEmail())) {
            return false;
        }
        user.setId(FileHandler.generateId());
        FileHandler.appendLine(FileHandler.USERS_FILE, user.toFileString());
        return true;
    }
    public static List<User> getAllUsers() {
        List<String> lines = FileHandler.readAllLines(FileHandler.USERS_FILE);
        List<User> users = new ArrayList<>();
        for (String line : lines) {
            User u = User.fromFileString(line);
            if (u != null) users.add(u);
        }
        return users;
    }
    public static User getUserById(String id) {
        for (User u : getAllUsers()) {
            if (u.getId().equals(id)) return u;
        }
        return null;
    }
    public static User login(String email, String password) {
        for (User u : getAllUsers()) {
            if (u.getEmail().equalsIgnoreCase(email) && u.getPassword().equals(password)) {
                return u;
            }
        }
        return null;
    }
    public static boolean updateUser(User updated) {
        List<String> lines = FileHandler.readAllLines(FileHandler.USERS_FILE);
        boolean found = false;
        List<String> updatedLines = new ArrayList<>();

        for (String line : lines) {
            User u = User.fromFileString(line);
            if (u != null && u.getId().equals(updated.getId())) {
                updatedLines.add(updated.toFileString());
                found = true;
            } else {
                updatedLines.add(line);
            }
        }

        if (found) {
            FileHandler.writeAllLines(FileHandler.USERS_FILE, updatedLines);
        }
        return found;
    }
    public static boolean deleteUser(String id) {
        List<String> lines = FileHandler.readAllLines(FileHandler.USERS_FILE);
        List<String> newLines = new ArrayList<>();
        boolean found = false;

        for (String line : lines) {
            User u = User.fromFileString(line);
            if (u != null && u.getId().equals(id)) {
                found = true;
            } else {
                newLines.add(line);
            }
        }

        if (found) {
            FileHandler.writeAllLines(FileHandler.USERS_FILE, newLines);
        }
        return found;
    }
    public static List<User> searchUsers(String keyword) {
        List<User> results = new ArrayList<>();
        String kw = keyword.toLowerCase();
        for (User u : getAllUsers()) {
            if (u.getName().toLowerCase().contains(kw)
                    || u.getEmail().toLowerCase().contains(kw)
                    || u.getPhone().toLowerCase().contains(kw)
                    || u.getRole().toLowerCase().contains(kw)) {
                results.add(u);
            }
        }
        return results;
    }
}
