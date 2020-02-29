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
<title>magic_trade_info</title>
</head>
<body><% // 상회에서 재료,마법 거래내역 확인 
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
		
		stmt=conn.createStatement();
		//rs = stmt.executeQuery();
		int store_ID = Integer.parseInt(request.getParameter("store_ID"));
		String boss = (String)(request.getParameter("boss"));//대표자명
		
		List<Object> trade_ID = new ArrayList<Object>();
		List<Object> material_ID = new ArrayList<Object>();
		List<Object> material_name = new ArrayList<Object>();
		List<Object> tot_price = new ArrayList<Object>();
		List<Object> count = new ArrayList<Object>();
		List<Object> consumer_ID = new ArrayList<Object>();
		//------------재료 관련 내역 리스트
		
		List<Object> MAtrade_ID = new ArrayList<Object>();
		List<Object> magic_ID = new ArrayList<Object>();
		List<Object> magic_name = new ArrayList<Object>();
		List<Object> sale_price = new ArrayList<Object>();
		List<Object> MAconsumer_ID = new ArrayList<Object>();
		List<Object> Fname = new ArrayList<Object>();
		List<Object> Lname = new ArrayList<Object>();
		//------------마법 관련 내역 리스트
		
		List<Object> MTmaterial_ID = new ArrayList<Object>();
		List<Object> material_cnt = new ArrayList<Object>();
		List<Object> MTmaterial_name = new ArrayList<Object>();
		//------------재료 관련 보유 리스트
		
		String tradeQ = "SELECT trade_ID, sale_purchase.consumer_ID as consumer_ID, sale_purchase.material_ID as material_ID, material_name, price*COUNT as tot_price, count FROM material, store, sale_purchase WHERE store.store_ID = sale_purchase.store_ID AND material.material_ID = sale_purchase.material_ID AND sale_purchase.store_ID = "+store_ID+" AND sale_purchase.material_ID IS NOT NULL ORDER BY trade_ID;";
		//거래, 상회, 재료 테이블을 합쳐서 trade_ID, trade ID순서로 정렬 , 재료관련 거래내역 뽑아오기 natural join + 상회의 ID 동일한 것 끼리
		rs = stmt.executeQuery(tradeQ);
		while(rs.next())
		{
			trade_ID.add(rs.getInt("trade_ID"));
			material_ID.add(rs.getInt("material_ID"));
			material_name.add(rs.getString("material_name"));
			tot_price.add(rs.getInt("tot_price"));
			count.add(rs.getInt("count"));
			consumer_ID.add(rs.getInt("consumer_ID"));
		}
		int j = 0;
		%>
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>판매 재료거래 LIST(Click)</h2>
		</a><div style="DISPLAY: none">
		<%
			for(int i=0; i<trade_ID.size(); i++)
			{
				j++;
				%>
			<p><%=j %>.거래번호:<%=trade_ID.get(i) %>/재료ID:<%=material_ID.get(i) %>/재료이름:<%=material_name.get(i) %>/가격:<%=tot_price.get(i) %>/갯수:<%=count.get(i) %>/소비자ID:<%=consumer_ID.get(i) %></p>
			<%
		}
		%>
		</div>
		<%
		
		String MAtradeQ = "SELECT trade_ID, sale_purchase.magic_ID AS magic_ID, magic_name, sale_price, sale_purchase.consumer_ID AS consumer_ID, Fname, Lname FROM magic, sale_purchase, store, consumer WHERE consumer.consumer_ID = sale_purchase.consumer_ID and magic.magic_ID = sale_purchase.magic_ID AND store.store_ID = magic.store_ID AND sale_purchase.store_ID = "+store_ID+" AND sale_purchase.magic_ID IS NOT NULL ORDER BY trade_ID;";
		//거래, 상회, 재료, 소비자 테이블을 합쳐서 trade_ID, trade ID순서로 정렬 , 마법관련 거래내역 뽑아오기 natural join + 상회의 ID 동일한 것 끼리 등등
		rs = stmt.executeQuery(MAtradeQ);
		while(rs.next())
		{
			MAtrade_ID.add(rs.getInt("trade_ID"));
			magic_ID.add(rs.getInt("magic_ID"));
			magic_name.add(rs.getString("magic_name"));
			sale_price.add(rs.getInt("sale_price"));
			MAconsumer_ID.add(rs.getInt("consumer_ID"));
			Fname.add(rs.getString("Fname"));
			Lname.add(rs.getString("Lname"));
		}
		
		j = 0;
		%>
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>판매 마법거래 LIST(Click)</h2>
		</a><div style="DISPLAY: none">
		<%
			for(int i=0; i<MAtrade_ID.size(); i++)
			{
				j++;
				%>
			<p><%=j %>.거래번호:<%=MAtrade_ID.get(i) %>/마법ID:<%=magic_ID.get(i) %>/마법이름:<%=magic_name.get(i) %>/판매가격:<%=sale_price.get(i) %>/소비자ID:<%=MAconsumer_ID.get(i) %>/소비자이름:<%=Fname.get(i) %> <%=Lname.get(i) %></p>
			<%
		}
		%>
		</div>
		<%
		
		String MTQ = "select distinct material_have.material_ID, material_name, material_cnt from material, material_have where material.material_ID = material_have.material_ID and material_have.store_ID = "+store_ID+";";
		rs = stmt.executeQuery(MTQ);
		
		while(rs.next())
		{
			MTmaterial_ID.add(rs.getInt("material_ID"));
			material_cnt.add(rs.getInt("material_cnt"));
			MTmaterial_name.add(rs.getString("material_name"));
		}
		j = 0;
		%>
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>구매 재료 LIST(Click)</h2>
		</a><div style="DISPLAY: none">
		<%
			for(int i=0; i<MTmaterial_ID.size(); i++)
			{
				j++;
				%>
			<p><%=j %>.재료ID:<%=MTmaterial_ID.get(i) %>/재료갯수:<%=material_cnt.get(i) %>/재료 이름:<%=MTmaterial_name.get(i) %></p>
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