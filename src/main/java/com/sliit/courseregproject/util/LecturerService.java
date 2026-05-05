package com.sliit.courseregproject.util;

import com.sliit.courseregproject.model.Lecturer;
import java.util.*;

public class LecturerService {

    public static boolean addLecturer(Lecturer lecturer) {
        if (FileHandler.valueExists(FileHandler.LECTURERS_FILE, 2, lecturer.getEmail())) {
            return false;
        }
        lecturer.setId(FileHandler.generateId());
        FileHandler.appendLine(FileHandler.LECTURERS_FILE, lecturer.toFileString());
        return true;
    }

    public static List<Lecturer> getAllLecturers() {
        List<String> lines = FileHandler.readAllLines(FileHandler.LECTURERS_FILE);
        List<Lecturer> lecturers = new ArrayList<>();
        for (String line : lines) {
            Lecturer l = Lecturer.fromFileString(line);
            if (l != null) lecturers.add(l);
        }
        return lecturers;
    }

    public static Lecturer getLecturerById(String id) {
        for (Lecturer l : getAllLecturers()) {
            if (l.getId().equals(id)) return l;
        }
        return null;
    }

    public static boolean updateLecturer(Lecturer updated) {
        List<String> lines = FileHandler.readAllLines(FileHandler.LECTURERS_FILE);
        boolean found = false;
        List<String> updatedLines = new ArrayList<>();

        for (String line : lines) {
            Lecturer l = Lecturer.fromFileString(line);
            if (l != null && l.getId().equals(updated.getId())) {
                updatedLines.add(updated.toFileString());
                found = true;
            } else {
                updatedLines.add(line);
            }
        }

        if (found) FileHandler.writeAllLines(FileHandler.LECTURERS_FILE, updatedLines);
        return found;
    }

    public static boolean deleteLecturer(String id) {
        List<String> lines = FileHandler.readAllLines(FileHandler.LECTURERS_FILE);
        List<String> newLines = new ArrayList<>();
        boolean found = false;

        for (String line : lines) {
            Lecturer l = Lecturer.fromFileString(line);
            if (l != null && l.getId().equals(id)) {
                found = true;
            } else {
                newLines.add(line);
            }
        }

        if (found) FileHandler.writeAllLines(FileHandler.LECTURERS_FILE, newLines);
        return found;
    }

    public static List<Lecturer> searchLecturers(String keyword) {
        List<Lecturer> results = new ArrayList<>();
        String kw = keyword.toLowerCase();
        for (Lecturer l : getAllLecturers()) {
            if (l.getName().toLowerCase().contains(kw)
                    || l.getEmail().toLowerCase().contains(kw)
                    || l.getPhone().toLowerCase().contains(kw)
                    || l.getDepartment().toLowerCase().contains(kw)
                    || l.getSpecialization().toLowerCase().contains(kw)) {
                results.add(l);
            }
        }
        return results;
    }
}
