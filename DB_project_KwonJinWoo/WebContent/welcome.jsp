<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	String user_name = (String) session.getAttribute("user_name");//받아올때 Object로 받아오기 때문에 String으로 형변환
	String url= request.getHeader("referer");//로그아웃(왔던곳으로 되돌아가기)// 이전에 왔던 URL을 보관하고있음
%>	
	<h1> 환영합니다. <%=user_name %>님 :)</h1>
	
	<input type="button" value="돌아가기" onclick="location.href='<%=url %>'">
	
	<div>
	
	</div>
</body>
</html>