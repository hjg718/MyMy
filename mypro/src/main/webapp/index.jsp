
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<link rel="stylesheet"
	href="<c:url value="/resources/css/bootstrap.min.css"/>" />
<link rel="stylesheet"
	href="<c:url value="/resources/css/animate.min.css"/>" />
<link rel="stylesheet"
	href="<c:url value="/resources/css/ionicons.min.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/styles.css"/>" />
<script src="<c:url value="/resources/js/jquery.min.js"/>"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.easing.min.js"/>"></script>
<script src="<c:url value="/resources/js/wow.js"/>"></script>
<script src="<c:url value="/resources/js/scripts.js"/>"></script>
<script type="text/javascript">
function sub(){
	$("#loginForm").submit();
}
function logout() {
	$("#logout").submit();
}
</script>

</head>
<body>
	<nav id="topNav" class="navbar navbar-default navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand page-scroll" href="#first">hong</a>
			</div>
			<div class="navbar-collapse collapse" id="bs-navbar">
				<ul class="nav navbar-nav">
					<li><a href="board/list" class="page-scroll">게시판</a></li>
					<li><a href="user/join"  class="page-scroll">회원가입</a></li>
					
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li>
					<sec:authorize access="! isAuthenticated()">
					<a class="page-scroll" data-toggle="modal" href="#aboutModal">로그인</a>
						</sec:authorize>
							<sec:authorize access="isAuthenticated()">
					<a class="page-scroll" href="javascript:logout();">로그아웃</a>
						</sec:authorize>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<header id="first">
		<div class="header-content">
			<div class="inner">
				<h1 class="cursive" >Welcome</h1>
				<br><br>
				<a	href="board/list" class="btn btn-primary btn-lg">게시판</a>
				<a href="user/loginForm" class="btn btn-primary btn-lg">로그인</a>
				 <a	href="user/join" class="btn btn-primary btn-lg">회원가입</a> 
			</div>
		</div>
	</header>

	<div id="aboutModal" class="modal fade" tabindex="-1" role="dialog"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-body">
					<form action='<c:url value="/user/login"></c:url>' method="post"
						id="loginForm">
						<input type="hidden" name="${_csrf.parameterName }"
							value="${_csrf.token }"> 
							ID &nbsp;&nbsp;&nbsp;<input type="text" name="id" value="11">&nbsp;
							PWD <input type="password" name="pwd" value="11">&nbsp;&nbsp;
						<a href="javascript:sub()" class="btn btn-primary btn-sm">로그인</a>
					</form>
				</div>
			</div>
		</div>
	</div>
<c:url var="out" value="/logout"/>
<form action="${out}" id="logout" method="post">
  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form>
</body>
</html>
