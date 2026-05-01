package com.courseregproject.util;

import com.courseregproject.model.Course;
import java.util.*;


public class CourseService {

    public static boolean addCourse(Course course) {
        if (FileHandler.valueExists(FileHandler.COURSES_FILE, 2, course.getCode())) {
            return false; // Duplicate course code
        }
        course.setId(FileHandler.generateId());
        FileHandler.appendLine(FileHandler.COURSES_FILE, course.toFileString());
        return true;
    }

    public static List<Course> getAllCourses() {
        List<String> lines = FileHandler.readAllLines(FileHandler.COURSES_FILE);
        List<Course> courses = new ArrayList<>();
        for (String line : lines) {
            Course c = Course.fromFileString(line);
            if (c != null) courses.add(c);
        }
        return courses;
    }

    public static Course getCourseById(String id) {
        for (Course c : getAllCourses()) {
            if (c.getId().equals(id)) return c;
        }
        return null;
    }

    public static String getCourseNameById(String id) {
        Course c = getCourseById(id);
        return c != null ? c.getName() + " (" + c.getCode() + ")" : "Unknown";
    }

    public static boolean updateCourse(Course updated) {
        List<String> lines = FileHandler.readAllLines(FileHandler.COURSES_FILE);
        boolean found = false;
        List<String> updatedLines = new ArrayList<>();

        for (String line : lines) {
            Course c = Course.fromFileString(line);
            if (c != null && c.getId().equals(updated.getId())) {
                updatedLines.add(updated.toFileString());
                found = true;
            } else {
                updatedLines.add(line);
            }
        }

        if (found) FileHandler.writeAllLines(FileHandler.COURSES_FILE, updatedLines);
        return found;
    }

    public static boolean deleteCourse(String id) {
        List<String> lines = FileHandler.readAllLines(FileHandler.COURSES_FILE);
        List<String> newLines = new ArrayList<>();
        boolean found = false;

        for (String line : lines) {
            Course c = Course.fromFileString(line);
            if (c != null && c.getId().equals(id)) {
                found = true;
            } else {
                newLines.add(line);
            }
        }

        if (found) FileHandler.writeAllLines(FileHandler.COURSES_FILE, newLines);
        return found;
    }

    public static List<Course> searchCourses(String keyword) {
        List<Course> results = new ArrayList<>();
        String kw = keyword.toLowerCase();
        for (Course c : getAllCourses()) {
            if (c.getName().toLowerCase().contains(kw)
                    || c.getCode().toLowerCase().contains(kw)
                    || c.getDescription().toLowerCase().contains(kw)) {
                results.add(c);
            }
        }
        return results;
    }

    public static List<Course> getCoursesByDepartment(String departmentId) {
        List<Course> results = new ArrayList<>();
        for (Course c : getAllCourses()) {
            if (c.getDepartmentId().equals(departmentId)) results.add(c);
        }
        return results;
    }
}
