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
					<th scope="col">Actions</th>
				</tr>
			</thead>
			<tbody>
				<!-- Only show books that are not borrowed by user. If book is borrowed take off from table. If user is owner of the book show edit and delete button in the table -->
				<c:forEach var="book" items="${books}">
					
						<c:if test="${book.borrower.id != user.id}">
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
								<c:choose>
									<c:when test="${book.user == user}">
										<td class="d-flex gap-3">
											<a href="/books/edit/${book.id}" class="btn btn-outline-warning">Edit</a>
											<form action="/books/delete/${book.id}" method="post">
												<input type="hidden" name="_method" value="delete">
												<input type="submit" value="Delete" class="btn btn-outline-danger h-100">
											</form>
										</td>
									</c:when>
									<c:when test="${book.borrower.id == null}">
										<td>
											<a href="/books/${book.id}/borrow" class="btn btn-outline-success">Borrow</a>
										</td>
									</c:when>
									<c:otherwise>
										<td>
											<p><strong><em>Book is already borrowed</em></strong></p>
										</td>
									</c:otherwise>
								</c:choose>
								
								
							</tr>
						</c:if>
					
				</c:forEach>
			</tbody>		
		</table>
		<!-- Write a table to see all borrowed user books -->
		<p>Books borrowed by you:</p>
		<table class="table table-hover">
			<thead>
				<tr>
					<th scope="col">ID</th>
					<th scope="col">Title</th>
					<th scope="col">Author Name</th>
					<th scope="col">Posted By</th>
					<th scope="col">Actions</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="book" items="${borrowedBooks}">
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
						<td>
							<a href="/books/${book.id}/unborrow" class="btn btn-outline-success">Return</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	
</body>
</html>