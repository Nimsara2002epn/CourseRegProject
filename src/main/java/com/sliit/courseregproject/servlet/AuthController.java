package com.sliit.courseregproject.servlet;

import com.sliit.courseregproject.model.Student;
import com.sliit.courseregproject.model.User;
import com.sliit.courseregproject.util.DepartmentService;
import com.sliit.courseregproject.util.StudentService;
import com.sliit.courseregproject.util.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
public class AuthController {


    @GetMapping("/")
    public String home() {
        return "redirect:/login";
    }

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }


    @PostMapping("/login")
    public String processLogin(@RequestParam String email,
                               @RequestParam String password,
                               @RequestParam String role,
                               HttpSession session,
                               RedirectAttributes ra) {

        if (role.equals("ADMIN")) {

            User user = UserService.login(email, password);
            if (user != null && (user.getRole().equals("ADMIN") || user.getRole().equals("LECTURER"))) {
                session.setAttribute("loggedUser", user);
                session.setAttribute("userRole", user.getRole());
                return "redirect:/admin/dashboard";
            }
        } else if (role.equals("STUDENT")) {

            Student student = StudentService.loginStudent(email, password);
            if (student != null) {
                session.setAttribute("loggedStudent", student);
                session.setAttribute("userRole", "STUDENT");
                return "redirect:/student/dashboard";
            }
        }

        ra.addFlashAttribute("error", "Invalid email, password, or role.");
        return "redirect:/login";
    }


    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }


    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("departments", DepartmentService.getAllDepartments());
        return "register";
    }

    @PostMapping("/register")
    public String processRegister(@RequestParam String name,
                                  @RequestParam String email,
                                  @RequestParam String phone,
                                  @RequestParam String password,
                                  @RequestParam String department,
                                  RedirectAttributes ra) {

        Student student = new Student();
        student.setName(name);
        student.setEmail(email);
        student.setPhone(phone);
        student.setPassword(password);
        student.setDepartment(department);

        boolean success = StudentService.addStudent(student);

        if (success) {
            ra.addFlashAttribute("success", "Registration successful! You can now log in.");
            return "redirect:/login";
        } else {
            ra.addFlashAttribute("error", "Email already exists. Please use a different email.");
            return "redirect:/register";
        }
    }
}
