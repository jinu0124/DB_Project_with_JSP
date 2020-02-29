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
<title>material_search</title>
</head>
<body><% // 재료 검색 결과 창 -> search_kind로 어떤 기준으로 검색했는지를 받아와서 검색 if문으로
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
		int store_ID = Integer.parseInt(request.getParameter("store_ID"));
		int user_ST_ID = Integer.parseInt(request.getParameter("user_ST_ID"));
		int money = Integer.parseInt(request.getParameter("money"));
		String material_search = (String)request.getParameter("material_search");
		String search = (String)request.getParameter("search");
		
		List<Object> material_IDlist = new ArrayList<Object>();
		List<Object> material_namelist = new ArrayList<Object>();
		List<Object> originlist = new ArrayList<Object>();
		List<Object> kindlist = new ArrayList<Object>();
		List<Object> pricelist = new ArrayList<Object>();
		
		String material_listQ1 = "select material_ID, material_name, origin, kind, price from material where material_name like '%"+search+"%';";
		String material_listQ2 = "select material_ID, material_name, origin, kind, price from material where origin like '%"+search+"%';";
		String material_listQ3 = "select material_ID, material_name, origin, kind, price from material where kind like '%"+search+"%';";
		
		if(material_search.equals("material_name"))
		{
			rs = stmt.executeQuery(material_listQ1);
			while(rs.next())
			{
				material_IDlist.add(rs.getInt("material_ID"));
				material_namelist.add(rs.getString("material_name"));
				originlist.add(rs.getString("origin"));
				kindlist.add(rs.getString("kind"));
				pricelist.add(rs.getInt("price"));
			}
		}
		else if(material_search.equals("origin"))
		{
			rs = stmt.executeQuery(material_listQ2);
			while(rs.next())
			{
				material_IDlist.add(rs.getInt("material_ID"));
				material_namelist.add(rs.getString("material_name"));
				originlist.add(rs.getString("origin"));
				kindlist.add(rs.getString("kind"));
				pricelist.add(rs.getInt("price"));
			}
		}
		else if(material_search.equals("kind"))
		{
			rs = stmt.executeQuery(material_listQ3);
			while(rs.next())
			{
				material_IDlist.add(rs.getInt("material_ID"));
				material_namelist.add(rs.getString("material_name"));
				originlist.add(rs.getString("origin"));
				kindlist.add(rs.getString("kind"));
				pricelist.add(rs.getInt("price"));
			}
		}
		
		if(material_IDlist != null)
		{
			%>
			검색 결과<br>
			<%
			for(int i =0; i<material_IDlist.size(); i++)
			{
				%>
				재료ID :<%=material_IDlist.get(i) %>/재료이름 : <%=material_namelist.get(i) %>/원산지 :<%=originlist.get(i) %>/종류 :<%=kindlist.get(i) %>가격 :<%=pricelist.get(i) %><br>
				 
				<%
			}
			%><%
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