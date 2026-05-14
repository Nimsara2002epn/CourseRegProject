<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notices</title>
    <%@ include file="../shared/head-assets.jspf" %>
    <c:set var="currentPage" value="notices"/><c:set var="pageTitle" value="Notice Management"/>
</head>
<body>
<%@ include file="navbar.jsp" %>

<c:if test="${not empty success}"><div class="alert alert-success alert-dismissible fade show"><i class="bi bi-check-circle-fill me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
<c:if test="${not empty error}"><div class="alert alert-danger alert-dismissible fade show"><i class="bi bi-exclamation-triangle-fill me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h4 class="fw-bold mb-0"><i class="bi bi-megaphone-fill text-danger me-2"></i>Notices</h4>
    <a href="/admin/notices/add" class="btn btn-danger"><i class="bi bi-plus-circle me-1"></i>Post Notice</a>
</div>

<c:choose>
    <c:when test="${empty notices}">
        <div class="card text-center py-5 text-muted"><i class="bi bi-megaphone display-4 d-block mb-2"></i>No notices posted yet.</div>
    </c:when>
    <c:otherwise>
        <div class="row g-3">
            <c:forEach items="${notices}" var="n">
                <div class="col-12">
                    <div class="card" style="border-left:4px solid #dc3545">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start">
                                <div class="flex-grow-1">
                                    <h6 class="fw-bold mb-1">${n.title}</h6>
                                    <p class="mb-2 text-muted">${n.content}</p>
                                    <small class="text-muted">
                                        <i class="bi bi-calendar3 me-1"></i>${n.postedDate}
                                        &nbsp;·&nbsp;
                                        <i class="bi bi-person me-1"></i>${n.postedBy}
                                    </small>
                                </div>
                                <div class="ms-3 d-flex gap-2">
                                    <a href="/admin/notices/edit/${n.id}" class="btn btn-sm btn-outline-warning">✏️ Edit</a>
                                    <button class="btn btn-sm btn-outline-danger" onclick="confirmDelete('/admin/notices/delete/${n.id}', '${n.title}')">🗑️ Delete</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

    </div></div>
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog modal-sm"><div class="modal-content">
        <div class="modal-body text-center p-4">
            <i class="bi bi-exclamation-triangle-fill text-warning fs-1 d-block mb-2"></i>
            <p>Delete notice <strong id="deleteName"></strong>?</p>
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
