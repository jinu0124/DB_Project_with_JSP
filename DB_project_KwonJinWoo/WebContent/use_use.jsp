<%@page import="java.sql.SQLException"%>
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
<title>Insert title here</title>
</head>
<body>
	<h1>���� ��� ���� â</h1>
	<%String url= request.getHeader("referer"); %>
	<%   	// use use ���̺� �ʿ� ��� ������ �������
try{//get ����� url�� ���, post ����� ���� ���ܼ� ������(url �� ���� X).
		String driver = "org.mariadb.jdbc.Driver";//connection jar ����
		Statement stmt = null;
		Connection conn = null;
		ResultSet rs = null;//SQL ��� �޾ƿö� ���
		String redirect = null;
		
		int material_cnt1 = 0;
		int material_cnt2 = 0;
		int material_cnt3 = 0;
		String jdbcDriver = "jdbc:mariadb://localhost:3306/rodus";
		String dbUser = "root";
		String dbPass = "1103";
			Class.forName(driver);//���
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//����
			stmt=conn.createStatement();
		
		int newmagic_ID1 = (Integer)session.getAttribute("newmagic_ID1");
		int material_ID1 = (Integer)session.getAttribute("material_ID1");
		int material_ID2 = (Integer)session.getAttribute("material_ID2");
		int material_ID3 = (Integer)session.getAttribute("material_ID3");
		material_cnt1 = (Integer)session.getAttribute("material_cnt1");
		material_cnt2 = (Integer)session.getAttribute("material_cnt2");
		material_cnt3 = (Integer)session.getAttribute("material_cnt3");
		String use_reg1 = (String)session.getAttribute("use_reg1");
		String use_reg2 = (String)session.getAttribute("use_reg2");
		String use_reg3 = (String)session.getAttribute("use_reg3");
		String magic_name = (String)session.getAttribute("magic_name");

		use_reg1 = "insert into use_use(magic_ID, material_ID, material_cnt) values("+newmagic_ID1+", "+material_ID1+", "+material_cnt1+")";
		use_reg2 = "insert into use_use(magic_ID, material_ID, material_cnt) values("+newmagic_ID1+", "+material_ID2+", "+material_cnt2+")";
		use_reg3 = "insert into use_use(magic_ID, material_ID, material_cnt) values("+newmagic_ID1+", "+material_ID3+", "+material_cnt3+")";
		
		if(material_cnt1 != 0)
		{
			stmt.executeQuery(use_reg1);
		}
		if(material_cnt2 != 0)
		{
			stmt.executeQuery(use_reg2);
		}
		if(material_cnt3 != 0)
		{
			stmt.executeQuery(use_reg3);
		}
		int count = 0;
		session.setAttribute("count", count);
		%>
		������ ���������� ��ϵǾ����ϴ�!<br>
		��ϵ� ���� �̸�:<%=magic_name %><br>
		<input type="button" value="���ư���" onclick="location.href='http://localhost:8080/1113/logonMA.jsp'"><br>
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
</body>
</html>