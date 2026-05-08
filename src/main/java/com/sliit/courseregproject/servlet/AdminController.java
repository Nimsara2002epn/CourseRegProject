package com.sliit.courseregproject.servlet;

import com.sliit.courseregproject.model.User;
import com.sliit.courseregproject.util.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
@RequestMapping("/admin")
public class AdminController {

    private boolean isAdmin(HttpSession session) {
        String role = (String) session.getAttribute("userRole");
        return "ADMIN".equals(role);
    }


    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (session.getAttribute("loggedUser") == null && session.getAttribute("loggedStudent") == null) {
            return "redirect:/login";
        }

        model.addAttribute("totalStudents",    StudentService.getAllStudents().size());
        model.addAttribute("totalLecturers",   LecturerService.getAllLecturers().size());
        model.addAttribute("totalCourses",     CourseService.getAllCourses().size());
        model.addAttribute("totalDepartments", DepartmentService.getAllDepartments().size());
        model.addAttribute("recentNotices",    NoticeService.getAllNotices());
        model.addAttribute("userRole",         session.getAttribute("userRole"));
        model.addAttribute("loggedUser",       session.getAttribute("loggedUser"));
        return "admin/dashboard";
    }

    @GetMapping("/users")
    public String listUsers(HttpSession session, Model model,
                            @RequestParam(required = false) String search) {
        if (!isAdmin(session)) return "redirect:/login";

        if (search != null && !search.isEmpty()) {
            model.addAttribute("users", UserService.searchUsers(search));
            model.addAttribute("search", search);
        } else {
            model.addAttribute("users", UserService.getAllUsers());
        }
        return "admin/users";
    }

    @GetMapping("/users/add")
    public String addUserForm(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        return "admin/user-form";
    }

    @PostMapping("/users/add")
    public String addUser(HttpSession session,
                          @RequestParam String name,
                          @RequestParam String email,
                          @RequestParam String phone,
                          @RequestParam String password,
                          @RequestParam String role,
                          RedirectAttributes ra) {
        if (!isAdmin(session)) return "redirect:/login";

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPhone(phone);
        user.setPassword(password);
        user.setRole(role);

        boolean success = UserService.addUser(user);
        if (success) {
            ra.addFlashAttribute("success", "User added successfully.");
        } else {
            ra.addFlashAttribute("error", "Email already exists.");
        }
        return "redirect:/admin/users";
    }


    @GetMapping("/users/edit/{id}")
    public String editUserForm(HttpSession session, @PathVariable String id, Model model) {
        if (!isAdmin(session)) return "redirect:/login";
        User user = UserService.getUserById(id);
        if (user == null) return "redirect:/admin/users";
        model.addAttribute("user", user);
        return "admin/user-edit";
    }

    @PostMapping("/users/edit")
    public String editUser(HttpSession session,
                           @RequestParam String id,
                           @RequestParam String name,
                           @RequestParam String email,
                           @RequestParam String phone,
                           @RequestParam String password,
                           @RequestParam String role,
                           RedirectAttributes ra) {
        if (!isAdmin(session)) return "redirect:/login";

        User user = new User(id, name, email, phone, password, role);
        boolean success = UserService.updateUser(user);
        ra.addFlashAttribute(success ? "success" : "error",
                success ? "User updated successfully." : "Update failed.");
        return "redirect:/admin/users";
    }


    @GetMapping("/users/delete/{id}")
    public String deleteUser(HttpSession session, @PathVariable String id, RedirectAttributes ra) {
        if (!isAdmin(session)) return "redirect:/login";
        boolean success = UserService.deleteUser(id);
        ra.addFlashAttribute(success ? "success" : "error",
                success ? "User deleted." : "User not found.");
        return "redirect:/admin/users";
    }
}
