package com.sliit.courseregproject.servlet;

import com.sliit.courseregproject.model.Lecturer;
import com.sliit.courseregproject.util.DepartmentService;
import com.sliit.courseregproject.util.LecturerService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
@RequestMapping("/admin/lecturers")
public class LecturerController {

    private boolean isAdmin(HttpSession session) {
        return "ADMIN".equals(session.getAttribute("userRole"));
    }

    @GetMapping
    public String listLecturers(HttpSession session, Model model,
                                @RequestParam(required = false) String search) {
        if (session.getAttribute("loggedUser") == null) return "redirect:/login";

        if (search != null && !search.isEmpty()) {
            model.addAttribute("lecturers", LecturerService.searchLecturers(search));
            model.addAttribute("search", search);
        } else {
            model.addAttribute("lecturers", LecturerService.getAllLecturers());
        }
        return "admin/lecturers";
    }

    @GetMapping("/add")
    public String addForm(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login";
        model.addAttribute("departments", DepartmentService.getAllDepartments());
        return "admin/lecturer-form";
    }

    @PostMapping("/add")
    public String addLecturer(HttpSession session,
                              @RequestParam String name,
                              @RequestParam String email,
                              @RequestParam String phone,
                              @RequestParam String password,
                              @RequestParam String staffId,
                              @RequestParam String department,
                              @RequestParam String specialization,
                              RedirectAttributes ra) {
        if (!isAdmin(session)) return "redirect:/login";

        Lecturer l = new Lecturer();
        l.setName(name);
        l.setEmail(email);
        l.setPhone(phone);
        l.setPassword(password);
        l.setStaffId(staffId);
        l.setDepartment(department);
        l.setSpecialization(specialization);

        boolean success = LecturerService.addLecturer(l);
        ra.addFlashAttribute(success ? "success" : "error",
                success ? "Lecturer added successfully." : "Email already exists.");
        return "redirect:/admin/lecturers";
    }

    @GetMapping("/edit/{id}")
    public String editForm(HttpSession session, @PathVariable String id, Model model) {
        if (!isAdmin(session)) return "redirect:/login";
        Lecturer l = LecturerService.getLecturerById(id);
        if (l == null) return "redirect:/admin/lecturers";
        model.addAttribute("lecturer", l);
        model.addAttribute("departments", DepartmentService.getAllDepartments());
        return "admin/lecturer-edit";
    }

    @PostMapping("/edit")
    public String editLecturer(HttpSession session,
                               @RequestParam String id,
                               @RequestParam String name,
                               @RequestParam String email,
                               @RequestParam String phone,
                               @RequestParam String password,
                               @RequestParam String staffId,
                               @RequestParam String department,
                               @RequestParam String specialization,
                               RedirectAttributes ra) {
        if (!isAdmin(session)) return "redirect:/login";

        Lecturer l = new Lecturer(id, name, email, phone, password, staffId, department, specialization);
        boolean success = LecturerService.updateLecturer(l);
        ra.addFlashAttribute(success ? "success" : "error",
                success ? "Lecturer updated." : "Update failed.");
        return "redirect:/admin/lecturers";
    }

    @GetMapping("/delete/{id}")
    public String deleteLecturer(HttpSession session, @PathVariable String id, RedirectAttributes ra) {
        if (!isAdmin(session)) return "redirect:/login";
        boolean success = LecturerService.deleteLecturer(id);
        ra.addFlashAttribute(success ? "success" : "error",
                success ? "Lecturer deleted." : "Lecturer not found.");
        return "redirect:/admin/lecturers";
    }
}
