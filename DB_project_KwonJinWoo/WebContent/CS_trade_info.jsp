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
<title>Consumer_trade_info</title>
</head>
<body><% // 소비자에서 거래내역 확인하는 창
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
		int consumer_ID = Integer.parseInt(request.getParameter("consumer_ID"));
		String Fname = (String)(request.getParameter("Fname"));
		String Lname = (String)(request.getParameter("Lname"));
		
		List<Object> trade_ID = new ArrayList<Object>();
		List<Object> material_ID = new ArrayList<Object>();
		List<Object> material_name = new ArrayList<Object>();
		List<Object> count = new ArrayList<Object>();
		List<Object> tot_price = new ArrayList<Object>();
		
		String tradeQ = "SELECT trade_ID, sale_purchase.material_ID AS material_ID, material_name, COUNT, count*price AS tot_price FROM sale_purchase, material, consumer WHERE consumer.consumer_ID = sale_purchase.consumer_ID and sale_purchase.material_ID = material.material_ID AND sale_purchase.material_ID IS NOT NULL AND sale_purchase.consumer_ID = "+consumer_ID+" ORDER BY trade_ID;";
		//거래, 소비자, 마법 테이블을 합쳐서 trade_ID, 판매된 가격, 구매한 소비자의 정보, 마법이름 을 가져옴, natural join + 마법사의 ID 동일한 것 끼리
		rs = stmt.executeQuery(tradeQ);
		while(rs.next())
		{
			trade_ID.add(rs.getInt("trade_ID"));
			material_ID.add(rs.getInt("material_ID"));
			material_name.add(rs.getString("material_name"));
			count.add(rs.getInt("COUNT"));
			tot_price.add(rs.getInt("tot_price"));
		}
		int j = 0;
		%>
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>재료 거래 내역 LIST(Click)</h2>
		</a><div style="DISPLAY: none">
		<%
		for(int i=0; i<trade_ID.size(); i++)
		{
			j++;
			%>
			<p><%=j %>.거래번호:<%=trade_ID.get(i) %>/재료ID:<%=material_ID.get(i) %>/재료이름:<%=material_name.get(i) %>/갯수:<%=count.get(i) %>/가격:<%=tot_price.get(i) %></p>
			<%
		}
		%>
		</div>
		<%
			
		List<Object> MAtrade_ID = new ArrayList<Object>();
		List<Object> magic_ID = new ArrayList<Object>();
		List<Object> magic_name = new ArrayList<Object>();
		List<Object> sale_price = new ArrayList<Object>();
		String MAtradeQ = "SELECT trade_ID, sale_purchase.magic_ID AS magic_ID, magic_name, sale_price FROM sale_purchase, magic WHERE sale_purchase.magic_ID = magic.magic_ID AND sale_purchase.magic_ID IS NOT NULL AND sale_purchase.consumer_ID = "+consumer_ID+" ORDER BY trade_ID;";
		rs = stmt.executeQuery(MAtradeQ);
		while(rs.next())
		{
			MAtrade_ID.add(rs.getInt("trade_ID"));
			magic_ID.add(rs.getInt("magic_ID"));
			magic_name.add(rs.getString("magic_name"));
			sale_price.add(rs.getInt("sale_price"));
		}
		%>
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>마법 거래 내역 LIST(Click)</h2>
		</a><div style="DISPLAY: none">
		<%
		for(int i=0; i<MAtrade_ID.size(); i++)
		{
			j++;
			%>
			<p><%=j %>.거래번호:<%=MAtrade_ID.get(i) %>/마법ID:<%=magic_ID.get(i) %>/마법이름:<%=magic_name.get(i) %>/가격:<%=sale_price.get(i) %></p>
			<%
		}
	%>
</div>
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
	<input type="button" value="돌아가기" onclick="history.go(-1)">
	<input type="button" value="로그아웃" onclick="location.href='http://localhost:8080/1113/form.jsp'">
	</body>
	</html>