<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Departments</title>
    <%@ include file="../shared/head-assets.jspf" %>
    <c:set var="currentPage" value="departments"/><c:set var="pageTitle" value="Department Management"/>
</head>
<body>
<%@ include file="navbar.jsp" %>

<c:if test="${not empty success}"><div class="alert alert-success alert-dismissible fade show"><i class="bi bi-check-circle-fill me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
<c:if test="${not empty error}"><div class="alert alert-danger alert-dismissible fade show"><i class="bi bi-exclamation-triangle-fill me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h4 class="fw-bold mb-0"><i class="bi bi-building text-purple me-2" style="color:#6a1b9a"></i>Departments</h4>
    <a href="/admin/departments/add" class="btn btn-primary"><i class="bi bi-plus-circle me-1"></i>Add Department</a>
</div>

<div class="row g-3">
    <c:choose>
        <c:when test="${empty departments}">
            <div class="col-12"><div class="card text-center py-5 text-muted"><i class="bi bi-building display-4 d-block mb-2"></i>No departments yet.</div></div>
        </c:when>
        <c:otherwise>
            <c:forEach items="${departments}" var="d">
                <div class="col-md-4">
                    <div class="card h-100">
                        <div class="card-body">
                            <div class="d-flex align-items-start justify-content-between">
                                <div>
                                    <div class="rounded-circle d-inline-flex align-items-center justify-content-center mb-2" style="width:42px;height:42px;background:linear-gradient(135deg,#6a1b9a,#8e24aa)">
                                        <i class="bi bi-building text-white"></i>
                                    </div>
                                    <h6 class="fw-bold mb-1">${d.name}</h6>
                                    <p class="text-muted small mb-0">${d.description}</p>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer bg-white border-0 pt-0">
                            <a href="/admin/departments/edit/${d.id}" class="btn btn-sm btn-outline-warning me-1"><i class="bi bi-pencil me-1"></i>Edit</a>
                            <button class="btn btn-sm btn-outline-danger" onclick="confirmDelete('/admin/departments/delete/${d.id}', '${d.name}')"><i class="bi bi-trash me-1"></i>Delete</button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

    </div></div>
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog modal-sm"><div class="modal-content">
        <div class="modal-body text-center p-4">
            <i class="bi bi-exclamation-triangle-fill text-warning fs-1 d-block mb-2"></i>
            <p>Delete department <strong id="deleteName"></strong>?</p>
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


