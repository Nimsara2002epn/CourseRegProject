package com.sliit.courseregproject.util;

import com.sliit.courseregproject.model.Notice;
import java.time.LocalDate;
import java.util.*;

public class NoticeService {

    public static void addNotice(Notice notice) {
        notice.setId(FileHandler.generateId());
        if (notice.getPostedDate() == null || notice.getPostedDate().isEmpty()) {
            notice.setPostedDate(LocalDate.now().toString());
        }
        FileHandler.appendLine(FileHandler.NOTICES_FILE, notice.toFileString());
    }

    public static List<Notice> getAllNotices() {
        List<String> lines = FileHandler.readAllLines(FileHandler.NOTICES_FILE);
        List<Notice> notices = new ArrayList<>();
        for (String line : lines) {
            Notice n = Notice.fromFileString(line);
            if (n != null) notices.add(n);
        }
        
        notices.sort((a, b) -> b.getPostedDate().compareTo(a.getPostedDate()));
        return notices;
    }

    public static Notice getNoticeById(String id) {
        for (Notice n : getAllNotices()) {
            if (n.getId().equals(id)) return n;
        }
        return null;
    }

    public static boolean updateNotice(Notice updated) {
        List<String> lines = FileHandler.readAllLines(FileHandler.NOTICES_FILE);
        boolean found = false;
        List<String> updatedLines = new ArrayList<>();

        for (String line : lines) {
            Notice n = Notice.fromFileString(line);
            if (n != null && n.getId().equals(updated.getId())) {
                updatedLines.add(updated.toFileString());
                found = true;
            } else {
                updatedLines.add(line);
            }
        }

        if (found) FileHandler.writeAllLines(FileHandler.NOTICES_FILE, updatedLines);
        return found;
    }

    public static boolean deleteNotice(String id) {
        List<String> lines = FileHandler.readAllLines(FileHandler.NOTICES_FILE);
        List<String> newLines = new ArrayList<>();
        boolean found = false;

        for (String line : lines) {
            Notice n = Notice.fromFileString(line);
            if (n != null && n.getId().equals(id)) {
                found = true;
            } else {
                newLines.add(line);
            }
        }

        if (found) FileHandler.writeAllLines(FileHandler.NOTICES_FILE, newLines);
        return found;
    }
}
