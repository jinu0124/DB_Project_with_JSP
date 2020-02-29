<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>material_reg</title>
</head>
<body>
	<h1>재료 등록 창</h1>
	<%
try{//get 방식은 url에 뜬다, post 방식은 값을 숨겨서 보낸다(url 에 도출 X).
	String url= request.getHeader("referer");
		String driver = "org.mariadb.jdbc.Driver";//connection jar 파일
		String user_MA_ID = request.getParameter("user_MA_ID");
		System.out.println("material_reg :"+user_MA_ID);
		Statement stmt = null;
		Connection conn = null;
		ResultSet rs = null;//SQL 출력 받아올때 사용
		
		String material_name = request.getParameter("material_name");
		String origin = request.getParameter("origin");
		String kind = request.getParameter("kind");
		int price = Integer.parseInt(request.getParameter("price"));
		
		if(material_name != null)
		{
			material_name = material_name.toUpperCase();
		}
		if(origin != null)
		{
			origin = origin.toUpperCase();
		}
		if(kind != null)
		{
			kind = kind.toUpperCase();
		}
		
		System.out.println("material_reg :"+price);
		String material_reg = "insert into material(material_name, origin, kind, price) values('"+material_name+"', '"+origin+"', '"+kind+"', "+price+");";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/rodus";
		String dbUser = "root";
		String dbPass = "1103";
		String redirect = null;
		
		try {
			Class.forName(driver);//등록
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//연결
			stmt=conn.createStatement();
			//rs = stmt.executeQuery(material_reg);
		stmt.executeQuery(material_reg);
		
		%>성공적으로 재료가 등록되었습니다.<br>
		재료이름 :<%=material_name %><br>
		<input type="button" value="돌아가기" onclick="location.href='<%=url %>'">
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
</body>
</html>