<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="app-shell">
<div class="sidebar">
    <div class="brand">
        <h5>EduStack</h5>
        <small class="opacity-75"><c:out value="${sessionScope.loggedStudent.indexNumber}" default="Student"/></small>
    </div>
    <div class="pt-2">
        <div class="nav-section">Main</div>
        <a href="/student/dashboard" class="nav-link <c:if test='${currentPage == "dashboard"}'>active</c:if>">
            Dashboard
        </a>
        <div class="nav-section">Courses</div>
        <a href="/student/courses" class="nav-link <c:if test='${currentPage == "courses"}'>active</c:if>">
            Browse Courses
        </a>
        <a href="/student/my-courses" class="nav-link <c:if test='${currentPage == "mycourses"}'>active</c:if>">
            My Courses
        </a>
        <div class="nav-section">Information</div>
        <a href="/student/notices" class="nav-link <c:if test='${currentPage == "notices"}'>active</c:if>">
            Notices
        </a>
        <a href="/student/profile" class="nav-link <c:if test='${currentPage == "profile"}'>active</c:if>">
            My Profile
        </a>
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
            <div class="page-title">${pageTitle}</div>
        </div>
        <span class="badge bg-primary badge-role">
            <c:out value="${sessionScope.loggedStudent.name}" default="Student"/>
        </span>
    </div>
    <div class="page-content">
