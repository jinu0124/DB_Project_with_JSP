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
<title>ST_buy</title>
</head>
<body><% // 소비자가 상회에서 재료나 마법을 사기위한 페이지(재료 구매시, )
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
		int consumer_ID = Integer.parseInt(request.getParameter("consumer_ID"));
		int store_ID = Integer.parseInt(request.getParameter("store_ID"));
		int money = Integer.parseInt(request.getParameter("money"));
		String CSproperty = (String)request.getParameter("property");
		
		List<Object> material_ID = new ArrayList<Object>();
		List<Object> material_name = new ArrayList<Object>();
		List<Object> origin = new ArrayList<Object>();
		List<Object> kind = new ArrayList<Object>();
		List<Object> price = new ArrayList<Object>();
		
		String store_material = "select material.material_ID as material_ID, material_name, origin, kind, price from material, material_have where material.material_ID = material_have.material_ID and store_ID = "+store_ID+"";
		rs = stmt.executeQuery(store_material);
		while(rs.next())
		{
			material_ID.add(rs.getInt("material_ID"));
			material_name.add(rs.getString("material_name"));
			origin.add(rs.getString("origin"));
			kind.add(rs.getString("kind"));
			price.add(rs.getInt("price"));
		}
		int j = 0;
		System.out.println("money :"+money);
		%>
		<form action = "ST_buy_complete.jsp" method = "post">
			<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
			<h4> 판매 재료 LIST(구입하기)</h4>
			</a><div style="DISPLAY: none">
			갯수 :<input type = "number" name = "count" min = "1" required=""><br>
			재료번호 :<input type="number" name = "material_ID" min = "1" max = <%=material_ID.size() %>><br>
			<%//재료 번호가 넘어가거나 0이하가 적히는것을 방지
				j = 0;
				for(int i=0; i<material_ID.size(); i++)
				{
					j++;
					%>
					<input type = "hidden" name = "consumer_ID" value=<%=consumer_ID %>>
					<input type = "hidden" name = "store_ID" value=<%=store_ID %>>
					<input type = "hidden" name = "money" value=<%=money %>>
					<%=j %>. 재료 이름 :<%=material_name.get(i) %>/원산지 :<%=origin.get(i) %>/종류 :<%=kind.get(i) %>/가격 :<%=price.get(i) %>
					<br>
					
					<%
				}
			%><button type="submit">재료구매</button><br>
			</div>
			</form>
			
			<form action = "ST_material_search.jsp" method = "post">
			<input type = "hidden" name = "store_ID" value=<%=store_ID %>>
			<input type="text" name="search">
			<button type = "submit">상회 내 재료 이름 검색</button>
			</form>
			
			<%
			List<Object> magic_ID = new ArrayList<Object>();
			List<Object> magic_name = new ArrayList<Object>();
			List<Object> sale_price = new ArrayList<Object>();
			List<Object> classs = new ArrayList<Object>();
			List<Object> property = new ArrayList<Object>();
			
			
			String magicQ = "select magic_ID, magic_name, sale_price, class, property from magic where store_ID = "+store_ID+";";
			
			rs = stmt.executeQuery(magicQ);
			while(rs.next())
			{
				magic_ID.add(rs.getInt("magic_ID"));
				magic_name.add(rs.getString("magic_name"));
				sale_price.add(rs.getInt("sale_price"));
				classs.add(rs.getInt("class"));
				property.add(rs.getString("property"));//마법의 속성
			}
			%>
			<form action = "ST_magic_buy.jsp" method = "post">
			<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
			<h4> 판매 마법 list(마법구매)</h4>
			</a><div style="DISPLAY: none">
			<%
				j = 0;
				for(int i=0; i<magic_ID.size(); i++)
				{
					j++;
					%>
					<a href="ST_magic_buy.jsp?consumer_ID=<%=consumer_ID %>&store_ID=<%=store_ID %>&money=<%=money %>&sale_price=<%=sale_price.get(i) %>&magic_ID=<%=magic_ID.get(i) %>"> <%=j %>. 마법 ID :<%=magic_ID.get(i) %>/마법 이름 :<%=magic_name.get(i) %>/판매가격 :<%=sale_price.get(i) %>/클래스 :<%=classs.get(i) %>/속성 :<%=property.get(i) %>(구매하기)</a>
					<%if(CSproperty.equals(property.get(i))){%> 10%할인 <%} %><br>
					<%
				}
			%>
			</div>
			</form>
			<form action = "ST_magic_search.jsp" method = "post">
			<input type = "hidden" name = "store_ID" value=<%=store_ID %>>
			<input type="text" name="search">
			<button type = "submit">상회 내 마법 이름 검색</button>
			</form>
			
		<%
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
	<input type="button" value="돌아가기" onclick="history.go(-1)">
	<input type="button" value="로그아웃" onclick="location.href='http://localhost:8080/1113/form.jsp'">
	</body>
	</html>