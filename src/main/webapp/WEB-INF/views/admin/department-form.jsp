<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Department</title>
    <%@ include file="../shared/head-assets.jspf" %>
    <c:set var="currentPage" value="departments"/><c:set var="pageTitle" value="Add Department"/>
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="d-flex align-items-center gap-2 mb-4">
    <a href="/admin/departments" class="btn btn-sm btn-outline-secondary"><i class="bi bi-arrow-left"></i></a>
    <h4 class="fw-bold mb-0"><i class="bi bi-building-add text-primary me-2"></i>Add New Department</h4>
</div>
<div class="card" style="max-width:560px">
    <div class="card-body p-4">
        <form method="post" action="/admin/departments/add">
            <div class="mb-3">
                <label class="form-label fw-semibold">Department Name *</label>
                <input type="text" class="form-control" name="name" placeholder="e.g. Software Engineering" required>
            </div>
            <div class="mb-3">
                <label class="form-label fw-semibold">Description *</label>
                <textarea class="form-control" name="description" rows="3" placeholder="Brief description of the department" required></textarea>
            </div>
            <hr class="my-3">
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary"><i class="bi bi-check-lg me-1"></i>Add Department</button>
                <a href="/admin/departments" class="btn btn-outline-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>
    </div></div>
<%@ include file="../shared/app-scripts.jspf" %>
</body></html>

