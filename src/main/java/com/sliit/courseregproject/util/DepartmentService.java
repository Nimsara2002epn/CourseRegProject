package com.sliit.courseregproject.util;

import com.studentreg.model.Department;
import java.util.*;

public class DepartmentService {

    public static boolean addDepartment(Department dept) {
        if (FileHandler.valueExists(FileHandler.DEPARTMENTS_FILE, 1, dept.getName())) {
            return false; // Duplicate name
        }
        dept.setId(FileHandler.generateId());
        FileHandler.appendLine(FileHandler.DEPARTMENTS_FILE, dept.toFileString());
        return true;
    }

    public static List<Department> getAllDepartments() {
        List<String> lines = FileHandler.readAllLines(FileHandler.DEPARTMENTS_FILE);
        List<Department> depts = new ArrayList<>();
        for (String line : lines) {
            Department d = Department.fromFileString(line);
            if (d != null) depts.add(d);
        }
        return depts;
    }

    public static Department getDepartmentById(String id) {
        for (Department d : getAllDepartments()) {
            if (d.getId().equals(id)) return d;
        }
        return null;
    }

    public static String getDepartmentNameById(String id) {
        Department d = getDepartmentById(id);
        return d != null ? d.getName() : "Unknown";
    }

    public static boolean updateDepartment(Department updated) {
        List<String> lines = FileHandler.readAllLines(FileHandler.DEPARTMENTS_FILE);
        boolean found = false;
        List<String> updatedLines = new ArrayList<>();

        for (String line : lines) {
            Department d = Department.fromFileString(line);
            if (d != null && d.getId().equals(updated.getId())) {
                updatedLines.add(updated.toFileString());
                found = true;
            } else {
                updatedLines.add(line);
            }
        }

        if (found) FileHandler.writeAllLines(FileHandler.DEPARTMENTS_FILE, updatedLines);
        return found;
    }

    public static boolean deleteDepartment(String id) {
        List<String> lines = FileHandler.readAllLines(FileHandler.DEPARTMENTS_FILE);
        List<String> newLines = new ArrayList<>();
        boolean found = false;

        for (String line : lines) {
            Department d = Department.fromFileString(line);
            if (d != null && d.getId().equals(id)) {
                found = true;
            } else {
                newLines.add(line);
            }
        }

        if (found) FileHandler.writeAllLines(FileHandler.DEPARTMENTS_FILE, newLines);
        return found;
    }

    public static List<Department> searchDepartments(String keyword) {
        List<Department> results = new ArrayList<>();
        String kw = keyword.toLowerCase();
        for (Department d : getAllDepartments()) {
            if (d.getName().toLowerCase().contains(kw)
                    || d.getDescription().toLowerCase().contains(kw)) {
                results.add(d);
            }
        }
        return results;
    }
}