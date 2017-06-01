<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
function find(){
	var param = $("#findForm").serialize();
	$.ajax({
		url : "findId",
		method : "post",
		data : param,
		dataType : "json",
		success : function(res){
			alert(res.id);
			
		},
		error : function(x,s,e){
			alert("오류!");
		}
	});
	return false;
}
</script>
<style>
</style>
</head>
<body>
<form onsubmit="return find();" method="post" id="findForm">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
name<input type="text" name="name">
PHONE<input type="text" name="phone">
<button type="submit">찾기</button>
</form>
<a href="loginForm">로그인하러가기</a>
</body>
</html>