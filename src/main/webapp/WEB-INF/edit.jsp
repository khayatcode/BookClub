<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- c:out ; c:forEach etc. -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Formatting (dates) -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- form:form -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!-- for rendering errors on PUT routes -->
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
</head>
<body>
	<div class="bg-dark d-flex justify-content-around p-3">
		<h1 class="text-white">Change your Entry</h1>
		<div class="d-flex gap-3">
			<a href="/books/home" class="btn btn-outline-light h-75">Home</a> <a
				href="/users/logout" class="btn btn-outline-danger h-75">Logout</a>
		</div>
	</div>
	<div class="container">
		<form:form action="/books/update/${book.id}" method="post"
			modelAttribute="book">
			<input type="hidden" name="_method" value="put">
			
			<c:if test="${bindingResult.hasErrors()}">
				<div class="alert alert-danger mt-3 d-block ">
					<h3>
						<strong>Validation Error:</strong>
					</h3>
					<div class="mb-3">
						<form:errors path="title" class="text-danger" />
					</div>
					<div class="mb-3">
						<form:errors path="author" class="text-danger" />
					</div>
					<div class="mb-3">
						<form:errors path="thoughts" class="text-danger" />
					</div>
				</div>
			</c:if>

			<form:hidden path="user" value="${user.id}" />
			<div class="mb-3">
				<form:label path="title" class="form-label">Title:</form:label>

				<form:input path="title" class="form-control" type="text" />
			</div>

			<div class="mb-3">
				<form:label path="author" class="form-label">Author:</form:label>
				<form:input path="author" class="form-control" type="text" />
			</div>

			<div class="mb-3">
				<form:label path="thoughts" class="form-label">Title:</form:label>
				<form:textarea path="thoughts" class="form-control" rows="5"
					cols="50"></form:textarea>
			</div>

			<input type="submit" value="Submit" class="btn btn-primary" />
		</form:form>
	</div>
</body>
</html>