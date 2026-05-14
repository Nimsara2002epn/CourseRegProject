<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Students</title>
    <%@ include file="../shared/head-assets.jspf" %>
    <c:set var="currentPage" value="students"/>
    <c:set var="pageTitle" value="Student Management"/>
</head>
<body>
<%@ include file="navbar.jsp" %>

<c:if test="${not empty success}"><div class="alert alert-success alert-dismissible fade show"><i class="bi bi-check-circle-fill me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
<c:if test="${not empty error}"><div class="alert alert-danger alert-dismissible fade show"><i class="bi bi-exclamation-triangle-fill me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>

<!-- Header -->
<div class="d-flex justify-content-between align-items-center mb-4">
    <h4 class="fw-bold mb-0"><i class="bi bi-people-fill text-primary me-2"></i>Students</h4>
    <a href="/admin/students/add" class="btn btn-primary"><i class="bi bi-person-plus me-1"></i>Add Student</a>
</div>

<!-- Search -->
<div class="card mb-3">
    <div class="card-body py-2">
        <form method="get" action="/admin/students" class="d-flex gap-2">
            <input type="text" class="form-control" name="search" value="${search}" placeholder="Search by name, email, phone, index number, or department...">
            <button class="btn btn-outline-primary px-4">🔍 Search</button>
            <c:if test="${not empty search}">
                <a href="/admin/students" class="btn btn-outline-secondary">Clear</a>
            </c:if>
        </form>
    </div>
</div>

<!-- Table -->
<div class="card">
    <div class="card-body p-0">
        <c:choose>
            <c:when test="${empty students}">
                <div class="text-center py-5 text-muted">
                    <i class="bi bi-people display-4 d-block mb-2"></i>
                    No students found.
                    <a href="/admin/students/add" class="d-block mt-2">Add the first student</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Name</th>
                                <th>Index Number</th>
                                <th>Email</th>
                                <th>Phone</th>
                                <th>Department</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${students}" var="s" varStatus="loop">
                                <tr>
                                    <td class="text-muted">${loop.count}</td>
                                    <td><i class="bi bi-person-circle text-primary me-1"></i><strong>${s.name}</strong></td>
                                    <td><span class="badge bg-primary">${s.indexNumber}</span></td>
                                    <td>${s.email}</td>
                                    <td>${s.phone}</td>
                                    <td>${s.department}</td>
                                    <td>
                                        <a href="/admin/students/${s.id}" class="btn btn-sm btn-outline-info me-1" title="View details">👁️ View</a>
                                        <a href="/admin/students/edit/${s.id}" class="btn btn-sm btn-outline-warning me-1">✏️ Edit</a>
                                        <button class="btn btn-sm btn-outline-danger"
                                                onclick="confirmDelete('/admin/students/delete/${s.id}', '${s.name}')">🗑️ Delete</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <c:if test="${not empty students}">
    <div class="card-footer text-muted small">${students.size()} student(s) found</div>
    </c:if>
</div>

    </div></div>

<!-- Delete Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-body text-center p-4">
                <i class="bi bi-exclamation-triangle-fill text-warning fs-1 d-block mb-2"></i>
                <p>Delete <strong id="deleteName"></strong>?</p>
                <a id="deleteLink" href="#" class="btn btn-danger me-2">Yes, Delete</a>
                <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
            </div>
        </div>
    </div>
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


