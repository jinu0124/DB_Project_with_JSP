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
<title>magician_ST_info</title>
</head>
<body><% // ��ȸ���� �ҼӸ����� list���� Ŭ���ϸ� �Ҽӵ� �������� �������� �����ִ� â
String url= request.getHeader("referer");
	String driver = "org.mariadb.jdbc.Driver";//connection jar ����
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
		int magician_ID = Integer.parseInt(request.getParameter("magician_ID"));
		String Fname = (String)(request.getParameter("Fname"));
		String Lname = (String)(request.getParameter("Lname"));
		int age = Integer.parseInt(request.getParameter("age"));
		String tribe = (String)(request.getParameter("tribe"));
		int classs = Integer.parseInt(request.getParameter("class"));
		String property = (String)(request.getParameter("property"));
		//int money = Integer.parseInt(request.getParameter("money"));
		//int MP = Integer.parseInt(request.getParameter("MP"));
		//String nativee = (String)(request.getParameter("native"));//href �Ķ���� ������ 7������ 3���� db���� �ٽ� �޾ƿ�
		//a href�� ��� �ѹ��� �ȳѾ��
		System.out.println("magician_ID :"+magician_ID+Fname+Lname+age+tribe+classs+property);
		String magician_info = "select MP, money, native from magician where magician_ID = "+magician_ID+"";
		
		rs = stmt.executeQuery(magician_info);
		String nativee = null;
		int MP = 0;
		int money = 0;
		while(rs.next())
		{
			MP = rs.getInt("MP");
			money = rs.getInt("money");
			nativee = rs.getString("native");
		}
		
		//System.out.println("here :"+magician_ID+magic_ID);
		%>
		�Ҽ� ������ ����<br>
		<p>������ID :<%=magician_ID %><br>�̸�(��) :<%=Fname %><br>�̸� :<%=Lname %><br>���� :<%=age %><br>�Ӽ� :<%=property %><br>���� :<%=tribe %><br>Ŭ���� :<%=classs %><br>�ڱ� :<%=money %><br>MP :<%=MP %><br>����� :<%=nativee %></p>
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
	<input type="button" value="�α׾ƿ�" onclick="form.jsp">
	</body>
	</html>