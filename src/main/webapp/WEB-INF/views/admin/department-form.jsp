<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Lecturer</title>
    <%@ include file="../shared/head-assets.jspf" %>
    <c:set var="currentPage" value="lecturers"/><c:set var="pageTitle" value="Add Lecturer"/>
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="d-flex align-items-center gap-2 mb-4">
    <a href="/admin/lecturers" class="btn btn-sm btn-outline-secondary"><i class="bi bi-arrow-left"></i></a>
    <h4 class="fw-bold mb-0"><i class="bi bi-person-plus text-success me-2"></i>Add New Lecturer</h4>
</div>
<div class="card" style="max-width:680px">
    <div class="card-body p-4">
        <form method="post" action="/admin/lecturers/add">
            <div class="row g-3">
                <div class="col-md-6"><label class="form-label fw-semibold">Full Name *</label><input type="text" class="form-control" name="name" required></div>
                <div class="col-md-6"><label class="form-label fw-semibold">Staff ID *</label><input type="text" class="form-control" name="staffId" placeholder="e.g. LEC/001" required></div>
                <div class="col-12"><label class="form-label fw-semibold">Email Address *</label><input type="email" class="form-control" name="email" required></div>
                <div class="col-md-6"><label class="form-label fw-semibold">Phone *</label><input type="text" class="form-control" name="phone" required></div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Department *</label>
                    <select class="form-select" name="department" required <c:if test="${empty departments}">disabled</c:if>>
                        <option value="">Select a department</option>
                        <c:forEach items="${departments}" var="department">
                            <option value="${department.name}">${department.name}</option>
                        </c:forEach>
                    </select>
                    <c:if test="${empty departments}">
                        <small class="text-danger d-block mt-1">No departments available yet. Please add a department first.</small>
                    </c:if>
                </div>
                <div class="col-12"><label class="form-label fw-semibold">Specialization *</label><input type="text" class="form-control" name="specialization" placeholder="e.g. Object Oriented Programming" required></div>
                <div class="col-12"><label class="form-label fw-semibold">Password *</label><input type="password" class="form-control" name="password" required></div>
            </div>
            <hr class="my-3">
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-success"><i class="bi bi-check-lg me-1"></i>Add Lecturer</button>
                <a href="/admin/lecturers" class="btn btn-outline-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>
    </div></div>
<%@ include file="../shared/app-scripts.jspf" %>
</body></html>

