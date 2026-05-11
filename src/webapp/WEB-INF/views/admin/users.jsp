<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>System Users</title>
    <%@ include file="../shared/head-assets.jspf" %>
    <c:set var="currentPage" value="users"/><c:set var="pageTitle" value="System User Management"/>
</head>
<body>
<%@ include file="navbar.jsp" %>

<c:if test="${not empty success}"><div class="alert alert-success alert-dismissible fade show"><i class="bi bi-check-circle-fill me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
<c:if test="${not empty error}"><div class="alert alert-danger alert-dismissible fade show"><i class="bi bi-exclamation-triangle-fill me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h4 class="fw-bold mb-0"><i class="bi bi-shield-person text-dark me-2"></i>System Users (Admin / Lecturer)</h4>
    <a href="/admin/users/add" class="btn btn-dark"><i class="bi bi-person-plus me-1"></i>Add User</a>
</div>

<div class="card mb-3">
    <div class="card-body py-2">
        <form method="get" action="/admin/users" class="d-flex gap-2">
            <input type="text" class="form-control" name="search" value="${search}" placeholder="Search by name, email, phone, or role...">
            <button class="btn btn-outline-dark px-4"><i class="bi bi-search"></i></button>
            <c:if test="${not empty search}"><a href="/admin/users" class="btn btn-outline-secondary">Clear</a></c:if>
        </form>
    </div>
</div>

<div class="card">
    <div class="card-body p-0">
        <c:choose>
            <c:when test="${empty users}">
                <div class="text-center py-5 text-muted"><i class="bi bi-shield-x display-4 d-block mb-2"></i>No system users found.</div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead><tr><th>#</th><th>Name</th><th>Email</th><th>Phone</th><th>Role</th><th>Actions</th></tr></thead>
                        <tbody>
                            <c:forEach items="${users}" var="u" varStatus="loop">
                                <tr>
                                    <td class="text-muted">${loop.count}</td>
                                    <td><i class="bi bi-person-circle me-1"></i><strong>${u.name}</strong></td>
                                    <td>${u.email}</td>
                                    <td>${u.phone}</td>
                                    <td>
                                        <span class="badge <c:choose><c:when test='${u.role == "ADMIN"}'>bg-danger</c:when><c:otherwise>bg-success</c:otherwise></c:choose>">${u.role}</span>
                                    </td>
                                    <td>
                                        <a href="/admin/users/edit/${u.id}" class="btn btn-sm btn-outline-warning me-1">✏️ Edit</a>
                                        <button class="btn btn-sm btn-outline-danger" onclick="confirmDelete('/admin/users/delete/${u.id}', '${u.name}')">🗑️ Delete</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

    </div></div>
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog modal-sm"><div class="modal-content">
        <div class="modal-body text-center p-4">
            <i class="bi bi-exclamation-triangle-fill text-warning fs-1 d-block mb-2"></i>
            <p>Delete user <strong id="deleteName"></strong>?</p>
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


