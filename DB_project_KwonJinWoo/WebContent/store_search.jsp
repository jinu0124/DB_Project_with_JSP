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
<title>Insert title here</title>
</head>
<body><% // 소비자에서 상회를 검색할때 검색어 받아서 뿌리는 창
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
		
		String search = (String)request.getParameter("search");
		String search_kind = (String)request.getParameter("search_kind");
		String consumer_ID = (String)request.getParameter("consumer_ID");
		
		Integer searchint = 0;
		stmt=conn.createStatement();
		//rs = stmt.executeQuery();
		String store_search1 = "select * from store where store_name like '%"+search+"%'";
		String store_search2 = "select * from store where boss like '%"+search+"%'";
		
		
		List<Object> store_ID = new ArrayList<Object>();
		List<Object> store_name = new ArrayList<Object>();
		List<Object> address = new ArrayList<Object>();
		List<Object> tribe = new ArrayList<Object>();
		List<Object> boss = new ArrayList<Object>();
		List<Object> class_permit = new ArrayList<Object>();
		
		if(search_kind.equals("store_name"))
		{
			rs = stmt.executeQuery(store_search1);
			while(rs.next())
			{
				store_ID.add(rs.getInt("store_ID"));
				store_name.add(rs.getString("store_name"));
				address.add(rs.getString("address"));
				tribe.add(rs.getString("tribe"));
				boss.add(rs.getString("boss"));
				class_permit.add(rs.getInt("class_permit"));
			}
		}
		else if(search_kind.equals("boss"))
		{
			rs = stmt.executeQuery(store_search2);
			while(rs.next())
			{
				store_ID.add(rs.getInt("store_ID"));
				store_name.add(rs.getString("store_name"));
				address.add(rs.getString("address"));
				tribe.add(rs.getString("tribe"));
				boss.add(rs.getString("boss"));
				class_permit.add(rs.getInt("class_permit"));
			}
		}
		else if(search_kind.equals("class_permit")){
			searchint = Integer.parseInt(search);
			System.out.println("searchint :"+searchint);
			String store_search3 = "select * from store where class_permit = "+searchint+"";
			rs = stmt.executeQuery(store_search3);
			while(rs.next())
			{
				store_ID.add(rs.getInt("store_ID"));
				store_name.add(rs.getString("store_name"));
				address.add(rs.getString("address"));
				tribe.add(rs.getString("tribe"));
				boss.add(rs.getString("boss"));
				class_permit.add(rs.getInt("class_permit"));
			}
		}%>
		<p>검색 결과<p><%
		for(int i =0; i< store_ID.size(); i++)
		{
		%>
		<p><%=i+1 %>. 상회 ID :<%=store_ID.get(i) %>/상호명 :<%=store_name.get(i) %>/대표자명 :<%=boss.get(i) %><br>
		부족 :<%=tribe.get(i) %>/주소 :<%=address.get(i) %>/
		허가클래스 :<%=class_permit.get(i) %><br>
		<%
		}
	//	String magician_ID = null;
		//magician_ID = Integer.parseInt(request.getParameter("magician_ID"));
		//magic_ID = Integer.parseInt(request.getParameter("magic_ID"));
		
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