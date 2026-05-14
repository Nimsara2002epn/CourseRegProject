<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Lecturer</title>
    <%@ include file="../shared/head-assets.jspf" %>
    <c:set var="currentPage" value="lecturers"/><c:set var="pageTitle" value="Edit Lecturer"/>
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="d-flex align-items-center gap-2 mb-4">
    <a href="/admin/lecturers" class="btn btn-sm btn-outline-secondary"><i class="bi bi-arrow-left"></i></a>
    <h4 class="fw-bold mb-0"><i class="bi bi-pencil-square text-warning me-2"></i>Edit Lecturer</h4>
</div>
<div class="card" style="max-width:680px">
    <div class="card-body p-4">
        <form method="post" action="/admin/lecturers/edit">
            <input type="hidden" name="id" value="${lecturer.id}">
            <div class="row g-3">
                <div class="col-md-6"><label class="form-label fw-semibold">Full Name *</label><input type="text" class="form-control" name="name" value="${lecturer.name}" required></div>
                <div class="col-md-6"><label class="form-label fw-semibold">Staff ID *</label><input type="text" class="form-control" name="staffId" value="${lecturer.staffId}" required></div>
                <div class="col-12"><label class="form-label fw-semibold">Email Address *</label><input type="email" class="form-control" name="email" value="${lecturer.email}" required></div>
                <div class="col-md-6"><label class="form-label fw-semibold">Phone *</label><input type="text" class="form-control" name="phone" value="${lecturer.phone}" required></div>
                <div class="col-md-6"><label class="form-label fw-semibold">Department *</label><input type="text" class="form-control" name="department" value="${lecturer.department}" required></div>
                <div class="col-12"><label class="form-label fw-semibold">Specialization *</label><input type="text" class="form-control" name="specialization" value="${lecturer.specialization}" required></div>
                <div class="col-12"><label class="form-label fw-semibold">Password *</label><input type="password" class="form-control" name="password" value="${lecturer.password}" required></div>
            </div>
            <hr class="my-3">
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-warning"><i class="bi bi-check-lg me-1"></i>Update Lecturer</button>
                <a href="/admin/lecturers" class="btn btn-outline-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>
    </div></div>
<%@ include file="../shared/app-scripts.jspf" %>
</body></html>

