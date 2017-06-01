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
function edit(){
	var param = $("#editForm").serialize();
	$.ajax({
		url : "update",
		method : "post",
		data : param,
		dataType : "json",
		success : function(res){
			if(res.pass){
				alert("수정완료");
				<c:url var="read" value="read">
				<c:param name ="num" value="${tvo.board.num}"/>
				</c:url>
				location.href="${read}"
			}
		},
		error : function(x,s,e){
			alert("오류!");
		}
	});
}
function del(id,fileName){
	var param={};
	param.name = fileName;
	param.${_csrf.parameterName } = '${_csrf.token }';
	$.ajax({
		url : "fileDel",
		method : "post",
		data : param,
		success : function(r){
			if(r.pass){
				$("#"+id).remove();
				alert("삭제되었습니다.")
			}
		},
		error : function(x,s,e){
			alert("오류!");
		}
	});
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
<form id="editForm" >
&ensp;&ensp;&ensp;번호&ensp;&ensp; <div id="num" class="intro">${tvo.board.num}</div><br>
&ensp;&ensp;&ensp;제목&ensp;&ensp; <input id="title" name="title" class="intro" value="${tvo.board.title}"><br>
&ensp;&ensp;글쓴이&ensp; <div id="author" class="intro">${tvo.board.author}</div><br>
&ensp;&ensp;&ensp;내용&ensp;&ensp; <textarea id="contents" name="contents" class="intro">${tvo.board.contents}</textarea><br>
<input type="hidden" name="num" value="${tvo.board.num }">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"> 
첨부 파일 <div id="att"class="intro">
<div class="fname">파일 제목</div>
<div class="size">파일 크기</div><br>
<c:forEach var="file" items="${tvo.fvo }" varStatus="num">
<div id="${num.index }">
<span class="fname">${file.originName }</span>
<span class="size">${file.fSize }</span>
<button type="button" onclick="del('${num.index }','${file.saveName }')">삭제하기</button>
</div>
</c:forEach>
</div><br>
<button type="button" onclick="edit();">수정하기</button>
</form>
</div>
</body>
</html>