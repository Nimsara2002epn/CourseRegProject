<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Student</title>
    <%@ include file="../shared/head-assets.jspf" %>
    <c:set var="currentPage" value="students"/>
    <c:set var="pageTitle" value="Add New Student"/>
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="d-flex align-items-center gap-2 mb-4">
    <a href="/admin/students" class="btn btn-sm btn-outline-secondary"><i class="bi bi-arrow-left"></i></a>
    <h4 class="fw-bold mb-0"><i class="bi bi-person-plus text-primary me-2"></i>Add New Student</h4>
</div>

<div class="card" style="max-width:680px">
    <div class="card-body p-4">
        <form method="post" action="/admin/students/add">
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
                <div class="col-12">
                    <label class="form-label fw-semibold">Password *</label>
                    <input type="password" class="form-control" name="password" placeholder="Set a password for this student" required>
                </div>
            </div>
            <hr class="my-3">
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary"><i class="bi bi-check-lg me-1"></i>Add Student</button>
                <a href="/admin/students" class="btn btn-outline-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>

    </div></div>
<%@ include file="../shared/app-scripts.jspf" %>
</body></html>

