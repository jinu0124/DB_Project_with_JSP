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
<title>CS_info_mod</title>
</head>
<body><% // �Һ��� ȸ������ ���� �Ϸ� ǥ�� â
String url= request.getHeader("referer");
	String driver = "org.mariadb.jdbc.Driver";//connection jar ����
	String ID = (String)session.getAttribute("ID");
	Statement stmt = null;
	Connection conn = null;
	ResultSet rs = null;//SQL ��� �޾ƿö� ���
	
	String jdbcDriver = "jdbc:mariadb://localhost:3306/rodus";
	String dbUser = "root";
	String dbPass = "1103";
	String redirect = null;
	try {
		Class.forName(driver);//���
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//����
		
		stmt=conn.createStatement();
		//rs = stmt.executeQuery();
		int consumer_ID = 0;
		consumer_ID = Integer.parseInt(request.getParameter("consumer_ID"));
		String Fname = (String)request.getParameter("Fname");
		String Lname = (String)request.getParameter("Lname");
		int age = Integer.parseInt(request.getParameter("age"));
		String address = (String)request.getParameter("address");
		String property = (String)request.getParameter("property");
		int money = Integer.parseInt(request.getParameter("money"));
		String user_CS_ID = (String)request.getParameter("user_CS_ID");
		String user_pw = (String)request.getParameter("user_pw");
		user_pw = "des_encrypt('"+user_pw+"')";
		
		String upd_consumer = "update consumer set consumer_ID = "+consumer_ID+", Fname = '"+Fname+"', Lname = '"+Lname+"', age = "+age+", address = '"+address+"', property = '"+property+"', money = "+money+", user_CS_ID = '"+user_CS_ID+"', user_pw = "+user_pw+" where consumer_ID = "+consumer_ID+"";
		//String STmod = "update store set store_name = '"+store_name+"', address = '"+address+"',boss = '"+boss+"',user_ST_ID = '"+user_ST_ID+"', class_permit = "+class_permit+" where store_ID = "+store_ID+"";
		
		if(consumer_ID > 1000)
		{
			stmt.executeQuery(upd_consumer);
			%>
			���������� ���������� �ݿ��Ǿ����ϴ�. <br><%
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
	<input type="button" value="���ư���" onclick="history.go(-1)">
	<input type="button" value="�α׾ƿ�" onclick="location.href='http://localhost:8080/1113/form.jsp'">
	</body>
	</html>