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
<title>ST_info_mod</title>
</head>
<body><% // 상점 정보 수정하기 창
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
	int store_ID = 0;
	try {
		Class.forName(driver);//등록
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//연결
		
		stmt=conn.createStatement();
		//rs = stmt.executeQuery();
		store_ID = Integer.parseInt(request.getParameter("store_ID"));
		String store_name = (String)request.getParameter("store_name");
		String address = (String)request.getParameter("address");
		String boss = (String)request.getParameter("boss");
		String tribe = (String)request.getParameter("tribe");
		String user_ST_ID = (String)request.getParameter("user_ST_ID");
		String user_pw = (String)request.getParameter("user_pw");
		int class_permit = Integer.parseInt(request.getParameter("class_permit"));
		int money = Integer.parseInt(request.getParameter("money"));
		user_pw = "des_encrypt('"+user_pw+"')";
		String STmod = "update store set store_name = '"+store_name+"', address = '"+address+"',boss = '"+boss+"',user_ST_ID = '"+user_ST_ID+"', user_pw = "+user_pw+", class_permit = "+class_permit+" where store_ID = "+store_ID+"";
		
		
		
		
		if(store_ID != 0)
		{
			stmt.executeQuery(STmod);
			%><p> 성공적으로 변경되었습니다.</p><%
		}
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