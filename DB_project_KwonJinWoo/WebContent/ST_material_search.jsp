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
<body><%
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
		String search = (String)request.getParameter("search");
		
		List<Object> material_ID = new ArrayList<Object>();
		List<Object> material_name = new ArrayList<Object>();
		List<Object> origin = new ArrayList<Object>();
		List<Object> kind = new ArrayList<Object>();
		List<Object> price = new ArrayList<Object>();
		
		String materialQ = "select material.material_ID, material_name, origin, kind, price from material, material_have where material.material_ID = material_have.material_ID and material_name like '%"+search+"%' and material_have.store_ID = "+store_ID+";";
		rs = stmt.executeQuery(materialQ);
		while(rs.next())
		{
			material_ID.add(rs.getInt("material_ID"));
			material_name.add(rs.getString("material_name"));
			origin.add(rs.getString("origin"));
			kind.add(rs.getString("kind"));
			price.add(rs.getInt("price"));
		}
		
		%>
		<p>검색결과</p> <br>
		<%
		for(int i=0; i<material_ID.size(); i++)
		{
			%>
			<p>재료ID : <%=material_ID.get(i) %>/재료이름 : <%=material_name.get(i) %>/원산지 : <%=origin.get(i) %>/종류 : <%=kind.get(i) %>/가격 : <%=price.get(i) %><br></p>
			<%
		}
		%>
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