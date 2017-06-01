<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
</script>
<style>
</style>
</head>
<body>
${tvo.board.title }<br>
${tvo.board.author }<br>
${tvo.board.hiredate }
<c:forEach var="file" items="${tvo.fvo }">
${file.originName }<br>
</c:forEach>
<a href="list">리스트가기</a>
</body>
</html>