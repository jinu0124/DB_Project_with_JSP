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
<body><% // �����翡�� �Ҽӵ� ��ȸ ������ �����ִ� â
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
		<p> ��ȸ����</p>
		<p>��ȸ ID : <%=store_ID %></p>
		<p>��ȸ �̸� : <%=store_name %></p>
		<p>�ּ� : <%=address %></p>
		<p>��ǥ�ڸ� : <%=boss %></p>
		<p>���� : <%=tribe %></p>
		<p>�㰡Ŭ���� : <%=class_permit %></p>
		<p>�ڱ� : <%=money %></p><br>
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
	<input type="button" value="���ư���" onclick="history.go(-1)">
	<input type="button" value="�α׾ƿ�" onclick="location.href='http://localhost:8080/1113/form.jsp'">
	</body>
	</html>