<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%	String url= request.getHeader("referer"); //ID 회원가입시, ID가 중복될때 오는 창 (마법사 끼리, 소비자 끼리, 상회주인 끼리 따로 비교)%>
	<p>중복된 ID가 존재합니다.</p>
	<input type="button" value="돌아가기" onclick="location.href='<%=url %>'">
</body>
</html>