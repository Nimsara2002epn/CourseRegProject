package com.sliit.courseregproject.model;

public class Student extends User {

private String indexNumber; 
private String department;

public Student() {
super();
setRole("STUDENT");
}

public Student(String id, String name, String email, String phone,
String password, String indexNumber, String department) {
super(id, name, email, phone, password, "STUDENT");
this.indexNumber = indexNumber;
this.department = department;
}

public String getIndexNumber() { return indexNumber; }
public void setIndexNumber(String indexNumber) { this.indexNumber = indexNumber; }

public String getDepartment() { return department; }
public void setDepartment(String department) { this.department = department; }

@Override
public String getDisplayInfo() {
return "Student: " + getName() + " [" + indexNumber + "] | " + getDepartment();
}

@Override
public String toFileString() {
return super.toFileString() + "," + indexNumber + "," + department;
}

public static Student fromFileString(String line) {
String[] parts = line.split(",", -1);
if (parts.length < 8) return null;
Student s = new Student();
s.setId(parts[0]);
s.setName(parts[1]);
s.setEmail(parts[2]);
s.setPhone(parts[3]);
s.setPassword(parts[4]);
s.setRole(parts[5]);
s.setIndexNumber(parts[6]);
s.setDepartment(parts[7]);
return s;
}
}


On Mon, 4 May 2026 at 13:30, Thisara Ishanga <ishangathisara80@gmail.com> wrote:
package com.studentreg.util;

import com.studentreg.model.Student;
import java.util.*;

public class StudentService {

public static boolean addStudent(Student student) {
if (FileHandler.valueExists(FileHandler.STUDENTS_FILE, 2, student.getEmail())) {
return false; // Duplicate email
}
student.setId(FileHandler.generateId());
FileHandler.appendLine(FileHandler.STUDENTS_FILE, student.toFileString());
return true;
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


On Mon, 4 May 2026 at 12:40, Thisara Ishanga <ishangathisara80@gmail.com> wrote:
package com.studentreg.model;

public class Student extends User {

private String indexNumber; // e.g., IT/2022/001
private String department;

public Student() {
super();
setRole("STUDENT");
}

public Student(String id, String name, String email, String phone,
String password, String indexNumber, String department) {
super(id, name, email, phone, password, "STUDENT");
this.indexNumber = indexNumber;
this.department = department;
}

public String getIndexNumber() { return indexNumber; }
public void setIndexNumber(String indexNumber) { this.indexNumber = indexNumber; }

public String getDepartment() { return department; }
public void setDepartment(String department) { this.department = department; }

@Override
public String getDisplayInfo() {
return "Student: " + getName() + " [" + indexNumber + "] | " + getDepartment();
}

@Override
public String toFileString() {
return super.toFileString() + "," + indexNumber + "," + department;
}

public static Student fromFileString(String line) {
String[] parts = line.split(",", -1);
if (parts.length < 8) return null;
Student s = new Student();
s.setId(parts[0]);
s.setName(parts[1]);
s.setEmail(parts[2]);
s.setPhone(parts[3]);
s.setPassword(parts[4]);
s.setRole(parts[5]);
s.setIndexNumber(parts[6]);
s.setDepartment(parts[7]);
return s;
}
}
