package com.sliit.courseregproject.util;

import com.sliit.courseregproject.model.Registration;
import java.time.LocalDate;
import java.util.*;


public class RegistrationService {

    public static boolean registerStudentForCourse(String studentId, String courseId) {
        
        for (Registration r : getAllRegistrations()) {
            if (r.getStudentId().equals(studentId)
                    && r.getCourseId().equals(courseId)
                    && r.getStatus().equals("ACTIVE")) {
                return false; 
            }
        }

        Registration reg = new Registration(
                FileHandler.generateId(),
                studentId,
                courseId,
                LocalDate.now().toString(),
                "ACTIVE"
        );
        FileHandler.appendLine(FileHandler.REGISTRATIONS_FILE, reg.toFileString());
        return true;
    }

    public static List<Registration> getAllRegistrations() {
        List<String> lines = FileHandler.readAllLines(FileHandler.REGISTRATIONS_FILE);
        List<Registration> list = new ArrayList<>();
        for (String line : lines) {
            Registration r = Registration.fromFileString(line);
            if (r != null) list.add(r);
        }
        return list;
    }

   
    public static List<Registration> getRegistrationsByStudent(String studentId) {
        List<Registration> results = new ArrayList<>();
        for (Registration r : getAllRegistrations()) {
            if (r.getStudentId().equals(studentId) && r.getStatus().equals("ACTIVE")) {
                results.add(r);
            }
        }
        return results;
    }

    
    public static List<Registration> getRegistrationHistoryByStudent(String studentId) {
        List<Registration> results = new ArrayList<>();
        for (Registration r : getAllRegistrations()) {
            if (r.getStudentId().equals(studentId)) {
                results.add(r);
            }
        }
        return results;
    }

  
    public static List<Registration> getRegistrationsByCourse(String courseId) {
        List<Registration> results = new ArrayList<>();
        for (Registration r : getAllRegistrations()) {
            if (r.getCourseId().equals(courseId) && r.getStatus().equals("ACTIVE")) {
                results.add(r);
            }
        }
        return results;
    }

    
    public static boolean dropCourse(String registrationId) {
        List<String> lines = FileHandler.readAllLines(FileHandler.REGISTRATIONS_FILE);
        boolean found = false;
        List<String> updatedLines = new ArrayList<>();

        for (String line : lines) {
            Registration r = Registration.fromFileString(line);
            if (r != null && r.getId().equals(registrationId)) {
                r.setStatus("DROPPED");
                updatedLines.add(r.toFileString());
                found = true;
            } else {
                updatedLines.add(line);
            }
        }

        if (found) FileHandler.writeAllLines(FileHandler.REGISTRATIONS_FILE, updatedLines);
        return found;
    }

    
    public static boolean deleteRegistration(String registrationId) {
        List<String> lines = FileHandler.readAllLines(FileHandler.REGISTRATIONS_FILE);
        List<String> newLines = new ArrayList<>();
        boolean found = false;

        for (String line : lines) {
            Registration r = Registration.fromFileString(line);
            if (r != null && r.getId().equals(registrationId)) {
                found = true;
            } else {
                newLines.add(line);
            }
        }

        if (found) FileHandler.writeAllLines(FileHandler.REGISTRATIONS_FILE, newLines);
        return found;
    }
}
