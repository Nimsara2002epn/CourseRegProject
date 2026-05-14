<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile</title>
    <%@ include file="../shared/head-assets.jspf" %>
    <c:set var="currentPage" value="profile"/><c:set var="pageTitle" value="My Profile"/>
</head>
<body>
<%@ include file="navbar.jsp" %>

<c:if test="${not empty success}"><div class="alert alert-success alert-dismissible fade show"><i class="bi bi-check-circle-fill me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
<c:if test="${not empty error}"><div class="alert alert-danger alert-dismissible fade show"><i class="bi bi-exclamation-triangle-fill me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>

<h4 class="fw-bold mb-4"><i class="bi bi-person-circle text-success me-2"></i>My Profile</h4>

<div class="row g-3">
    <!-- Profile Info Card -->
    <div class="col-md-4">
        <div class="card text-center">
            <div class="card-body py-4">
                <div class="rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center"
                     style="width:80px;height:80px;background:linear-gradient(135deg,#2e7d32,#66bb6a)">
                    <i class="bi bi-person-fill text-white" style="font-size:2.5rem"></i>
                </div>
                <h5 class="fw-bold mb-1">${student.name}</h5>
                <p class="text-muted mb-1">${student.email}</p>
                <span class="badge bg-success mb-2">${student.indexNumber}</span>
                <p class="text-muted small mb-0">${student.department}</p>
            </div>
        </div>
    </div>

    <!-- Edit Profile Form -->
    <div class="col-md-8">
        <div class="card">
            <div class="card-header bg-white fw-semibold border-0">
                <i class="bi bi-pencil-square text-success me-2"></i>Update Profile
            </div>
            <div class="card-body">
                <form method="post" action="/student/profile/update">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Full Name *</label>
                            <input type="text" class="form-control" name="name" value="${student.name}" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-semibold">Phone Number *</label>
                            <input type="text" class="form-control" name="phone" value="${student.phone}" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold">Email Address</label>
                            <input type="email" class="form-control bg-light" value="${student.email}" disabled>
                            <div class="form-text">Email cannot be changed. Contact admin to update.</div>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-semibold">New Password</label>
                            <input type="password" class="form-control" name="password" placeholder="Leave blank to keep current password">
                        </div>
                    </div>
                    <hr class="my-3">
                    <button type="submit" class="btn btn-success">
                        <i class="bi bi-check-lg me-1"></i>Update Profile
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

    </div></div>
<%@ include file="../shared/app-scripts.jspf" %>
</body></html>
