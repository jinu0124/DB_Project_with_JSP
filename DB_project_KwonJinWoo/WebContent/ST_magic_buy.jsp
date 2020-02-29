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
<title>ST_magic_buy</title>
</head>
<body><% // 소비자에서 마법상회의 마법 살때 마무리 page
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
		int store_ID = Integer.parseInt(request.getParameter("store_ID"));
		int money = Integer.parseInt(request.getParameter("money"));//consumer의 보유 머니
		double sale_price = Integer.parseInt(request.getParameter("sale_price"));//나누기를 위해 double 형으로 받음
		int magic_ID = Integer.parseInt(request.getParameter("magic_ID"));
		//String property = (String)(request.getParameter("property"));
		
		Integer magic_IDQ = 0;//magic_ID 가 null이 되면 받아온것이 없으므로 갖고있지 않은 magic이기 때문에 구입 가능
		System.out.println("ST_magic_buy :"+consumer_ID+store_ID+money+sale_price+magic_ID);
		String magic_info = "select property, magic_name, class from magic where magic_ID = "+magic_ID+";";
		String magic_buy = "insert into sale_purchase(store_ID, consumer_ID, magic_ID) values("+store_ID+", "+consumer_ID+", "+magic_ID+")";
		String magic_haveQ = "select magic_ID from sale_purchase where consumer_ID = "+consumer_ID+" and magic_ID = "+magic_ID+";";
		
		String magician = "select magician_ID from magic where magic_ID = "+magic_ID+";";
		String property = null;
		String magic_name = null;
		int classs = 0;
		
		int magician_ID = 0;
		rs = stmt.executeQuery(magician);
		while(rs.next())
		{
			magician_ID = rs.getInt("magician_ID");
		}//마법을 창조한 마법사 ID
		
		rs = stmt.executeQuery(magic_info);
		while(rs.next())
		{
			property = rs.getString("property");
			magic_name = rs.getString("magic_name");
			classs = rs.getInt("class");
		}
		String CSproperty = null;
		String consumer_property = "select property from consumer where consumer_ID = "+consumer_ID+";";
		rs = stmt.executeQuery(consumer_property);
		while(rs.next())
		{
			CSproperty = rs.getString("property");//사려는 마법과 속성이 같은지 비교해주기 위해서 property 불러옴
		}
		
		if(CSproperty.equals(property))//같으면1 반환 , property:마법의 속성, CSproperty:소비자의 속성 -> 같으면 할인 10퍼
		{//자신 속성과 같은 마법 10퍼 할인
			sale_price = Math.ceil(sale_price*0.9);//10퍼 할인하되 소수점은 올린다.
			System.out.println("할인받은 90퍼 가격 :"+sale_price);
		}
		
		double sale_pricefloor = 0;
		double sale_priceceil = 0;
		
		sale_pricefloor = Math.floor(sale_price/2);//내림(math함수 사용)//마법 거래시 수입 반띵하기
		sale_priceceil = Math.ceil(sale_price/2);//올림
		System.out.println("최종 floor, ceil :"+sale_pricefloor+sale_priceceil);
		
		
		
		String consumer_money = "update consumer set money = case when '"+CSproperty+"' = '"+property+"' then money - "+sale_price+" else money - "+sale_price+" end where consumer_ID = "+consumer_ID+";";
		String magician_money = "update magician set money = case when '"+CSproperty+"' = '"+property+"' then money + "+sale_priceceil+" else money + "+sale_priceceil+" end where magician_ID = "+magician_ID+";";
		String store_money = "update store set money = case when '"+CSproperty+"' = '"+property+"' then money + "+sale_pricefloor+" else money + "+sale_pricefloor+" end where store_ID = "+store_ID+";";
		//소비자가 속성에 의한 할인(10%)을 받으면 0.45배씩 받고 못받으면 0.5배씩 받음(update set = case when then else 사용)
		rs = stmt.executeQuery(magic_haveQ);
		while(rs.next())
		{
			magic_IDQ = rs.getInt("magic_ID");
		}
		
		if(money - sale_price >= 0 && magic_IDQ == 0)
		{
			stmt.executeQuery(magic_buy);
			stmt.executeQuery(consumer_money);//소비자 돈 깎기
			stmt.executeQuery(magician_money);//마법사 돈 오름
			stmt.executeQuery(store_money);//상회 돈오름
			%>
			마법<%=magic_name %>을(를) 성공적으로 구입하였습니다.<br>
			<input type="button" value="돌아가기" onclick="history.go(-1)">
			<input type="button" value="로그아웃" onclick="location.href='http://localhost:8080/1113/form.jsp'">
		}
		else if(magic_IDQ == magic_ID)
		{
			%>
			<p>이미 보유한 마법입니다.</p>
			<input type="button" value="돌아가기" onclick="history.go(-1)">
			<input type="button" value="로그아웃" onclick="location.href='http://localhost:8080/1113/form.jsp'">
			<%
		}
		else{
			%>
			보유한 money가 부족하여 구입하지 못하였습니다.<br>
			<input type="button" value="돌아가기" onclick="history.go(-1)">
			<input type="button" value="로그아웃" onclick="location.href='http://localhost:8080/1113/form.jsp'">
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
	
	</body>
	</html>