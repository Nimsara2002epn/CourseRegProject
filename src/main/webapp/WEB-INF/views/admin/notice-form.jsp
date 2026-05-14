<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Post Notice</title>
    <%@ include file="../shared/head-assets.jspf" %>
    <c:set var="currentPage" value="notices"/><c:set var="pageTitle" value="Post Notice"/>
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="d-flex align-items-center gap-2 mb-4">
    <a href="/admin/notices" class="btn btn-sm btn-outline-secondary"><i class="bi bi-arrow-left"></i></a>
    <h4 class="fw-bold mb-0"><i class="bi bi-megaphone text-danger me-2"></i>Post New Notice</h4>
</div>
<div class="card" style="max-width:640px">
    <div class="card-body p-4">
        <form method="post" action="/admin/notices/add">
            <div class="mb-3">
                <label class="form-label fw-semibold">Notice Title *</label>
                <input type="text" class="form-control" name="title" placeholder="e.g. Exam Schedule Update" required>
            </div>
            <div class="mb-3">
                <label class="form-label fw-semibold">Content *</label>
                <textarea class="form-control" name="content" rows="5" placeholder="Write the notice content here..." required></textarea>
            </div>
            <hr class="my-3">
            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-danger"><i class="bi bi-megaphone me-1"></i>Post Notice</button>
                <a href="/admin/notices" class="btn btn-outline-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>
    </div></div>
<%@ include file="../shared/app-scripts.jspf" %>
</body></html>
