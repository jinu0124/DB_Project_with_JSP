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
<title>material_ST_info</title>
</head>
<body><%//상점에서 재료 정보
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
		
		String material_name = null;
		String origin = null;
		String kind = null;
		int price= 0;
		
		stmt=conn.createStatement();
		int material_ID = Integer.parseInt(request.getParameter("material_ID"));
		
		String material_info = "Select material_name, origin, kind, price from material where material_ID = "+material_ID+"";
		rs = stmt.executeQuery(material_info);
		while(rs.next())
		{
			material_name = rs.getString("material_name");
			origin = rs.getString("origin");
			kind =rs.getString("kind");
			price = rs.getInt("price");
		}
		%>
		<h4> 재료정보</h4>
		<p> 재료 이름: <%=material_name %><br> 재료 원산지: <%=origin %><br> 재료 종류: <%=kind %><br> 재료 가격: <%=price %><br></p>
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