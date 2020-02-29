<%@page import="java.sql.SQLException"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>consumer_MT</title>
</head>
<body><% // 소비자 정보에서 소유한 재료 정보 확인 창
String url= request.getHeader("referer");
	String driver = "org.mariadb.jdbc.Driver";//connection jar 파일
	String ID = (String)session.getAttribute("ID");
	Statement stmt = null;
	Connection conn = null;
	ResultSet rs = null;//SQL 출력 받아올때 사용
	
	String jdbcDriver = "jdbc:mariadb://localhost:3306/rodus";
	String dbUser = "root";
	String dbPass = "1103";
	String redirect = null;
	try {
		Class.forName(driver);//등록
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//연결
		
		stmt=conn.createStatement();
		//rs = stmt.executeQuery();
		int material_ID = Integer.parseInt(request.getParameter("material_ID"));
		String material_name = (String)request.getParameter("material_name");
		String origin = (String)request.getParameter("origin");
		String kind = (String)request.getParameter("kind");
		int price = Integer.parseInt(request.getParameter("price"));
		//int count = Integer.parseInt(request.getParameter("count"));
		%>
		<p>상세 정보</p>
		<p>재료 ID :<%=material_ID %></p>
		<p>재료 이름 :<%=material_name %></p>
		<p>원산지 :<%=origin %></p>
		<p>종류 :<%=kind %></p>
		<p>가격 :<%=price %></p><br>
		<%
	if(redirect != null)
	{
		//String user_MA_ID = (String)request.getParameter("magician_ID");
	}
}catch(NumberFormatException e)
{
	e.printStackTrace();
}
	catch(SQLException se)
	{
		se.printStackTrace();
	}
	%>
	<input type="button" value="돌아가기" onclick="history.go(-1)">
	<input type="button" value="로그아웃" onclick="location.href='http://localhost:8080/1113/form.jsp'">
	</body>
	</html>