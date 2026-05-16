<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - EduStack</title>
    <%@ include file="shared/head-assets.jspf" %>
</head>
<body class="app-auth">
<div class="login-card card">
    <div class="login-header">
        <i class="bi bi-mortarboard-fill fs-1 mb-2 d-block"></i>
        <h2>EduStack</h2>
    </div>
    <div class="login-body">
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle-fill me-2"></i>${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <form method="post" action="/login">
            <div class="mb-3">
                <label class="form-label fw-semibold">Login As</label>
                <div class="row g-2">
                    <div class="col-6">
                        <div class="role-btn active" id="roleAdmin" onclick="selectRole('ADMIN')">
                            <i class="bi bi-shield-lock text-primary"></i>
                            <span class="fw-semibold small">Admin</span>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="role-btn" id="roleStudent" onclick="selectRole('STUDENT')">
                            <i class="bi bi-person-badge text-success"></i>
                            <span class="fw-semibold small">Student</span>
                        </div>
                    </div>
                </div>
                <input type="hidden" name="role" id="roleInput" value="ADMIN">
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Email Address</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                    <input type="email" class="form-control" name="email" placeholder="Enter your email" required>
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label fw-semibold">Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
                    <input type="password" class="form-control" name="password" id="passwordField" placeholder="Enter your password" required>
                    <button class="btn btn-outline-secondary" type="button" onclick="togglePassword()">
                        <i class="bi bi-eye" id="eyeIcon"></i>
                    </button>
                </div>
            </div>

            <button type="submit" class="btn btn-login btn-primary w-100 text-white">
                <i class="bi bi-box-arrow-in-right me-2"></i>Login
            </button>
        </form>

        <hr class="my-3">
        <p class="text-center text-muted small mb-0">
            New student?
            <a href="/register" class="text-decoration-none fw-semibold">Register here</a>
        </p>

    </div>
</div>

<%@ include file="shared/app-scripts.jspf" %>
</body>
</html>
