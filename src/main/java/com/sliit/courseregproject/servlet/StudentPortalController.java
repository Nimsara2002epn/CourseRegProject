package com.sliit.courseregproject.servlet;

import com.sliit.courseregproject.model.*;
import com.sliit.courseregproject.util.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;


@Controller
@RequestMapping("/student")
public class StudentPortalController {

    private Student getLoggedStudent(HttpSession session) {
        return (Student) session.getAttribute("loggedStudent");
    }

    
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        Student student = getLoggedStudent(session);
        if (student == null) return "redirect:/login";

        List<Registration> registrations = RegistrationService.getRegistrationsByStudent(student.getId());
        List<Course> enrolledCourses = new ArrayList<>();
        for (Registration r : registrations) {
            Course c = CourseService.getCourseById(r.getCourseId());
            if (c != null) enrolledCourses.add(c);
        }

        model.addAttribute("student", student);
        model.addAttribute("enrolledCourses", enrolledCourses);
        model.addAttribute("notices", NoticeService.getAllNotices());
        model.addAttribute("totalCourses", CourseService.getAllCourses().size());
        return "student/dashboard";
    }

    @GetMapping("/courses")
    public String browseCourses(HttpSession session, Model model,
                                @RequestParam(required = false) String search) {
        Student student = getLoggedStudent(session);
        if (student == null) return "redirect:/login";

        List<Course> courses;
        if (search != null && !search.isEmpty()) {
            courses = CourseService.searchCourses(search);
            model.addAttribute("search", search);
        } else {
            courses = CourseService.getAllCourses();
        }

        List<String> registeredCourseIds = new ArrayList<>();
        for (Registration r : RegistrationService.getRegistrationsByStudent(student.getId())) {
            registeredCourseIds.add(r.getCourseId());
        }

        model.addAttribute("student", student);
        model.addAttribute("courses", courses);
        model.addAttribute("registeredCourseIds", registeredCourseIds);
        model.addAttribute("departments", DepartmentService.getAllDepartments());
        return "student/courses";
    }

    @PostMapping("/courses/register")
    public String registerCourse(HttpSession session,
                                 @RequestParam String courseId,
                                 RedirectAttributes ra) {
        Student student = getLoggedStudent(session);
        if (student == null) return "redirect:/login";

        boolean success = RegistrationService.registerStudentForCourse(student.getId(), courseId);
        if (success) {
            ra.addFlashAttribute("success", "Successfully registered for the course!");
        } else {
            ra.addFlashAttribute("error", "You are already registered for this course.");
        }
        return "redirect:/student/courses";
    }

    @GetMapping("/my-courses")
    public String myCourses(HttpSession session, Model model) {
        Student student = getLoggedStudent(session);
        if (student == null) return "redirect:/login";

        List<Registration> registrations = RegistrationService.getRegistrationsByStudent(student.getId());

        List<Object[]> courseDetails = new ArrayList<>();
        for (Registration r : registrations) {
            Course c = CourseService.getCourseById(r.getCourseId());
            if (c != null) {
                courseDetails.add(new Object[]{r, c});
            }
        }

        model.addAttribute("student", student);
        model.addAttribute("courseDetails", courseDetails);
        return "student/my-courses";
    }

    @PostMapping("/courses/drop")
    public String dropCourse(HttpSession session,
                             @RequestParam String registrationId,
                             RedirectAttributes ra) {
        Student student = getLoggedStudent(session);
        if (student == null) return "redirect:/login";

        boolean success = RegistrationService.dropCourse(registrationId);
        ra.addFlashAttribute(success ? "success" : "error",
                success ? "Course dropped successfully." : "Could not drop the course.");
        return "redirect:/student/my-courses";
    }

    @GetMapping("/notices")
    public String viewNotices(HttpSession session, Model model) {
        Student student = getLoggedStudent(session);
        if (student == null) return "redirect:/login";

        model.addAttribute("student", student);
        model.addAttribute("notices", NoticeService.getAllNotices());
        return "student/notices";
    }

    @GetMapping("/profile")
    public String viewProfile(HttpSession session, Model model) {
        Student student = getLoggedStudent(session);
        if (student == null) return "redirect:/login";
        model.addAttribute("student", student);
        return "student/profile";
    }

    @PostMapping("/profile/update")
    public String updateProfile(HttpSession session,
                                @RequestParam String name,
                                @RequestParam String phone,
                                @RequestParam String password,
                                RedirectAttributes ra) {
        Student student = getLoggedStudent(session);
        if (student == null) return "redirect:/login";

        student.setName(name);
        student.setPhone(phone);
        if (password != null && !password.isEmpty()) {
            student.setPassword(password);
        }

        boolean success = StudentService.updateStudent(student);
        if (success) {
            session.setAttribute("loggedStudent", student); 
            ra.addFlashAttribute("success", "Profile updated successfully.");
        } else {
            ra.addFlashAttribute("error", "Profile update failed.");
        }
        return "redirect:/student/profile";
    }
}
