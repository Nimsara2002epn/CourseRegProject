package com.sliit.courseregproject.servlet;

import com.sliit.courseregproject.model.Course;
import com.sliit.courseregproject.model.Registration;
import com.sliit.courseregproject.model.Student;
import com.sliit.courseregproject.util.CourseService;
import com.sliit.courseregproject.util.DepartmentService;
import com.sliit.courseregproject.util.LecturerService;
import com.sliit.courseregproject.util.RegistrationService;
import com.sliit.courseregproject.util.StudentService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;


@Controller
@RequestMapping("/admin/students")
public class StudentController {

    private boolean hasAccess(HttpSession session) {
        String role = (String) session.getAttribute("userRole");
        return "ADMIN".equals(role) || "LECTURER".equals(role);
    }

    @GetMapping
    public String listStudents(HttpSession session, Model model,
                               @RequestParam(required = false) String search) {
        if (!hasAccess(session)) return "redirect:/login";

        if (search != null && !search.isEmpty()) {
            model.addAttribute("students", StudentService.searchStudents(search));
            model.addAttribute("search", search);
        } else {
            model.addAttribute("students", StudentService.getAllStudents());
        }
        return "admin/students";
    }

    @GetMapping("/{id}")
    public String viewStudent(HttpSession session, @PathVariable String id, Model model,
                              RedirectAttributes ra) {
        if (!hasAccess(session)) return "redirect:/login";

        Student student = StudentService.getStudentById(id);
        if (student == null) {
            ra.addFlashAttribute("error", "Student not found.");
            return "redirect:/admin/students";
        }

        List<StudentCourseView> registrations = new ArrayList<>();
        for (Registration registration : RegistrationService.getRegistrationHistoryByStudent(id)) {
            Course course = CourseService.getCourseById(registration.getCourseId());
            String lecturerName = "-";
            if (course != null) {
                var lecturer = LecturerService.getLecturerById(course.getLecturerId());
                lecturerName = lecturer != null ? lecturer.getName() : "Unassigned";
            }

            registrations.add(new StudentCourseView(
                    registration.getId(),
                    registration.getRegistrationDate(),
                    registration.getStatus(),
                    course != null ? course.getName() : "Unknown course",
                    course != null ? course.getCode() : "-",
                    course != null ? course.getCredits() : "-",
                    course != null ? DepartmentService.getDepartmentNameById(course.getDepartmentId()) : "-",
                    lecturerName
            ));
        }

        model.addAttribute("student", student);
        model.addAttribute("registeredCourses", registrations);
        return "admin/student-view";
    }

    @GetMapping("/add")
    public String addForm(HttpSession session) {
        if (!hasAccess(session)) return "redirect:/login";
        return "admin/student-form";
    }

    @PostMapping("/add")
    public String addStudent(HttpSession session,
                             @RequestParam String name,
                             @RequestParam String email,
                             @RequestParam String phone,
                             @RequestParam String password,
                             @RequestParam String indexNumber,
                             @RequestParam String department,
                             RedirectAttributes ra) {
        if (!hasAccess(session)) return "redirect:/login";

        Student s = new Student();
        s.setName(name);
        s.setEmail(email);
        s.setPhone(phone);
        s.setPassword(password);
        s.setIndexNumber(indexNumber);
        s.setDepartment(department);

        boolean success = StudentService.addStudent(s);
        ra.addFlashAttribute(success ? "success" : "error",
                success ? "Student added successfully." : "Email already exists.");
        return "redirect:/admin/students";
    }

    @GetMapping("/edit/{id}")
    public String editForm(HttpSession session, @PathVariable String id, Model model) {
        if (!hasAccess(session)) return "redirect:/login";
        Student s = StudentService.getStudentById(id);
        if (s == null) return "redirect:/admin/students";
        model.addAttribute("student", s);
        return "admin/student-edit";
    }

    @PostMapping("/edit")
    public String editStudent(HttpSession session,
                              @RequestParam String id,
                              @RequestParam String name,
                              @RequestParam String email,
                              @RequestParam String phone,
                              @RequestParam String password,
                              @RequestParam String indexNumber,
                              @RequestParam String department,
                              RedirectAttributes ra) {
        if (!hasAccess(session)) return "redirect:/login";

        Student s = new Student(id, name, email, phone, password, indexNumber, department);
        boolean success = StudentService.updateStudent(s);
        ra.addFlashAttribute(success ? "success" : "error",
                success ? "Student updated." : "Update failed.");
        return "redirect:/admin/students";
    }

    @GetMapping("/delete/{id}")
    public String deleteStudent(HttpSession session, @PathVariable String id, RedirectAttributes ra) {
        if (!hasAccess(session)) return "redirect:/login";
        boolean success = StudentService.deleteStudent(id);
        ra.addFlashAttribute(success ? "success" : "error",
                success ? "Student deleted." : "Student not found.");
        return "redirect:/admin/students";
    }

    public static class StudentCourseView {
        private final String registrationId;
        private final String registrationDate;
        private final String status;
        private final String courseName;
        private final String courseCode;
        private final String credits;
        private final String departmentName;
        private final String lecturerName;

        public StudentCourseView(String registrationId, String registrationDate, String status,
                                 String courseName, String courseCode, String credits,
                                 String departmentName, String lecturerName) {
            this.registrationId = registrationId;
            this.registrationDate = registrationDate;
            this.status = status;
            this.courseName = courseName;
            this.courseCode = courseCode;
            this.credits = credits;
            this.departmentName = departmentName;
            this.lecturerName = lecturerName;
        }

        public String getRegistrationId() {
            return registrationId;
        }

        public String getRegistrationDate() {
            return registrationDate;
        }

        public String getStatus() {
            return status;
        }

        public String getCourseName() {
            return courseName;
        }

        public String getCourseCode() {
            return courseCode;
        }

        public String getCredits() {
            return credits;
        }

        public String getDepartmentName() {
            return departmentName;
        }

        public String getLecturerName() {
            return lecturerName;
        }
    }
}

