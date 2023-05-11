<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. --> 
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!-- Formatting (dates) --> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
</head>
<body>
	<div class="bg-dark d-flex justify-content-around p-3">
		<h1 class="text-white"><em><c:out value="${book.title}"/> </em></h1>
		<div class="d-flex gap-3">
			<a href="/books/home" class="btn btn-outline-light h-75">Home</a> <a
				href="/users/logout" class="btn btn-outline-danger h-75">Logout</a>
		</div>
	</div>
	<div class="container">
		<div class="row mt-3">
			<c:choose>
			
				<c:when test="${user.id == book.user.id}">
					<h4>You read <c:out value="${book.title}"/> by <c:out value="${book.author}"/>.</h4>
					<h4>Here are your thoughts:</h4>
				</c:when>
				
				<c:otherwise>
					<h4><c:out value="${book.user.userName}"/> read <c:out value="${book.title}"/> by <c:out value="${book.author}"/>.</h4>
					<h4>Here are <c:out value="${book.user.userName}"/>'s thoughts:</h4>
				</c:otherwise>
				
			</c:choose>
		</div>
		
		<div class="row col-5 mt-3">
			<hr>
			<div class="p-3">
				<p class="overflow-auto">
					<c:out value="${book.thoughts}"></c:out>
				</p>
			</div>
			<hr>
			<c:if test="${user.id == book.user.id}">
				<div class="d-flex gap-3">
					<a href="/books/edit/${book.id}" class="btn btn-success h-100">Edit</a>
					<form action="/books/delete/${book.id}" method="post">
					    <input type="hidden" name="_method" value="delete">
					    <input type="submit" value="Delete" class="btn btn-danger h-100">
					</form>
				</div>
			</c:if>
		</div>
	</div>
</body>
</html>