<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - EduStack</title>
    <%@ include file="shared/head-assets.jspf" %>
</head>
<body class="app-auth">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="reg-card card">
                <div class="reg-header">
                    <h4 class="mb-0"><i class="bi bi-person-plus-fill me-2"></i>EduStack Student Registration</h4>
                </div>
                <div class="card-body p-4">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger"><i class="bi bi-exclamation-triangle-fill me-2"></i>${error}</div>
                    </c:if>

                    <form method="post" action="/register">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Full Name *</label>
                                <input type="text" class="form-control" name="name" placeholder="e.g. Nimsara Perera" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Index Number *</label>
                                <input type="text" class="form-control" name="indexNumber" placeholder="e.g. IT/2022/001" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-semibold">Email Address *</label>
                                <input type="email" class="form-control" name="email" placeholder="student@university.lk" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Phone Number *</label>
                                <input type="text" class="form-control" name="phone" placeholder="07XXXXXXXX" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Department *</label>
                                <input type="text" class="form-control" name="department" placeholder="e.g. Software Engineering" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-semibold">Password *</label>
                                <input type="password" class="form-control" name="password" placeholder="Choose a password" required>
                            </div>
                        </div>

                        <div class="d-grid mt-4">
                            <button type="submit" class="btn btn-register btn-primary text-white">
                                <i class="bi bi-person-check-fill me-2"></i>Register Now
                            </button>
                        </div>
                    </form>

                    <hr class="my-3">
                    <p class="text-center text-muted small mb-0">
                        Already have an account? <a href="/login" class="text-decoration-none fw-semibold">Login here</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="shared/app-scripts.jspf" %>
</body>
</html>
