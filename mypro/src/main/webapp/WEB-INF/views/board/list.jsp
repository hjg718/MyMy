<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<c:url var="url" value="/resources/jquery.bootpag.min.js"/>
 <script src="${url }"></script>
<link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css"/>" />
    <link rel="stylesheet" href="<c:url value="/resources/css/animate.min.css"/>" />
    <link rel="stylesheet" href="<c:url value="/resources/css/ionicons.min.css"/>" />
<link rel="stylesheet" href="<c:url value="/resources/css/styles.css"/>" />
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.easing.min.js"/>"></script>
<script src="<c:url value="/resources/js/wow.js"/>"></script>
<script src="<c:url value="/resources/js/scripts.js"/>"></script>
<script>
$(function(){
    $('#pageNav').bootpag({
        total: ${tvo.tpg},        /* total pages */
        page:  ${tvo.page},           /* current page */
        maxVisible: 5,      /* Links per page */
        leaps: true,
        firstLastUse: true,
        first: '←',
        last: '→',
        wrapClass: 'pagination',
        activeClass: 'active',
        disabledClass: 'disabled',
        nextClass: 'next',
        prevClass: 'prev',
        lastClass: 'last',
        firstClass: 'first'
    }).on("page", function(event, num){
    	var param={};
    	param.num = num;
    	param.${_csrf.parameterName } = '${_csrf.token }';
    	$.ajax({
    		url : 'getPage',
    		method : 'post',
    		data : param,
    		dataType : 'json',
    		success : function(res){
    			$("#td").empty();
    			for(var i=0;i<res.length;i++){
    			var cell = $("<div class='cell'></div>");
    			var col = $("<span class='col'>"+res[i].num+"</span>")
    			cell.append(col);
    			col=$("<span class='tt'><a href='javascript:read("+res[i].num+")'>"+res[i].title+"</a></span>");
    			cell.append(col);	
    			col=$("<span class='col' id='desc'>"+res[i].author+"</span>");
    			cell.append(col);	
    			$("#td").append(cell);
    			}
    		},
    		error : function(x,s,e){
    			alert('오류!');
    		}
    	});
    	
    	
    });
});
function read(num){
	$("#rn").val(num);
	$("#readBoard").submit();
}
function search(){
	var param = $("#searchForm").serialize();
	$.ajax({
		url : "search",
		method : "post",
		data : param,
		dataType : "json",
		success : function(res){
			if("false" in res){alert("해당 검색결과가 없습니다.");return;}
			$("#td").empty();
			for(var i=1;i<res.length;i++){
			var cell = $("<div class='cell'></div>");
			var col = $("<span class='col'>"+res[i].num+"</span>")
			cell.append(col);
			col=$("<span class='tt'><a href='javascript:read("+res[i].num+")'>"+res[i].title+"</a></span>");
			cell.append(col);	
			col=$("<span class='col' id='desc'>"+res[i].author+"</span>");
			cell.append(col);	
			$("#td").append(cell);
			}
			 $('#pageNav').empty();
			 $('#pageNav').off("page");
			  $('#pageNav').bootpag({
			        total: res[0].tpg,        /* total pages */
			        page:  res[0].page,           /* current page */
			        maxVisible: 5,      /* Links per page */
			        leaps: true,
			        firstLastUse: true,
			        first: '←',
			        last: '→',
			        wrapClass: 'pagination',
			        activeClass: 'active',
			        disabledClass: 'disabled',
			        nextClass: 'next',
			        prevClass: 'prev',
			        lastClass: 'last',
			        firstClass: 'first'
			    }).on("page", function(event, num){
			    	var param={};
			    	param.num = num;
			    	param.cat = $("select[name=cat]").val();
			    	param.keyword=$("input[name=keyword]").val();
			    	param.${_csrf.parameterName } = '${_csrf.token }';
			    	$.ajax({
			    		url : 'search',
			    		method : 'post',
			    		data : param,
			    		dataType : 'json',
			    		success : function(res){
			    			$("#td").empty();
			    			for(var i=1;i<res.length;i++){
			    			var cell = $("<div class='cell'></div>");
			    			var col = $("<span class='col'>"+res[i].num+"</span>")
			    			cell.append(col);
			    			col=$("<span class='tt'><a href='javascript:read("+res[i].num+")'>"+res[i].title+"</a></span>");
			    			cell.append(col);	
			    			col=$("<span class='col' id='desc'>"+res[i].author+"</span>");
			    			cell.append(col);	
			    			$("#td").append(cell);
			    			}
			    		},
			    		error : function(x,s,e){
			    			alert('오류!');
			    		}
			    	});
				});
			    	
		},
		error : function(x,s,e) {
			alert("오류!");
		}
		
	});
	return false;
}
function sub(){
	$("#loginForm").submit();
}
function logout() {
	$("#logout").submit();
}
</script>
<style>
body{
padding-top: 180px;
}
#con{
	text-align: center;
}
#th{
 	background-color: #333;
	text-align: center;
	margin-bottom: 5px;
	border-bottom: 3px solid black;
	font-size: 18pt;
	display: inline-block;
	width: 800px;
}
.cell{
	border: 1px solid black;
	font-size: 13pt;
	margin-bottom: 3px;
	height: 50px;
	line-height: 50px;
	margin: 2px auto;
	width: 800px;
	background-color: #333;

}
.col{
	white-space:nowrap;
	overflow:hidden;
	text-overflow: ellipsis;
	display: inline-block;
	width: 150px;
}
a{
	text-decoration: none;
}
a:LINK {
	color: black;
}
a:VISITED{
	color: black;
}
#pageNav{
	text-align: center;
}
#title{
	font-size: 50px;
}
.tt{
	display: inline-block;
	width: 300px;
		white-space:nowrap;
	overflow:hidden;
	text-overflow: ellipsis;
}
.cell .tt{
	width: 300px;
	text-align: left;
}
select, input{
background-color: #333;
}
select {
	height: 30px;
}
.pagination>li>a
{
background-color: #333;
border-color: black;
color: white;
}
/*눌려진거  */
.pagination>li>a:focus
{
color:black;
background-color:red;
border-color: black;
}
/*마우스 올린거  */
.pagination>li>a:hover
{
color:black;
background-color:blue;
border-color: black;
}
/*선택 된거  */
.pagination>.active>a,.pagination>.active>a:focus,.pagination>.active>a:hover
{
background-color:gray;
border-color: black;
color: white;
}
/* 선택불가  */
.pagination>.disabled>a,.pagination>.disabled>a:focus,.pagination>.disabled>a:hover
{
	background-color:#333;
	border-color: black;
	color: white;
}
</style>
</head>
<body>
<nav id="topNav" class="navbar navbar-default navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand page-scroll" href='<c:url value='/index.jsp'/>'>hong</a>
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
<div id="con">
<div id="title">게시판</div>
<br>
<div id="th">
<span class="col">번호</span>
<span class="tt">제목</span>
<span class="col">작성자</span>
</div>
<div id="td">
<c:forEach var="board" items="${tvo.boardList}">
<div class="cell">
<span class="col">${board.num }</span>
<span class="tt"><a href="javascript:read(${board.num })">${board.title}</a></span>
<span class="col"id="desc">${board.author}</span>
</div>
</c:forEach>
</div>

<div id ="pageNav"></div>
<form action="search" id="searchForm" onsubmit="return search();">
<select name="cat">
<option value="title" >제목</option>
<option value="contents">내용</option>
<option value="num" selected>글번호</option>
<option value="author">작성자</option>
</select>
<input type="text" name="keyword">
<input type="hidden" name="num" value="1">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"> 
<button type="submit" class="btn btn-primary btn-sm">검색</button>
</form>
<a href="writeForm">게시물작성</a>
<form action="read" method="post" id="readBoard">
<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }"> 
<input type="hidden" name="num" id="rn">
</form>
</div>
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