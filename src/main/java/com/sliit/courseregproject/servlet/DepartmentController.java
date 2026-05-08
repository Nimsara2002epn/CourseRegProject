package com.sliit.courseregproject.servlet;

import com.sliit.courseregproject.model.Department;
import com.sliit.courseregproject.util.DepartmentService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/departments")
public class DepartmentController {

    private boolean isAdmin(HttpSession session) {
        return "ADMIN".equals(session.getAttribute("userRole"));
    }

    @GetMapping
    public String listDepartments(HttpSession session, Model model,
                                  @RequestParam(required = false) String search) {
        if (!isAdmin(session)) return "redirect:/login";

        if (search != null && !search.isEmpty()) {
            model.addAttribute("departments", DepartmentService.searchDepartments(search));
            model.addAttribute("search", search);
        } else {
            model.addAttribute("departments", DepartmentService.getAllDepartments());
        }
        return "admin/departments";
    }

    @GetMapping("/add")
    public String addForm(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        return "admin/department-form";
    }

    @PostMapping("/add")
    public String addDepartment(HttpSession session,
                                @RequestParam String name,
                                @RequestParam String description,
                                RedirectAttributes ra) {
        if (!isAdmin(session)) return "redirect:/login";

        Department dept = new Department();
        dept.setName(name);
        dept.setDescription(description);

        boolean success = DepartmentService.addDepartment(dept);
        ra.addFlashAttribute(success ? "success" : "error",
                success ? "Department added." : "Department name already exists.");
        return "redirect:/admin/departments";
    }

    @GetMapping("/edit/{id}")
    public String editForm(HttpSession session, @PathVariable String id, Model model) {
        if (!isAdmin(session)) return "redirect:/login";
        Department d = DepartmentService.getDepartmentById(id);
        if (d == null) return "redirect:/admin/departments";
        model.addAttribute("department", d);
        return "admin/department-edit";
    }

    @PostMapping("/edit")
    public String editDepartment(HttpSession session,
                                 @RequestParam String id,
                                 @RequestParam String name,
                                 @RequestParam String description,
                                 RedirectAttributes ra) {
        if (!isAdmin(session)) return "redirect:/login";

        Department d = new Department(id, name, description);
        boolean success = DepartmentService.updateDepartment(d);
        ra.addFlashAttribute(success ? "success" : "error",
                success ? "Department updated." : "Update failed.");
        return "redirect:/admin/departments";
    }

    @GetMapping("/delete/{id}")
    public String deleteDepartment(HttpSession session, @PathVariable String id, RedirectAttributes ra) {
        if (!isAdmin(session)) return "redirect:/login";
        boolean success = DepartmentService.deleteDepartment(id);
        ra.addFlashAttribute(success ? "success" : "error",
                success ? "Department deleted." : "Not found.");
        return "redirect:/admin/departments";
    }
}
