<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>material_reg</title>
</head>
<body>
	<h1>��� ��� â</h1>
	<%
try{//get ����� url�� ���, post ����� ���� ���ܼ� ������(url �� ���� X).
	String url= request.getHeader("referer");
		String driver = "org.mariadb.jdbc.Driver";//connection jar ����
		String user_MA_ID = request.getParameter("user_MA_ID");
		System.out.println("material_reg :"+user_MA_ID);
		Statement stmt = null;
		Connection conn = null;
		ResultSet rs = null;//SQL ��� �޾ƿö� ���
		
		String material_name = request.getParameter("material_name");
		String origin = request.getParameter("origin");
		String kind = request.getParameter("kind");
		int price = Integer.parseInt(request.getParameter("price"));
		
		if(material_name != null)
		{
			material_name = material_name.toUpperCase();
		}
		if(origin != null)
		{
			origin = origin.toUpperCase();
		}
		if(kind != null)
		{
			kind = kind.toUpperCase();
		}
		
		System.out.println("material_reg :"+price);
		String material_reg = "insert into material(material_name, origin, kind, price) values('"+material_name+"', '"+origin+"', '"+kind+"', "+price+");";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/rodus";
		String dbUser = "root";
		String dbPass = "1103";
		String redirect = null;
		
		try {
			Class.forName(driver);//���
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//����
			stmt=conn.createStatement();
			//rs = stmt.executeQuery(material_reg);
		stmt.executeQuery(material_reg);
		
		%>���������� ��ᰡ ��ϵǾ����ϴ�.<br>
		����̸� :<%=material_name %><br>
		<input type="button" value="���ư���" onclick="location.href='<%=url %>'">
		<%
		}
		catch(ClassNotFoundException e)
		{
			e.printStackTrace();
		}
	}catch(NumberFormatException e)//�߸��� ���� �Ķ���ͷ� �޾����� exception e
	{%>
	<p> �ùٸ��� ���� �����Դϴ�. 
	<%
	}
	%>
</body>
</html>