<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="app-shell">
<div class="sidebar">
    <div class="pt-2">
        <div class="nav-section">Main</div>
        <a href="/admin/dashboard" class="nav-link <c:if test='${currentPage == "dashboard"}'>active</c:if>">
            Dashboard
        </a>

        <div class="nav-section">People</div>
        <a href="/admin/students" class="nav-link <c:if test='${currentPage == "students"}'>active</c:if>">
            Students
        </a>
        <a href="/admin/lecturers" class="nav-link <c:if test='${currentPage == "lecturers"}'>active</c:if>">
            Lecturers
        </a>
        <c:if test="${userRole == 'ADMIN'}">
        <a href="/admin/users" class="nav-link <c:if test='${currentPage == "users"}'>active</c:if>">
            System Users
        </a>
        </c:if>

        <div class="nav-section">Academic</div>
        <a href="/admin/departments" class="nav-link <c:if test='${currentPage == "departments"}'>active</c:if>">
            Departments
        </a>
        <a href="/admin/courses" class="nav-link <c:if test='${currentPage == "courses"}'>active</c:if>">
            Courses
        </a>

        <c:if test="${userRole == 'ADMIN'}">
        <div class="nav-section">Communication</div>
        <a href="/admin/notices" class="nav-link <c:if test='${currentPage == "notices"}'>active</c:if>">
            Notices
        </a>
        </c:if>

        <div class="nav-section">Account</div>
        <a href="/logout" class="nav-link text-warning">
            Logout
        </a>
    </div>
</div>

<div class="main-content">
    <div class="topbar">
        <div class="topbar-brand">
            <div class="topbar-system">EduStack</div>
            <div class="page-title">
                <c:choose>
                    <c:when test="${userRole == 'ADMIN'}">Administrator</c:when>
                    <c:otherwise>Lecturer Portal</c:otherwise>
                </c:choose>
            </div>
        </div>
        <div class="d-flex align-items-center gap-3">
            <span class="badge bg-primary badge-role">
                <c:out value="${sessionScope.loggedUser.name}" default="User"/>
            </span>
        </div>
    </div>
    <div class="page-content">
