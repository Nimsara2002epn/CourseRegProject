package com.sliit.courseregproject.servlet;

import com.sliit.courseregproject.model.Notice;
import com.sliit.courseregproject.model.User;
import com.sliit.courseregproject.util.NoticeService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/notices")
public class NoticeController {

    private boolean isAdmin(HttpSession session) {
        return "ADMIN".equals(session.getAttribute("userRole"));
    }

    @GetMapping
    public String listNotices(HttpSession session, Model model) {
        if (!isAdmin(session)) return "redirect:/login";
        model.addAttribute("notices", NoticeService.getAllNotices());
        return "admin/notices";
    }

    @GetMapping("/add")
    public String addForm(HttpSession session) {
        if (!isAdmin(session)) return "redirect:/login";
        return "admin/notice-form";
    }

    @PostMapping("/add")
    public String addNotice(HttpSession session,
                            @RequestParam String title,
                            @RequestParam String content,
                            RedirectAttributes ra) {
        if (!isAdmin(session)) return "redirect:/login";

        User admin = (User) session.getAttribute("loggedUser");
        Notice notice = new Notice();
        notice.setTitle(title);
        notice.setContent(content);
        notice.setPostedBy(admin != null ? admin.getName() : "Admin");

        NoticeService.addNotice(notice);
        ra.addFlashAttribute("success", "Notice posted successfully.");
        return "redirect:/admin/notices";
    }

    @GetMapping("/edit/{id}")
    public String editForm(HttpSession session, @PathVariable String id, Model model) {
        if (!isAdmin(session)) return "redirect:/login";
        Notice n = NoticeService.getNoticeById(id);
        if (n == null) return "redirect:/admin/notices";
        model.addAttribute("notice", n);
        return "admin/notice-edit";
    }

    @PostMapping("/edit")
    public String editNotice(HttpSession session,
                             @RequestParam String id,
                             @RequestParam String title,
                             @RequestParam String content,
                             RedirectAttributes ra) {
        if (!isAdmin(session)) return "redirect:/login";

        Notice existing = NoticeService.getNoticeById(id);
        if (existing != null) {
            existing.setTitle(title);
            existing.setContent(content);
            NoticeService.updateNotice(existing);
            ra.addFlashAttribute("success", "Notice updated.");
        } else {
            ra.addFlashAttribute("error", "Notice not found.");
        }
        return "redirect:/admin/notices";
    }

    @GetMapping("/delete/{id}")
    public String deleteNotice(HttpSession session, @PathVariable String id, RedirectAttributes ra) {
        if (!isAdmin(session)) return "redirect:/login";
        boolean success = NoticeService.deleteNotice(id);
        ra.addFlashAttribute(success ? "success" : "error",
                success ? "Notice deleted." : "Not found.");
        return "redirect:/admin/notices";
    }
}
