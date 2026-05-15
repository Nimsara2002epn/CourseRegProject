package com.sliit.courseregproject.util;

import com.sliit.courseregproject.model.User;
import jakarta.annotation.PostConstruct;
import org.springframework.stereotype.Component;


@Component
public class SampleAdmin {

    @PostConstruct
    public void seedData() {
        seedAdminUser();
    }

    private void seedAdminUser() {
        if (!UserService.getAllUsers().isEmpty()) {
            return;
        }

        User admin = new User();
        admin.setName("First Admin");
        admin.setEmail("admin@gmail.lk");
        admin.setPhone("0112345678");
        admin.setPassword("admin123");
        admin.setRole("ADMIN");
        UserService.addUser(admin);


    }
}
