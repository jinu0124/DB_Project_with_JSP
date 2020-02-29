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
<title>MA_ST_info</title>
</head>
<body><% // 마법사에서 소속된 상회 상세정보 보여주는 창
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
		
		int store_ID = Integer.parseInt(request.getParameter("store_ID"));
		
		String store_info = "select * from store where store_ID = "+store_ID+";";
		
		rs = stmt.executeQuery(store_info);
		String store_name = null;
		String address = null;
		String boss = null;
		String tribe = null;
		int class_permit = 0;
		int money = 0;
		while(rs.next())
		{
			store_name = rs.getString("store_name");
			address = rs.getString("address");
			boss = rs.getString("boss");
			tribe = rs.getString("tribe");
			class_permit = rs.getInt("class_permit");
			money = rs.getInt("money");
		}
		
		%>
		<p> 상회정보</p>
		<p>상회 ID : <%=store_ID %></p>
		<p>상회 이름 : <%=store_name %></p>
		<p>주소 : <%=address %></p>
		<p>대표자명 : <%=boss %></p>
		<p>부족 : <%=tribe %></p>
		<p>허가클래스 : <%=class_permit %></p>
		<p>자금 : <%=money %></p><br>
		<%
		
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