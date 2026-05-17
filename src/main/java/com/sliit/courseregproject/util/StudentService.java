
package com.sliit.courseregproject.util;

import com.sliit.courseregproject.model.Student;
import java.util.*;


public class StudentService {

    public static boolean addStudent(Student student) {
        if (FileHandler.valueExists(FileHandler.STUDENTS_FILE, 2, student.getEmail())) {
            return false;
        }
        student.setId(FileHandler.generateId());
        if (student.getIndexNumber() == null || student.getIndexNumber().isBlank()) {
            student.setIndexNumber(generateNextIndexNumber());
        }
        FileHandler.appendLine(FileHandler.STUDENTS_FILE, student.toFileString());
        return true;
    }

    private static String generateNextIndexNumber() {
        int maxNumber = 0;

        for (Student student : getAllStudents()) {
            String indexNumber = student.getIndexNumber();
            if (indexNumber == null || indexNumber.isBlank()) {
                continue;
            }

            String digitsOnly = indexNumber.replaceAll("\\D", "");
            if (digitsOnly.isEmpty()) {
                continue;
            }

            try {
                maxNumber = Math.max(maxNumber, Integer.parseInt(digitsOnly));
            } catch (NumberFormatException ignored) {
            }
        }

        return String.valueOf(maxNumber + 1);
    }

    public static List<Student> getAllStudents() {
        List<String> lines = FileHandler.readAllLines(FileHandler.STUDENTS_FILE);
        List<Student> students = new ArrayList<>();
        for (String line : lines) {
            Student s = Student.fromFileString(line);
            if (s != null) students.add(s);
        }
        return students;
    }

    public static Student getStudentById(String id) {
        for (Student s : getAllStudents()) {
            if (s.getId().equals(id)) return s;
        }
        return null;
    }

    public static Student loginStudent(String email, String password) {
        for (Student s : getAllStudents()) {
            if (s.getEmail().equalsIgnoreCase(email) && s.getPassword().equals(password)) {
                return s;
            }
        }
        return null;
    }

    public static boolean updateStudent(Student updated) {
        List<String> lines = FileHandler.readAllLines(FileHandler.STUDENTS_FILE);
        boolean found = false;
        List<String> updatedLines = new ArrayList<>();

        for (String line : lines) {
            Student s = Student.fromFileString(line);
            if (s != null && s.getId().equals(updated.getId())) {
                updatedLines.add(updated.toFileString());
                found = true;
            } else {
                updatedLines.add(line);
            }
        }

        if (found) FileHandler.writeAllLines(FileHandler.STUDENTS_FILE, updatedLines);
        return found;
    }

    public static boolean deleteStudent(String id) {
        List<String> lines = FileHandler.readAllLines(FileHandler.STUDENTS_FILE);
        List<String> newLines = new ArrayList<>();
        boolean found = false;

        for (String line : lines) {
            Student s = Student.fromFileString(line);
            if (s != null && s.getId().equals(id)) {
                found = true;
            } else {
                newLines.add(line);
            }
        }

        if (found) FileHandler.writeAllLines(FileHandler.STUDENTS_FILE, newLines);
        return found;
    }


    public static List<Student> searchStudents(String keyword) {
        List<Student> results = new ArrayList<>();
        String kw = keyword.toLowerCase();
        for (Student s : getAllStudents()) {
            if (s.getName().toLowerCase().contains(kw)
                    || s.getEmail().toLowerCase().contains(kw)
                    || s.getPhone().toLowerCase().contains(kw)
                    || s.getIndexNumber().toLowerCase().contains(kw)
                    || s.getDepartment().toLowerCase().contains(kw)) {
                results.add(s);
            }
        }
        return results;
    }
}
