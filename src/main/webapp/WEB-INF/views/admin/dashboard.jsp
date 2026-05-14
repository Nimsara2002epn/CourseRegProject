<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <%@ include file="../shared/head-assets.jspf" %>
    <c:set var="currentPage" value="dashboard"/>
    <c:set var="pageTitle" value="Dashboard"/>
</head>
<body>

<%@ include file="navbar.jsp" %>

<c:if test="${not empty success}"><div class="alert alert-success alert-dismissible fade show"><i class="bi bi-check-circle-fill me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
<c:if test="${not empty error}"><div class="alert alert-danger alert-dismissible fade show"><i class="bi bi-exclamation-triangle-fill me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>

<div class="app-page-header">
    <h4 class="fw-bold mb-0">Admin Dashboard</h4>
</div>

<div class="card notice-panel mb-4">
    <div class="notice-panel-header">
        <div class="card-title mb-0">Recent Notices</div>
    </div>
    <div class="notice-panel-body">
        <c:choose>
            <c:when test="${empty recentNotices}">
                <p class="text-muted mb-0">No notices posted yet.</p>
            </c:when>
            <c:otherwise>
                <ul class="list-group dashboard-notice-list">
                    <c:forEach items="${recentNotices}" var="n" begin="0" end="3">
                        <li class="list-group-item">
                            <div class="fw-semibold">${n.title}</div>
                            <div class="text-muted small">${n.postedDate} · ${n.postedBy}</div>
                        </li>
                    </c:forEach>
                </ul>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<div class="stats-grid">
    <div class="card stat-card">
        <div class="stat-icon bg-primary">🎓</div>
        <div><div class="stat-value">${totalStudents}</div><div class="stat-label">Total Students</div></div>
    </div>
    <div class="card stat-card">
        <div class="stat-icon bg-success">👨‍🏫</div>
        <div><div class="stat-value">${totalLecturers}</div><div class="stat-label">Lecturers</div></div>
    </div>
    <div class="card stat-card">
        <div class="stat-icon bg-warning">📘</div>
        <div><div class="stat-value">${totalCourses}</div><div class="stat-label">Courses</div></div>
    </div>
    <div class="card stat-card">
        <div class="stat-icon bg-secondary">🏢</div>
        <div><div class="stat-value">${totalDepartments}</div><div class="stat-label">Departments</div></div>
    </div>
</div>

<div class="dashboard-grid">
    <a href="/admin/users" class="dashboard-tile">
        <div class="tile-icon"><i class="bi bi-people-fill"></i></div>
        <h3>User Management</h3>
    </a>
    <a href="/admin/lecturers" class="dashboard-tile">
        <div class="tile-icon"><i class="bi bi-person-workspace"></i></div>
        <h3>Lecturer</h3>
    </a>
    <a href="/admin/students" class="dashboard-tile">
        <div class="tile-icon"><i class="bi bi-mortarboard-fill"></i></div>
        <h3>Student</h3>
    </a>
    <a href="/admin/departments" class="dashboard-tile">
        <div class="tile-icon"><i class="bi bi-building"></i></div>
        <h3>Department</h3>
    </a>
    <a href="/admin/courses" class="dashboard-tile">
        <div class="tile-icon"><i class="bi bi-journal-bookmark-fill"></i></div>
        <h3>Course</h3>
    </a>
    <a href="/admin/notices" class="dashboard-tile">
        <div class="tile-icon"><i class="bi bi-megaphone-fill"></i></div>
        <h3>Notice</h3>
    </a>
</div>

    </div></div>
<%@ include file="../shared/app-scripts.jspf" %>
</body></html>
