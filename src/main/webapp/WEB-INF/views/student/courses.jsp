<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Courses</title>
    <%@ include file="../shared/head-assets.jspf" %>
    <c:set var="currentPage" value="courses"/><c:set var="pageTitle" value="Browse &amp; Register for Courses"/>
</head>
<body>
<%@ include file="navbar.jsp" %>

<c:if test="${not empty success}"><div class="alert alert-success alert-dismissible fade show"><i class="bi bi-check-circle-fill me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
<c:if test="${not empty error}"><div class="alert alert-danger alert-dismissible fade show"><i class="bi bi-exclamation-triangle-fill me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>

<h4 class="fw-bold mb-4"><i class="bi bi-journal-bookmark-fill text-success me-2"></i>Available Courses</h4>

<!-- Search -->
<div class="card mb-4">
    <div class="card-body py-2">
        <form method="get" action="/student/courses" class="d-flex gap-2">
            <input type="text" class="form-control" name="search" value="${search}" placeholder="Search by course name or code...">
            <button class="btn btn-outline-success px-4">🔍 Search</button>
            <c:if test="${not empty search}"><a href="/student/courses" class="btn btn-outline-secondary">Clear</a></c:if>
        </form>
    </div>
</div>

<!-- Course Cards -->
<c:choose>
    <c:when test="${empty courses}">
        <div class="card text-center py-5 text-muted">
            <i class="bi bi-journal-x display-4 d-block mb-2"></i>No courses available at the moment.
        </div>
    </c:when>
    <c:otherwise>
        <div class="row g-3">
            <c:forEach items="${courses}" var="c">
                <div class="col-md-6 col-lg-4">
                    <div class="card h-100">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <span class="badge bg-warning text-dark fs-6">${c.code}</span>
                                <span class="badge bg-light text-dark border">${c.credits} Credits</span>
                            </div>
                            <h6 class="fw-bold">${c.name}</h6>
                            <p class="text-muted small mb-3">${c.description}</p>
                        </div>
                        <div class="card-footer bg-white border-0 pt-0">
                            <c:choose>
                                <c:when test="${registeredCourseIds.contains(c.id)}">
                                    <button class="btn btn-success btn-sm w-100" disabled>
                                        <i class="bi bi-check-circle me-1"></i>Already Registered
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <form method="post" action="/student/courses/register">
                                        <input type="hidden" name="courseId" value="${c.id}">
                                        <button type="submit" class="btn btn-outline-success btn-sm w-100">
                                            <i class="bi bi-plus-circle me-1"></i>Register for this Course
                                        </button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

    </div></div>
<%@ include file="../shared/app-scripts.jspf" %>
</body></html>

