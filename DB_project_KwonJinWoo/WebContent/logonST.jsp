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
<title>상점주 로그인</title>
</head>
<body>
<%
response.setHeader("Pragma", "no-cache");//돌아갈때 세션 만료시키기!!
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setDateHeader("Expires", 0L);//do not cache in proxy server
%>
	<h1>로그인 창</h1>
	<%
	try{//get 방식은 url에 뜬다, post 방식은 값을 숨겨서 보낸다(url 에 도출 X).
		
		String driver = "org.mariadb.jdbc.Driver";//connection jar 파일
		String ID = (String)session.getAttribute("ID");
		Statement stmt = null;
		Connection conn = null;
		ResultSet rs = null;
		System.out.println(ID);
		
		String IDS = "select boss, user_ST_ID, store_ID, class_permit, money from store;";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/rodus";
		String dbUser = "root";
		String dbPass = "1103";
		String redirect = null;

		
		try {
			Class.forName(driver);//등록
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//연결
			
			stmt=conn.createStatement();
			rs = stmt.executeQuery(IDS);
			while(rs.next())
			{
				String user_ST_ID = rs.getString("user_ST_ID");
				String boss = rs.getString("boss");
				int store_ID = rs.getInt("store_ID");
				int class_permit = rs.getInt("class_permit");
				int money = rs.getInt("money");
				if(user_ST_ID != null)
				{
					if(user_ST_ID.equals(ID))
					{
						%>
						<p> <%=boss %>님 환영합니다.</p>
						<p> 역할군 : 마법상회주인</p> <br>
						<p> 허가 클래스 :<%=class_permit %></p>
						<p> 보유한 Money :<%=money %></p>
						<form action = "magician_reg_del.jsp" method = "post">
						<input type = "hidden" name = "user_ST_ID" value=<%=user_ST_ID%>>
						<input type = "hidden" name = "store_ID" value=<%=store_ID%>>
						<button type="submit">마법사 등록/삭제</button>
						</form>
						<form action = "store_material_buy.jsp" method = "post">
						<input type = "hidden" name = "store_ID" value = <%=store_ID %>>
						<input type = "hidden" name = "user_ST_ID" value = <%=user_ST_ID %>>
						<input type = "hidden" name = "store_money" value = <%=money %>>
						<button type = "submit">재고 등록</button><%//여기부터 재고등록하기~ %>
						</form>
						<form action = "material_search.jsp" method = "get">
						<input type = "hidden" name = "store_ID" value=<%=store_ID %>>
						<input type = "hidden" name = "user_ST_ID" value=<%=user_ST_ID %>>
						<input type = "hidden" name="money" value=<%= money%>>
						<select name = "material_search">
						<option value="material_name">재료이름</option><option value="origin">원산지</option><option value="kind">종류</option>
						</select>
						<input type="text" name="search">
						<button type = "submit">재고 검색</button>
						</form>
						<form action = "STnotice.jsp" method = "post">
						<input type = "hidden" name = "store_ID" value = <%=store_ID %>>
						<button type = "submit">상회 정보</button>
						</form>
						<form action = "store_trade_info.jsp" method="post">
						<input type = "hidden" name="store_ID" value=<%=store_ID %>>
						<input type = "hidden" name="boss" value=<%=boss %>>
						<button type = "submit">내 상회의 거래내역 확인</button>
						</form>
						
						<%
					}
				}
				else
				{
					
				}
			}
		String url= request.getHeader("referer");//로그아웃(왔던곳으로 되돌아가기)// 이전에 왔던 URL을 보관하고있음%>
			<input type="submit" value="로그아웃" onclick="location.href='http://localhost:8080/1113/form.jsp'">
			<%
		}
		catch(ClassNotFoundException e)
		{
			e.printStackTrace();
		}
	}catch(NumberFormatException e)//잘못된 값을 파라미터로 받았을때 exception e
	{%>
	<p> 올바르지 못한 정보입니다. 
	<%
	}
		%>