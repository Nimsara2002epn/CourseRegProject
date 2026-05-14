<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Course</title>
    <%@ include file="../shared/head-assets.jspf" %>
    <c:set var="currentPage" value="courses"/><c:set var="pageTitle" value="Edit Course"/>
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="d-flex align-items-center gap-2 mb-4">
    <a href="/admin/courses" class="btn btn-sm btn-outline-secondary"><i class="bi bi-arrow-left"></i></a>
    <h4 class="fw-bold mb-0"><i class="bi bi-pencil-square text-warning me-2"></i>Edit Course</h4>
</div>
<div class="card" style="max-width:680px">
    <div class="card-body p-4">
        <form method="post" action="/admin/courses/edit">
            <input type="hidden" name="id" value="${course.id}">
            <div class="row g-3">
                <div class="col-md-8">
                    <label class="form-label fw-semibold">Course Name *</label>
                    <input type="text" class="form-control" name="name" value="${course.name}" required>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-semibold">Course Code *</label>
                    <input type="text" class="form-control" name="code" value="${course.code}" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Department *</label>
                    <select class="form-select" name="departmentId" required>
                        <option value="">Select Department</option>
                        <c:forEach items="${departments}" var="d">
                            <option value="${d.id}" <c:if test="${d.id == course.departmentId}">selected</c:if>>${d.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Lecturer *</label>
                    <select class="form-select" name="lecturerId" required>
                        <option value="">Select Lecturer</option>
                        <c:forEach items="${lecturers}" var="l">
                            <option value="${l.id}" <c:if test="${l.id == course.lecturerId}">selected</c:if>>${l.name} (${l.staffId})</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label fw-semibold">Credits *</label>
                    <input type="number" class="form-control" name="credits" value="${course.credits}" min="1" max="6" required>
                </div>
                <div class="col-12">
                    <label class="form-label fw-semibold">Description *</label>
                    <textarea class="form-control" name="description" rows="3" required>${course.description}</textarea>
                </div>
            </div>
            <hr class="my-3">
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-warning text-white"><i class="bi bi-check-lg me-1"></i>Update Course</button>
                <a href="/admin/courses" class="btn btn-outline-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>
    </div></div>
<%@ include file="../shared/app-scripts.jspf" %>
</body></html>

