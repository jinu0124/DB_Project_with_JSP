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
<title>material_search</title>
</head>
<body><% // ��� �˻� ��� â -> search_kind�� � �������� �˻��ߴ����� �޾ƿͼ� �˻� if������
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
		int user_ST_ID = Integer.parseInt(request.getParameter("user_ST_ID"));
		int money = Integer.parseInt(request.getParameter("money"));
		String material_search = (String)request.getParameter("material_search");
		String search = (String)request.getParameter("search");
		
		List<Object> material_IDlist = new ArrayList<Object>();
		List<Object> material_namelist = new ArrayList<Object>();
		List<Object> originlist = new ArrayList<Object>();
		List<Object> kindlist = new ArrayList<Object>();
		List<Object> pricelist = new ArrayList<Object>();
		
		String material_listQ1 = "select material_ID, material_name, origin, kind, price from material where material_name like '%"+search+"%';";
		String material_listQ2 = "select material_ID, material_name, origin, kind, price from material where origin like '%"+search+"%';";
		String material_listQ3 = "select material_ID, material_name, origin, kind, price from material where kind like '%"+search+"%';";
		
		if(material_search.equals("material_name"))
		{
			rs = stmt.executeQuery(material_listQ1);
			while(rs.next())
			{
				material_IDlist.add(rs.getInt("material_ID"));
				material_namelist.add(rs.getString("material_name"));
				originlist.add(rs.getString("origin"));
				kindlist.add(rs.getString("kind"));
				pricelist.add(rs.getInt("price"));
			}
		}
		else if(material_search.equals("origin"))
		{
			rs = stmt.executeQuery(material_listQ2);
			while(rs.next())
			{
				material_IDlist.add(rs.getInt("material_ID"));
				material_namelist.add(rs.getString("material_name"));
				originlist.add(rs.getString("origin"));
				kindlist.add(rs.getString("kind"));
				pricelist.add(rs.getInt("price"));
			}
		}
		else if(material_search.equals("kind"))
		{
			rs = stmt.executeQuery(material_listQ3);
			while(rs.next())
			{
				material_IDlist.add(rs.getInt("material_ID"));
				material_namelist.add(rs.getString("material_name"));
				originlist.add(rs.getString("origin"));
				kindlist.add(rs.getString("kind"));
				pricelist.add(rs.getInt("price"));
			}
		}
		
		if(material_IDlist != null)
		{
			%>
			�˻� ���<br>
			<%
			for(int i =0; i<material_IDlist.size(); i++)
			{
				%>
				���ID :<%=material_IDlist.get(i) %>/����̸� : <%=material_namelist.get(i) %>/������ :<%=originlist.get(i) %>/���� :<%=kindlist.get(i) %>���� :<%=pricelist.get(i) %><br>
				 
				<%
			}
			%><%
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