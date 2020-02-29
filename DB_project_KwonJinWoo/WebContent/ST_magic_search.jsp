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
<title>ST_material_search</title>
</head>
<body><% //소비자가 상회에서 마법을 검색하여 뿌려주는 창
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
		String search = (String)request.getParameter("search");
		int store_ID = Integer.parseInt(request.getParameter("store_ID"));
		
		String magicQ = "select * from magic where store_ID = "+store_ID+" and magic_name like '%"+search+"%';";
		List<Object> magic_name = new ArrayList<Object>();
		List<Object> magic_ID = new ArrayList<Object>();
		List<Object> classs = new ArrayList<Object>();
		List<Object> property = new ArrayList<Object>();
		List<Object> sale_price = new ArrayList<Object>();
		
		rs = stmt.executeQuery(magicQ);
		while(rs.next())
		{
			magic_ID.add(rs.getInt("magic_ID"));
			magic_name.add(rs.getString("magic_name"));
			classs.add(rs.getInt("class"));
			property.add(rs.getString("property"));
			sale_price.add(rs.getInt("sale_price"));
		}
		
		%>
		<p> 검색결과 </p>
		<%
		for(int k = 0; k<magic_ID.size(); k++)
		{
			%>
			<p>마법ID : <%=magic_ID.get(k) %>/마법이름 : <%=magic_name.get(k) %>/클래스 : <%=classs.get(k) %>/속성 : <%=property.get(k) %>/판매가격 : <%=sale_price.get(k) %><br></p>
			<%
		}
		%>
		
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