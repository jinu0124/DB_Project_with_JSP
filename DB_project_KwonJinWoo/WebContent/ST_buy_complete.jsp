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
<title>ST_buy_complete</title>
</head>
<body><% // 소비자가 상회를 골라서 최종 재료를 구매하는 창(상점의 재료 깎아주기, 상점 돈올려주기, 소비자 돈 내려주기, 소비자 재료 소유 갯수 올려주기)
String url= request.getHeader("referer");
	String driver = "org.mariadb.jdbc.Driver";//connection jar 파일
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
		
		int store_ID = 0;
		int material_ID = 0;
		
		stmt=conn.createStatement();
		store_ID = Integer.parseInt(request.getParameter("store_ID"));
		int consumer_ID = Integer.parseInt(request.getParameter("consumer_ID"));
		material_ID = Integer.parseInt(request.getParameter("material_ID"));
		int count = Integer.parseInt(request.getParameter("count"));
		//String material_name = (String)request.getParameter("material_name");
		//int price = Integer.parseInt(request.getParameter("price"));
		int money = Integer.parseInt(request.getParameter("money"));
		
		System.out.println("material_ID, store_ID, count :"+material_ID+store_ID+count);
		System.out.println("CS_money :"+money);
		material_ID = material_ID + 1000;
		
		String material_enough = "select material_cnt from material_have where material_ID = "+material_ID+" and store_ID = "+store_ID+";";
		String material_info = "select material_name, price from material where material_ID = "+material_ID+"";
		String sale_purchase = "insert into sale_purchase(store_ID, consumer_ID, material_ID, count) values("+store_ID+", "+consumer_ID+", "+material_ID+", "+count+")";
		
		int MTcount = 0;
		rs = stmt.executeQuery(material_enough);
		while(rs.next())
		{
			MTcount = rs.getInt("material_cnt");
		}
		int price = 0;
		String material_name = null;
		rs = stmt.executeQuery(material_info);
		while(rs.next())
		{
			material_name = rs.getString("material_name");
			price = rs.getInt("price");
		}
		String store_material_cnt = "update material_have set material_cnt = "+MTcount+"-"+count+" where material_ID = "+material_ID+" and store_ID = "+store_ID+";";
		String store_money = "update store set money = money + "+price+"*"+count+" where store_ID = "+store_ID+";";
		String CS_money = "update consumer set money = money - "+price+"*"+count+" where consumer_ID = "+consumer_ID+"";
		if(money - price*count >= 0 && MTcount >= count)
		{
			stmt.executeQuery(CS_money);//소비자 돈 깎기
			stmt.executeQuery(sale_purchase);//table에 trade정보 넣기
			stmt.executeQuery(store_money);//상점 돈 넣기
			stmt.executeQuery(store_material_cnt);
			%>
			<p>성공적으로 material_ID :<%=material_ID %> Name :<%=material_name %> 갯수 :<%=count %> 개를 구입하였습니다.</p>
			<input type="button" value="돌아가기" onclick="history.go(-1)">
			<input type="button" value="로그아웃" onclick="location.href='http://localhost:8080/1113/form.jsp'">
			<%
		}
		else if(money - price*count < 0 && MTcount>= count){
			%>
			보유 money가 부족하여 구매에 실패하였습니다.
			<input type="button" value="돌아가기" onclick="history.go(-1)">
			<input type="button" value="로그아웃" onclick="http://localhost:8080/1113/form.jsp">
			<%
		}
		else if(MTcount < count)//상점의 재고 상태 확인
		{
			%>
			<p>상점이 보유한 재고가 부족합니다.</p>
			<input type="button" value="돌아가기" onclick="history.go(-1)">
			<input type="button" value="로그아웃" onclick="http://localhost:8080/1113/form.jsp">
			<%
		}
}
catch(NumberFormatException e)
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