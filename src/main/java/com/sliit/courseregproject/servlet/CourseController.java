package com.sliit.courseregproject.servlet;

import com.sliit.courseregproject.model.Course;
import com.sliit.courseregproject.util.CourseService;
import com.sliit.courseregproject.util.DepartmentService;
import com.sliit.courseregproject.util.LecturerService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/courses")
public class CourseController {

    private boolean isAdmin(HttpSession session) {
        return "ADMIN".equals(session.getAttribute("userRole"));
    }

    @GetMapping
    public String listCourses(HttpSession session, Model model,
                              @RequestParam(required = false) String search,
                              @RequestParam(required = false) String departmentId) {
        if (session.getAttribute("loggedUser") == null) return "redirect:/login";

        if (search != null && !search.isEmpty()) {
            model.addAttribute("courses", CourseService.searchCourses(search));
            model.addAttribute("search", search);
        } else if (departmentId != null && !departmentId.isEmpty()) {
            model.addAttribute("courses", CourseService.getCoursesByDepartment(departmentId));
            model.addAttribute("filterDept", departmentId);
        } else {
            model.addAttribute("courses", CourseService.getAllCourses());
        }

        model.addAttribute("departments", DepartmentService.getAllDepartments());
        model.addAttribute("lecturers", LecturerService.getAllLecturers());
        return "admin/courses";
    }

    @GetMapping("/add")
    public String addForm(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login";
        model.addAttribute("departments", DepartmentService.getAllDepartments());
        model.addAttribute("lecturers", LecturerService.getAllLecturers());
        return "admin/course-form";
    }

    @PostMapping("/add")
    public String addCourse(HttpSession session,
                            @RequestParam String name,
                            @RequestParam String code,
                            @RequestParam String departmentId,
                            @RequestParam String lecturerId,
                            @RequestParam String credits,
                            @RequestParam String description,
                            RedirectAttributes ra) {
        if (!isAdmin(session)) return "redirect:/login";

        Course c = new Course();
        c.setName(name);
        c.setCode(code);
        c.setDepartmentId(departmentId);
        c.setLecturerId(lecturerId);
        c.setCredits(credits);
        c.setDescription(description);

        boolean success = CourseService.addCourse(c);
        ra.addFlashAttribute(success ? "success" : "error",
                success ? "Course added." : "Course code already exists.");
        return "redirect:/admin/courses";
    }

    @GetMapping("/edit/{id}")
    public String editForm(HttpSession session, @PathVariable String id, Model model) {
        if (!isAdmin(session)) return "redirect:/login";
        Course c = CourseService.getCourseById(id);
        if (c == null) return "redirect:/admin/courses";
        model.addAttribute("course", c);
        model.addAttribute("departments", DepartmentService.getAllDepartments());
        model.addAttribute("lecturers", LecturerService.getAllLecturers());
        return "admin/course-edit";
    }

    @PostMapping("/edit")
    public String editCourse(HttpSession session,
                             @RequestParam String id,
                             @RequestParam String name,
                             @RequestParam String code,
                             @RequestParam String departmentId,
                             @RequestParam String lecturerId,
                             @RequestParam String credits,
                             @RequestParam String description,
                             RedirectAttributes ra) {
        if (!isAdmin(session)) return "redirect:/login";

        Course c = new Course(id, name, code, departmentId, lecturerId, credits, description);
        boolean success = CourseService.updateCourse(c);
        ra.addFlashAttribute(success ? "success" : "error",
                success ? "Course updated." : "Update failed.");
        return "redirect:/admin/courses";
    }

    @GetMapping("/delete/{id}")
    public String deleteCourse(HttpSession session, @PathVariable String id, RedirectAttributes ra) {
        if (!isAdmin(session)) return "redirect:/login";
        boolean success = CourseService.deleteCourse(id);
        ra.addFlashAttribute(success ? "success" : "error",
                success ? "Course deleted." : "Not found.");
        return "redirect:/admin/courses";
    }
}
