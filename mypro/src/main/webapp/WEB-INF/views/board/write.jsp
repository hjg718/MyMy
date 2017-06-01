<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    <%@taglib prefix="f" uri="http://www.springframework.org/tags/form" %>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
var num =0;
function add(){
	var input= $("<input type='file' name='files["+(num++)+"]'><br>");
	$("#file").append(input);
}
</script>
<style>
</style>
</head>
<body>
<f:form enctype="multipart/form-data" method="post" modelAttribute="boardVO" 
action="write?${_csrf.parameterName }=${_csrf.token }">
<input type="hidden" name="author" value='<sec:authentication property="name"/>'>
제목<f:input path="title"/><br>
내용 <f:textarea path="contents" cols="50" rows="10"/><br>
<div id="file">
<f:errors path="files"></f:errors>
</div>
<button type="button" onclick="add();">첨부파일 추가하기</button>
<button type="submit">저장하기</button>
</f:form>
</body>
</html>