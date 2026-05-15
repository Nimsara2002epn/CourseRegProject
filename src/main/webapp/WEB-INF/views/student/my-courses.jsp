<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Courses</title>
    <%@ include file="../shared/head-assets.jspf" %>
    <c:set var="currentPage" value="mycourses"/><c:set var="pageTitle" value="My Registered Courses"/>
</head>
<body>
<%@ include file="navbar.jsp" %>

<c:if test="${not empty success}"><div class="alert alert-success alert-dismissible fade show"><i class="bi bi-check-circle-fill me-2"></i>${success}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>
<c:if test="${not empty error}"><div class="alert alert-danger alert-dismissible fade show"><i class="bi bi-exclamation-triangle-fill me-2"></i>${error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div></c:if>

<div class="d-flex justify-content-between align-items-center mb-4">
    <h4 class="fw-bold mb-0"><i class="bi bi-journal-check text-success me-2"></i>My Registered Courses</h4>
    <a href="/student/courses" class="btn btn-outline-success btn-sm"><i class="bi bi-plus-circle me-1"></i>Register More</a>
</div>

<c:choose>
    <c:when test="${empty courseDetails}">
        <div class="card text-center py-5 text-muted">
            <i class="bi bi-journal-x display-4 d-block mb-2"></i>
            You haven't registered for any courses yet.
            <a href="/student/courses" class="d-block mt-2 fw-semibold text-success">Browse available courses</a>
        </div>
    </c:when>
    <c:otherwise>
        <div class="card">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead>
                            <tr><th>#</th><th>Code</th><th>Course Name</th><th>Credits</th><th>Registered On</th><th>Status</th><th>Action</th></tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${courseDetails}" var="detail" varStatus="loop">
                                <%-- detail[0] = Registration, detail[1] = Course --%>
                                <tr>
                                    <td class="text-muted">${loop.count}</td>
                                    <td><span class="badge bg-warning text-dark">${detail[1].code}</span></td>
                                    <td>
                                        <strong>${detail[1].name}</strong><br>
                                        <small class="text-muted">${detail[1].description}</small>
                                    </td>
                                    <td>${detail[1].credits}</td>
                                    <td>${detail[0].registrationDate}</td>
                                    <td><span class="badge bg-success">${detail[0].status}</span></td>
                                    <td>
                                        <form method="post" action="/student/courses/drop" onsubmit="return confirm('Are you sure you want to drop this course?')">
                                            <input type="hidden" name="registrationId" value="${detail[0].id}">
                                            <button type="submit" class="btn btn-sm btn-outline-danger">
                                                <i class="bi bi-x-circle me-1"></i>Drop
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="card-footer text-muted small">${courseDetails.size()} course(s) registered</div>
        </div>
    </c:otherwise>
</c:choose>

    </div></div>
<%@ include file="../shared/app-scripts.jspf" %>
</body></html>

