<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Student</title>
    <%@ include file="../shared/head-assets.jspf" %>
    <c:set var="currentPage" value="students"/>
    <c:set var="pageTitle" value="Edit Student"/>
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="d-flex align-items-center gap-2 mb-4">
    <a href="/admin/students" class="btn btn-sm btn-outline-secondary"><i class="bi bi-arrow-left"></i></a>
    <h4 class="fw-bold mb-0"><i class="bi bi-pencil-square text-warning me-2"></i>Edit Student</h4>
</div>

<div class="card" style="max-width:680px">
    <div class="card-body p-4">
        <form method="post" action="/admin/students/edit">
            <input type="hidden" name="id" value="${student.id}">
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Full Name *</label>
                    <input type="text" class="form-control" name="name" value="${student.name}" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Index Number *</label>
                    <input type="text" class="form-control" name="indexNumber" value="${student.indexNumber}" required>
                </div>
                <div class="col-12">
                    <label class="form-label fw-semibold">Email Address *</label>
                    <input type="email" class="form-control" name="email" value="${student.email}" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Phone Number *</label>
                    <input type="text" class="form-control" name="phone" value="${student.phone}" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Department *</label>
                    <input type="text" class="form-control" name="department" value="${student.department}" required>
                </div>
                <div class="col-12">
                    <label class="form-label fw-semibold">Password *</label>
                    <input type="password" class="form-control" name="password" value="${student.password}" required>
                </div>
            </div>
            <hr class="my-3">
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-warning"><i class="bi bi-check-lg me-1"></i>Update Student</button>
                <a href="/admin/students" class="btn btn-outline-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>

    </div></div>
<%@ include file="../shared/app-scripts.jspf" %>
</body></html>

