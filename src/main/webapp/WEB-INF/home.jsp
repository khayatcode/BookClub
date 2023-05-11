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
<title>Home</title>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css">
</head>
<body>
	<div class="bg-dark d-flex justify-content-around p-3">
		<h1 class="text-white">
			Welcome
			<c:out value="${user.userName}" />
			!!
		</h1>
		<div class="d-flex gap-3">
			<a href="/books/create" class="btn btn-outline-light h-75">Create Book</a> <a href="/users/logout" class="btn btn-outline-danger h-75">Logout</a>
		</div>
	</div>
	<div class="container mt-3">
		<p>Books from everyone's shelves:</p>
		<table class="table table-hover">
			<thead>
				<tr>
					<th scope="col">ID</th>
					<th scope="col">Title</th>
					<th scope="col">Author Name</th>
					<th scope="col">Posted By</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="book" items="${books}">
					<tr>
						<td>
							<c:out value="${book.id}"/>
						</td>
						<td>
							<a href="/books/show/${book.id}">
								<c:out value="${book.title}"/>
							</a>
						</td>
						<td>
							<c:out value="${book.author}"/>
						</td>
						<td>
							<c:out value="${book.user.userName}"/>
						</td>
					</tr>
				</c:forEach>
			</tbody>		
		</table>
	</div>
	
	
</body>
</html>