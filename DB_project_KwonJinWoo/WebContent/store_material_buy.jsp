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
<title>��� ���â</title>
</head>
<body><% // 
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
		%><h4> ��� ��� â�Դϴ�.</h4>
		<%
		String user_ST_ID  = null;
		int store_ID = 0;
		int store_money = 0;
		user_ST_ID = (String)request.getParameter("user_ST_ID");
		store_ID = Integer.parseInt(request.getParameter("store_ID"));
		store_money = Integer.parseInt(request.getParameter("store_money"));
		String Allmaterial = "select material_ID, price, material_name, origin, kind from material";
		
		List<Object> material_IDlist = new ArrayList<Object>();
		List<Object> pricelist = new ArrayList<Object>();
		List<Object> material_namelist = new ArrayList<Object>();
		List<Object> originlist = new ArrayList<Object>();
		List<Object> kindlist = new ArrayList<Object>();
		
		rs = stmt.executeQuery(Allmaterial);
		while(rs.next())
		{
			material_IDlist.add(rs.getInt("material_ID"));
			pricelist.add(rs.getInt("price"));
			material_namelist.add(rs.getString("material_name"));
			originlist.add(rs.getString("origin"));
			kindlist.add(rs.getString("kind"));
		}
		int j = 0;
		%>
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>��ü ��� LIST(Click, ����ϱ�)</h2>
		</a><div style="DISPLAY: none">
		<%
			for(int i=0; i<material_IDlist.size(); i++)
			{
				j++;
				%>
				<form action = "material_info_reg.jsp" method = "post">
				<input type="hidden" name="material_ID" value = <%=material_IDlist.get(i) %>>
				<input type="hidden" name="material_name" value = <%=material_namelist.get(i) %>>
				<input type="hidden" name="store_ID" value = <%=store_ID %>>
				<input type = "hidden" name = "price" value = <%=pricelist.get(i) %>>
				<input type = "hidden" name = "store_money" value = <%=store_money %>>
				<p><%=j %>. ���ID :<%=material_IDlist.get(i) %>/����̸� :<%=material_namelist.get(i) %>/�ݾ� :<%=pricelist.get(i) %>/������ :<%=originlist.get(i) %>/���� :<%=kindlist.get(i) %></a><input type="number" name = "material_num" min = "1" max = "100" required = ""> (�����Է�)<input type="submit" value = "���"><br></p>
				</form>
			<%
			}
		%>
		</div>	
		<%
		
		//	String magician_ID = null;
		//magician_ID = Integer.parseInt(request.getParameter("magician_ID"));
		//magic_ID = Integer.parseInt(request.getParameter("magic_ID"));
		
		//System.out.println("here :"+magician_ID+magic_ID);
		
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