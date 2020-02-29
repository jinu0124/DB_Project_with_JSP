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

<%//상점에서 재료 를 사서 등록하는 창
String url= request.getHeader("referer");
	String driver = "org.mariadb.jdbc.Driver";//connection jar 파일
	String ID = (String)session.getAttribute("ID");
	Statement stmt = null;
	Connection conn = null;
	ResultSet rs = null;//SQL 출력 받아올때 사용
	
	String jdbcDriver = "jdbc:mariadb://localhost:3306/rodus";
	String dbUser = "root";
	String dbPass = "1103";
	String redirect = null;
	try {
		Class.forName(driver);//등록
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//연결
		
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
		//쿼리문에 기존에 있던 재료, 없던재료에 대해 insert, update 구분이 필요함 
		int STmoney = 0;
		int material_IDQ = 0;
		rs = stmt.executeQuery(store_money);
		while(rs.next())
		{
			STmoney = rs.getInt("money");
		}
		if(STmoney-material_num*price < 0)
		{
			%><p>Money가 부족합니다. </p>
			<input type="button" value="돌아가기" onclick="history.go(-1)"> <%
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
				stmt.executeQuery(store_material_reg1);//기존에 있던 재료를 사서 update 시킬때
				stmt.executeQuery(store_money_pay);
			}
			else
			{
				stmt.executeQuery(store_material_reg2);//기존에 없던 재료여서 insert 할때
				stmt.executeQuery(store_money_pay);
			}
			%>
			성공적으로 <%=material_name %> <%=material_num %>개를 구입하였습니다.
			<input type="button" value="돌아가기" onclick="history.go(-1)">
			<input type="button" value="로그아웃" onclick="location.href='http://localhost:8080/1113/form.jsp'">
			<%
			//여기부터 material_have table에 store랑material ID 및 갯수 쿼리 실행시키기
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