<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard</title>
    <%@ include file="../shared/head-assets.jspf" %>
    <c:set var="currentPage" value="dashboard"/><c:set var="pageTitle" value="Student Dashboard"/>
</head>
<body>
<%@ include file="navbar.jsp" %>

<c:if test="${not empty success}"><div class="alert alert-success alert-dismissible fade show"><i class="bi bi-check-circle-fill me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
<c:if test="${not empty error}"><div class="alert alert-danger alert-dismissible fade show"><i class="bi bi-exclamation-triangle-fill me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>

<h4 class="fw-bold mb-1">Welcome, <c:out value="${student.name}"/>!</h4>
<p class="text-muted mb-4">Index: ${student.indexNumber} &nbsp;&middot;&nbsp; ${student.department}</p>

<div class="row g-3 mb-4">
    <div class="col-md-4">
        <div class="card stat-card h-100">
            <div class="card-body d-flex align-items-center gap-3">
                <div class="stat-icon bg-primary">📚</div>
                <div>
                    <div class="fs-2 fw-bold text-primary">${enrolledCourses.size()}</div>
                    <div class="text-muted small">Enrolled Courses</div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card stat-card h-100">
            <div class="card-body d-flex align-items-center gap-3">
                <div class="stat-icon bg-warning">📘</div>
                <div>
                    <div class="fs-2 fw-bold text-primary">${totalCourses}</div>
                    <div class="text-muted small">Available Courses</div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card stat-card h-100">
            <div class="card-body d-flex align-items-center gap-3">
                <div class="stat-icon bg-secondary">📢</div>
                <div>
                    <div class="fs-2 fw-bold text-primary">${notices.size()}</div>
                    <div class="text-muted small">Notices</div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row g-3">
    <div class="col-md-7">
        <div class="card h-100">
            <div class="card-header bg-white fw-semibold border-0">
                <i class="bi bi-journal-check text-primary me-2"></i>My Enrolled Courses
                <a href="/student/courses" class="btn btn-sm btn-outline-primary float-end">+ Register More</a>
            </div>
            <div class="card-body p-0">
                <c:choose>
                    <c:when test="${empty enrolledCourses}">
                        <div class="text-center py-4 text-muted">
                            <i class="bi bi-journal-x display-6 d-block mb-2"></i>
                            Not enrolled in any courses yet.
                            <a href="/student/courses" class="d-block mt-1">Browse available courses</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <ul class="list-group list-group-flush">
                            <c:forEach items="${enrolledCourses}" var="c">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <div>
                                        <span class="badge bg-warning text-dark me-2">${c.code}</span>
                                        <strong>${c.name}</strong>
                                    </div>
                                    <span class="badge bg-light text-dark border">${c.credits} cr</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="col-md-5">
        <div class="card h-100">
            <div class="card-header bg-white fw-semibold border-0">
                <i class="bi bi-megaphone-fill text-primary me-2"></i>Latest Notices
            </div>
            <div class="card-body p-0">
                <c:choose>
                    <c:when test="${empty notices}">
                        <p class="text-muted text-center py-3 mb-0">No notices available.</p>
                    </c:when>
                    <c:otherwise>
                        <ul class="list-group list-group-flush">
                            <c:forEach items="${notices}" var="n" begin="0" end="4">
                                <li class="list-group-item px-3">
                                    <div class="fw-semibold small">${n.title}</div>
                                    <div class="text-muted" style="font-size:0.78rem">${n.postedDate}</div>
                                </li>
                            </c:forEach>
                        </ul>
                        <div class="text-center py-2">
                            <a href="/student/notices" class="small text-decoration-none">View all notices &rarr;</a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

    </div></div>
<%@ include file="../shared/app-scripts.jspf" %>
</body></html>
