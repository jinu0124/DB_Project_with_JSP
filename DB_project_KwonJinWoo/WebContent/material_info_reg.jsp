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
<title>material_info_reg</title>
</head>
<body>

<%//�������� ��� �� �缭 ����ϴ� â
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
		String material_name = (String)request.getParameter("material_name");
		int material_ID = Integer.parseInt(request.getParameter("material_ID"));
		int store_ID = Integer.parseInt(request.getParameter("store_ID"));
		int material_num = Integer.parseInt(request.getParameter("material_num"));
		int price = Integer.parseInt(request.getParameter("price"));
		//int store_money = Integer.parseInt(request.getParameter("store_money"));
		
		System.out.println("In material info reg :"+material_ID+store_ID+material_num);
		
		String store_money = "select money from store where store_ID = "+store_ID+"";
		String store_have = "select material_ID from material_have where store_ID = "+store_ID+" and material_ID = "+material_ID+";";
		String store_material_reg1 = "update material_have set material_cnt = material_cnt + "+material_num+" where store_ID = "+store_ID+" and material_ID = "+material_ID+";";
		String store_material_reg2 = "insert into material_have(store_ID, material_ID, material_cnt) values("+store_ID+", "+material_ID+", "+material_num+");";
		String store_money_pay = "update store set money = money - "+material_num+"*"+price+" where store_ID = "+store_ID+";";
		%><%
		//�������� ������ �ִ� ���, ������ῡ ���� insert, update ������ �ʿ��� 
		int STmoney = 0;
		int material_IDQ = 0;
		rs = stmt.executeQuery(store_money);
		while(rs.next())
		{
			STmoney = rs.getInt("money");
		}
		if(STmoney-material_num*price < 0)
		{
			%><p>Money�� �����մϴ�. </p>
			<input type="button" value="���ư���" onclick="history.go(-1)"> <%
		}
		else
		{
			rs=stmt.executeQuery(store_have);
			while(rs.next())
			{
				material_IDQ = rs.getInt("material_ID");
			}
			if(material_IDQ >= 1000)
			{
				stmt.executeQuery(store_material_reg1);//������ �ִ� ��Ḧ �缭 update ��ų��
				stmt.executeQuery(store_money_pay);
			}
			else
			{
				stmt.executeQuery(store_material_reg2);//������ ���� ��Ῡ�� insert �Ҷ�
				stmt.executeQuery(store_money_pay);
			}
			%>
			���������� <%=material_name %> <%=material_num %>���� �����Ͽ����ϴ�.
			<input type="button" value="���ư���" onclick="history.go(-1)">
			<input type="button" value="�α׾ƿ�" onclick="location.href='http://localhost:8080/1113/form.jsp'">
			<%
			//������� material_have table�� store��material ID �� ���� ���� �����Ű��
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
	
	</body>
	</html>