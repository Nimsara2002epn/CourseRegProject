package com.sliit.courseregproject.util;

import java.io.*;
import java.nio.file.*;
import java.util.*;

public class FileHandler {


    private static final String DATA_DIR = "data";


    public static final String USERS_FILE      = "users.txt";
    public static final String STUDENTS_FILE   = "students.txt";
    public static final String LECTURERS_FILE  = "lecturers.txt";
    public static final String DEPARTMENTS_FILE = "departments.txt";
    public static final String COURSES_FILE    = "courses.txt";
    public static final String REGISTRATIONS_FILE = "registrations.txt";
    public static final String NOTICES_FILE    = "notices.txt";

    public static String getFilePath(String fileName) {
        File dir = new File(DATA_DIR);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        return DATA_DIR + File.separator + fileName;
    }

    public static List<String> readAllLines(String fileName) {
        List<String> lines = new ArrayList<>();
        String path = getFilePath(fileName);
        File file = new File(path);

        if (!file.exists()) {
            return lines;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                line = line.trim();
                if (!line.isEmpty()) {
                    lines.add(line);
                }
            }
        } catch (IOException e) {
            System.err.println("Error reading file: " + fileName + " — " + e.getMessage());
        }

        return lines;
    }


    public static void writeAllLines(String fileName, List<String> lines) {
        String path = getFilePath(fileName);
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(path, false))) {
            for (String line : lines) {
                writer.write(line);
                writer.newLine();
            }
        } catch (IOException e) {
            System.err.println("Error writing file: " + fileName + " — " + e.getMessage());
        }
    }


    public static void appendLine(String fileName, String line) {
        String path = getFilePath(fileName);
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(path, true))) {
            writer.write(line);
            writer.newLine();
        } catch (IOException e) {
            System.err.println("Error appending to file: " + fileName + " — " + e.getMessage());
        }
    }

    public static String generateId() {
        return String.valueOf(System.currentTimeMillis()) + "_" + (int)(Math.random() * 1000);
    }

    public static boolean valueExists(String fileName, int columnIndex, String value) {
        List<String> lines = readAllLines(fileName);
        for (String line : lines) {
            String[] parts = line.split(",", -1);
            if (parts.length > columnIndex && parts[columnIndex].equalsIgnoreCase(value)) {
                return true;
            }
        }
        return false;
    }
}