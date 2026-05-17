<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Courses</title>
    <%@ include file="../shared/head-assets.jspf" %>
    <c:set var="currentPage" value="courses"/><c:set var="pageTitle" value="Course Management"/>
</head>
<body>
<%@ include file="navbar.jsp" %>

<c:if test="${not empty success}"><div class="alert alert-success alert-dismissible fade show"><i class="bi bi-check-circle-fill me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
<c:if test="${not empty error}"><div class="alert alert-danger alert-dismissible fade show"><i class="bi bi-exclamation-triangle-fill me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h4 class="fw-bold mb-0"><i class="bi bi-journal-bookmark-fill text-warning me-2"></i>Courses</h4>
    <a href="/admin/courses/add" class="btn btn-warning text-white"><i class="bi bi-plus-circle me-1"></i>Add Course</a>
</div>

<!-- Search + Filter -->
<div class="card mb-3">
    <div class="card-body py-2">
        <div class="row g-2">
            <div class="col-md-7">
                <form method="get" action="/admin/courses" class="d-flex gap-2">
                    <input type="text" class="form-control" name="search" value="${search}" placeholder="Search by name or code...">
                    <button class="btn btn-outline-warning px-4">🔍 Search</button>
                    <c:if test="${not empty search}"><a href="/admin/courses" class="btn btn-outline-secondary">Clear</a></c:if>
                </form>
            </div>
            <div class="col-md-5">
                <form method="get" action="/admin/courses" class="d-flex gap-2">
                    <select class="form-select" name="departmentId">
                        <option value="">All Departments</option>
                        <c:forEach items="${departments}" var="d">
                            <option value="${d.id}" <c:if test="${filterDept == d.id}">selected</c:if>>${d.name}</option>
                        </c:forEach>
                    </select>
                    <button class="btn btn-outline-secondary">Filter</button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="card">
    <div class="card-body p-0">
        <c:choose>
            <c:when test="${empty courses}">
                <div class="text-center py-5 text-muted">
                    <i class="bi bi-journal-x display-4 d-block mb-2"></i>No courses found.
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr><th>#</th><th>Code</th><th>Course Name</th><th>Credits</th><th>Department</th><th>Lecturer</th><th>Actions</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${courses}" var="c" varStatus="loop">
                                <tr>
                                    <td class="text-muted">${loop.count}</td>
                                    <td><span class="badge bg-warning text-dark">${c.code}</span></td>
                                    <td><strong>${c.name}</strong><br><small class="text-muted">${c.description}</small></td>
                                    <td>${c.credits}</td>
                                    <td>
                                    <c:set var="departmentName" value="Unassigned" />
                                                                            <c:forEach items="${departments}" var="d">
                                                                                <c:if test="${d.id == c.departmentId}">
                                                                                    <c:set var="departmentName" value="${d.name}" />
                                                                                </c:if>
                                                                            </c:forEach>
                                                                            <span class="badge bg-light text-dark border">${departmentName}</span>
                                                                        </td>
                                                                        <td>
                                                                            <c:set var="lecturerName" value="Unassigned" />
                                                                            <c:forEach items="${lecturers}" var="l">
                                                                                <c:if test="${l.id == c.lecturerId}">
                                                                                    <c:set var="lecturerName" value="${l.name}" />
                                                                                </c:if>
                                                                            </c:forEach>
                                                                            <span class="badge bg-light text-dark border">${lecturerName}</span>
                                                                        </td>
                                                                        <td>
                                        <a href="/admin/courses/edit/${c.id}" class="btn btn-sm btn-outline-warning me-1">✏️ Edit</a>
                                        <button class="btn btn-sm btn-outline-danger" onclick="confirmDelete('/admin/courses/delete/${c.id}', '${c.name}')">🗑️ Delete</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <c:if test="${not empty courses}"><div class="card-footer text-muted small">${courses.size()} course(s) found</div></c:if>
</div>

    </div></div>
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog modal-sm"><div class="modal-content">
        <div class="modal-body text-center p-4">
            <i class="bi bi-exclamation-triangle-fill text-warning fs-1 d-block mb-2"></i>
            <p>Delete course <strong id="deleteName"></strong>?</p>
            <a id="deleteLink" href="#" class="btn btn-danger me-2">Yes, Delete</a>
            <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        </div>
    </div></div>
</div>
<%@ include file="../shared/app-scripts.jspf" %>
<script>
    function confirmDelete(url, name) {
        document.getElementById('deleteLink').href = url;
        document.getElementById('deleteName').textContent = name;
        openModalById('deleteModal');
    }
</script>
</body></html>


