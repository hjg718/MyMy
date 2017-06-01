<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script>
var author = '${tvo.board.author}';
var currUser = '<sec:authentication property="name"/>';
$(function(){
	$("#re").hide();
});

function re(){
	$("#re").toggle();
}
function edit(){

	<c:url var="edit" value="edit">
	<c:param name ="num" value="${tvo.board.num}"/>
	</c:url>
	location.href="${edit}"
}
function remove(){

	var param ={};
	param.num = ${tvo.board.num};
	param.${_csrf.parameterName } = '${_csrf.token }';
	if(!confirm("정말 삭제하시겠어요?"))return;
	$.ajax({
		url : "remove",
		method : "post",
		data : param,
		dataType : "json",
		success : function(r){
			if(r.pass){
				alert("삭제되었습니다.");
				location.href="list"
			}
			else{
				alert("답글이 있는 글은 삭제 안됩니다.");
			}
		},
		error : function(x,s,e){
			alert("오류!");
		}
	});
}
function down(saveName,originName){
	$("#saveName").val(saveName);
	$("#originName").val(originName);
	$("#downForm").submit();
}
</script>
<style>
.intro{
display: inline-block;
border: 1px solid black;
width: 300px;
margin-bottom: 5px;
background-color: rgb(230,170,170);
}
#t{
text-align: center;
}
#contents{
height: 200px;
background-color: pink;
}
#re{
margin: 10px auto;
width :250px;
}
a{
text-decoration: none;
}
a:LINK,a:VISITED {
	color: black;
}
#contents{
	vertical-align: middle;
}
#att{
	vertical-align: middle;
}
.fname{
	text-align: left;
	display: inline-block;
	width: 150px;
}
.size{
	text-align: right;
	display: inline-block;
}
#desc{
	background-color: aqua;
}
</style>
</head>
<body>
<div id="t">
&ensp;&ensp;&ensp;번호&ensp;&ensp; <div id="num" class="intro">${tvo.board.num}</div><br>
&ensp;&ensp;&ensp;제목&ensp;&ensp; <div id="title" class="intro">${tvo.board.title}</div><br>
&ensp;&ensp;글쓴이&ensp; <div id="author" class="intro">${tvo.board.author}</div><br>
&ensp;&ensp;&ensp;내용&ensp;&ensp; <div id="contents" class="intro">${tvo.board.contents}</div><br>
첨부 파일 <div id="att"class="intro">
<div class="fname">파일 제목</div>
<div class="size">파일 크기</div><br>
<c:forEach var="file" items="${tvo.fvo }">
<div class="fname"><a href="javascript:down('${file.saveName }','${file.originName }');">${file.originName }</a></div>
<div class="size">${file.fSize }</div><br>
</c:forEach>
</div><br>
</div>
&ensp;&ensp;&ensp;&ensp;[<a href="list">목록보기</a>]
<sec:authorize access="isAuthenticated()">
[<a href="javascript:re();">답글쓰기</a>]
</sec:authorize>
<sec:authentication property="name" var="id"/>
<sec:authorize access="${ id==tvo.board.author}">
[<a href="javascript:edit()">수정하기</a>]
[<a href="javascript:remove()">삭제하기</a>]
</sec:authorize>
<div id="re">
<form action="rep" method="post">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"> 
<input type="hidden" name="ref" value="${tvo.board.num}">
<input type="hidden" name="author" value='<sec:authentication property="name"/>'>
-제목 <br>
<input type="text" name=title value="Re:${tvo.board.title}"><br>
-내용 <br>
<textarea rows="10" cols="30" name="contents"></textarea><br>
<button type="submit">저장</button><button type="reset">취소</button>
</form>
<form action="down" method="post" id="downForm">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"> 
<input type="hidden" name="saveName" id="saveName">
<input type="hidden" name="originName" id="originName">
</form>
</div>
</body>
</html>