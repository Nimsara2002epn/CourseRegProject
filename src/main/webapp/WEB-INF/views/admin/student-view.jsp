<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Details</title>
    <%@ include file="../shared/head-assets.jspf" %>
    <c:set var="currentPage" value="students"/>
    <c:set var="pageTitle" value="Student Details"/>
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="d-flex justify-content-between align-items-center mb-4">
    <div>
        <h4 class="fw-bold mb-1"><i class="bi bi-person-vcard text-primary me-2"></i>${student.name}</h4>
        <div class="text-muted">Student profile and course registration details</div>
    </div>
    <div class="d-flex gap-2">
        <a href="/admin/students/edit/${student.id}" class="btn btn-outline-warning">✏️ Edit</a>
        <a href="/admin/students" class="btn btn-outline-secondary">
            ← Back
        </a>
    </div>
</div>

<div class="row g-4 mb-4">
    <div class="col-lg-4">
        <div class="card h-100">
            <div class="card-body">
                <h5 class="card-title mb-3">Student Information</h5>
                <div class="mb-3">
                    <div class="text-muted small">Index Number</div>
                    <div class="fw-semibold">${student.indexNumber}</div>
                </div>
                <div class="mb-3">
                    <div class="text-muted small">Email</div>
                    <div class="fw-semibold">${student.email}</div>
                </div>
                <div class="mb-3">
                    <div class="text-muted small">Phone</div>
                    <div class="fw-semibold">${student.phone}</div>
                </div>
                <div class="mb-3">
                    <div class="text-muted small">Department</div>
                    <div class="fw-semibold">${student.department}</div>
                </div>
                <div>
                    <div class="text-muted small">Student ID</div>
                    <div class="fw-semibold">${student.id}</div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-lg-8">
        <div class="card h-100">
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="card-title mb-0">Registered Courses</h5>
                    <span class="badge bg-primary">${registeredCourses.size()} record(s)</span>
                </div>

                <c:choose>
                    <c:when test="${empty registeredCourses}">
                        <div class="text-center py-5 text-muted">
                            <i class="bi bi-journal-x display-5 d-block mb-2"></i>
                            This student has no course registrations yet.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-striped align-middle mb-0">
                                <thead>
                                <tr>
                                    <th>Course</th>
                                    <th>Department</th>
                                    <th>Lecturer</th>
                                    <th>Credits</th>
                                    <th>Registered On</th>
                                    <th>Status</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${registeredCourses}" var="course">
                                    <tr>
                                        <td>
                                            <div class="fw-semibold">${course.courseName}</div>
                                            <div class="text-muted small">${course.courseCode}</div>
                                        </td>
                                        <td>${course.departmentName}</td>
                                        <td>${course.lecturerName}</td>
                                        <td>${course.credits}</td>
                                        <td>${course.registrationDate}</td>
                                        <td>
                                            <span class="badge ${course.status eq 'ACTIVE' ? 'bg-success' : 'bg-secondary'}">
                                                ${course.status}
                                            </span>
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
    </div>
</div>

<%@ include file="../shared/app-scripts.jspf" %>
</body>
</html>

