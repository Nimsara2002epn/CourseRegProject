<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit User</title>
    <%@ include file="../shared/head-assets.jspf" %>
    <c:set var="currentPage" value="users"/><c:set var="pageTitle" value="Edit System User"/>
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="d-flex align-items-center gap-2 mb-4">
    <a href="/admin/users" class="btn btn-sm btn-outline-secondary"><i class="bi bi-arrow-left"></i></a>
    <h4 class="fw-bold mb-0"><i class="bi bi-pencil-square text-warning me-2"></i>Edit User</h4>
</div>
<div class="card" style="max-width:600px">
    <div class="card-body p-4">
        <form method="post" action="/admin/users/edit">
            <input type="hidden" name="id" value="${user.id}">
            <div class="row g-3">
                <div class="col-12"><label class="form-label fw-semibold">Full Name *</label><input type="text" class="form-control" name="name" value="${user.name}" required></div>
                <div class="col-12"><label class="form-label fw-semibold">Email Address *</label><input type="email" class="form-control" name="email" value="${user.email}" required></div>
                <div class="col-md-6"><label class="form-label fw-semibold">Phone *</label><input type="text" class="form-control" name="phone" value="${user.phone}" required></div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Role *</label>
                    <input type="text" class="form-control" value="Admin" readonly>
                    <input type="hidden" name="role" value="ADMIN">
                </div>
                <div class="col-12"><label class="form-label fw-semibold">Password *</label><input type="password" class="form-control" name="password" value="${user.password}" required></div>
            </div>
            <hr class="my-3">
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-warning"><i class="bi bi-check-lg me-1"></i>Update User</button>
                <a href="/admin/users" class="btn btn-outline-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>
    </div></div>
<%@ include file="../shared/app-scripts.jspf" %>
</body></html>

