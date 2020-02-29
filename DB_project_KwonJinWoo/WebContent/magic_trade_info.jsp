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
<body><% // 마법사에서 마법사가 창조한 마법 거래내역 확인 
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
		int magician_ID = Integer.parseInt(request.getParameter("magician_ID"));
		String MAFname = (String)(request.getParameter("Fname"));
		String MALname = (String)(request.getParameter("Lname"));
		String property = (String)(request.getParameter("property"));
		
		List<Object> trade_ID = new ArrayList<Object>();
		List<Object> consumer_ID = new ArrayList<Object>();
		List<Object> sale_price = new ArrayList<Object>();
		List<Object> CSFname = new ArrayList<Object>();
		List<Object> CSLname = new ArrayList<Object>();
		List<Object> address = new ArrayList<Object>();
		List<Object> magic_ID = new ArrayList<Object>();
		List<Object> magic_name = new ArrayList<Object>();
		
		String tradeQ = "SELECT trade_ID, sale_purchase.magic_ID as magic_ID, sale_purchase.consumer_ID as consumer_ID, magic_name, sale_price, Fname, Lname, address FROM sale_purchase, magic, consumer WHERE magic.magic_ID = sale_purchase.magic_ID AND magician_ID = "+magician_ID+" AND sale_purchase.consumer_ID = consumer.consumer_ID;";
		//거래, 소비자, 마법 테이블을 합쳐서 trade_ID, 판매된 가격, 구매한 소비자의 정보, 마법이름 을 가져옴, natural join + 마법사의 ID 동일한 것 끼리
		rs = stmt.executeQuery(tradeQ);
		while(rs.next())
		{
			trade_ID.add(rs.getInt("trade_ID"));
			consumer_ID.add(rs.getInt("consumer_ID"));
			sale_price.add(rs.getInt("sale_price"));
			CSFname.add(rs.getString("Fname"));
			CSLname.add(rs.getString("Lname"));
			address.add(rs.getString("address"));
			magic_ID.add(rs.getInt("magic_ID"));
			magic_name.add(rs.getString("magic_name"));
		}
		int j = 0;
		%>
		<h4><%=MAFname %> <%=MALname %>님의 거래내역 list</h4>
		<%
		for(int i=0; i<trade_ID.size(); i++)
		{
			j++;
			%>
			<p><%=j %>.거래번호:<%=trade_ID.get(i) %>/소비자ID:<%=consumer_ID.get(i) %>/마법ID:<%=magic_ID.get(i) %>/소비자ID:<%=consumer_ID.get(i) %></p>
			<p>마법이름:<%=magic_name.get(i) %>/판매가격:<%=sale_price.get(i) %>/소비자이름:<%=CSFname.get(i) %> <%=CSLname.get(i) %>/소비자주소지:<%=address.get(i) %></p>
			<%
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
	<input type="button" value="돌아가기" onclick="history.go(-1)">
	<input type="button" value="로그아웃" onclick="location.href='http://localhost:8080/1113/form.jsp'">
	</body>
	</html>