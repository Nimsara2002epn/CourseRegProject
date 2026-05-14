<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notices</title>
    <%@ include file="../shared/head-assets.jspf" %>
    <c:set var="currentPage" value="notices"/><c:set var="pageTitle" value="Notices &amp; Announcements"/>
</head>
<body>
<%@ include file="navbar.jsp" %>

<h4 class="fw-bold mb-4"><i class="bi bi-megaphone-fill text-danger me-2"></i>Notices &amp; Announcements</h4>

<c:choose>
    <c:when test="${empty notices}">
        <div class="card text-center py-5 text-muted">
            <i class="bi bi-megaphone display-4 d-block mb-2"></i>No notices posted yet.
        </div>
    </c:when>
    <c:otherwise>
        <div class="row g-3">
            <c:forEach items="${notices}" var="n">
                <div class="col-12">
                    <div class="card" style="border-left:4px solid #dc3545">
                        <div class="card-body">
                            <h6 class="fw-bold mb-1">
                                <i class="bi bi-bell-fill text-danger me-2"></i>${n.title}
                            </h6>
                            <p class="mb-2">${n.content}</p>
                            <small class="text-muted">
                                <i class="bi bi-calendar3 me-1"></i>${n.postedDate}
                                &nbsp;·&nbsp;
                                <i class="bi bi-person me-1"></i>Posted by ${n.postedBy}
                            </small>
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
