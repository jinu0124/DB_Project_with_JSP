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
<body><%//�������� ��� ����
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
		<h4> �������</h4>
		<p> ��� �̸�: <%=material_name %><br> ��� ������: <%=origin %><br> ��� ����: <%=kind %><br> ��� ����: <%=price %><br></p>
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
	<input type="button" value="���ư���" onclick="history.go(-1)">
	<input type="button" value="�α׾ƿ�" onclick="location.href='http://localhost:8080/1113/form.jsp'">
	</body>
	</html>