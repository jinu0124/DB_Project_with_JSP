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
<title>material_cnt</title>
</head>
<body>
<form action = searchMA.jsp method="post"><%// ���ߴ� ���̾���
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
	redirect = null;
	int count = 0;
	int magic_ID = 0;
	magic_ID = Integer.parseInt(request.getParameter("magic_findID"));
	count = Integer.parseInt(request.getParameter("count"));
	System.out.println("magic_findID in material :"+magic_ID);
	//if(magic_ID != 0)//��ưŬ������ �Ѿ�ͼ� ���� ��ư ��°, ����ID�� �ٽ� ���� ������ searchMA.jsp�� �Ѱ��ֱ�
		//session.setAttribute("k",k);


		List<Object> material_name = new ArrayList<Object>();
		List<Object> material_cnt = new ArrayList<Object>();
		
			System.out.println("if�� �� :"+magic_ID+count);
			//session.setAttribute("count", count);
			
			String joinMA_use_MT_cnt = "Select material_name, material_cnt from material, magic, use_use where magic.magic_ID = use_use.magic_ID and use_use.material_ID = material.material_ID and use_use.magic_ID = "+magic_ID+";";
			rs = stmt.executeQuery(joinMA_use_MT_cnt);
			while(rs.next())
			{
				material_name.add(rs.getString("material_name"));
				material_cnt.add(rs.getInt("material_cnt"));
				System.out.println("material_name:"+material_name);
			}
			for(int i = 0; i<material_name.size(); i++)
			{
			%><label> �ʿ��� ��� :<%=material_name.get(i) %> ���� :<%=material_cnt.get(i) %></label><br>
			<%
			}
			%><input type="button" value="���ư���" onclick="history.go(-1)">
			</form><%
}catch(NumberFormatException e)
{
	e.printStackTrace();
}
	catch(SQLException se)
	{
		se.printStackTrace();
	}
	%>
</body>



</body>
</html>