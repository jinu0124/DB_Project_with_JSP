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
<title>magician_ST_info</title>
</head>
<body><% // 상회에서 소속마법사 list에서 클릭하면 소속된 마법사의 상세정보를 보여주는 창
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
		int magician_ID = Integer.parseInt(request.getParameter("magician_ID"));
		String Fname = (String)(request.getParameter("Fname"));
		String Lname = (String)(request.getParameter("Lname"));
		int age = Integer.parseInt(request.getParameter("age"));
		String tribe = (String)(request.getParameter("tribe"));
		int classs = Integer.parseInt(request.getParameter("class"));
		String property = (String)(request.getParameter("property"));
		//int money = Integer.parseInt(request.getParameter("money"));
		//int MP = Integer.parseInt(request.getParameter("MP"));
		//String nativee = (String)(request.getParameter("native"));//href 파라미터 제한이 7개여서 3개는 db에서 다시 받아옴
		//a href로 모두 한번에 안넘어옴
		System.out.println("magician_ID :"+magician_ID+Fname+Lname+age+tribe+classs+property);
		String magician_info = "select MP, money, native from magician where magician_ID = "+magician_ID+"";
		
		rs = stmt.executeQuery(magician_info);
		String nativee = null;
		int MP = 0;
		int money = 0;
		while(rs.next())
		{
			MP = rs.getInt("MP");
			money = rs.getInt("money");
			nativee = rs.getString("native");
		}
		
		//System.out.println("here :"+magician_ID+magic_ID);
		%>
		소속 마법사 정보<br>
		<p>마법사ID :<%=magician_ID %><br>이름(성) :<%=Fname %><br>이름 :<%=Lname %><br>나이 :<%=age %><br>속성 :<%=property %><br>부족 :<%=tribe %><br>클래스 :<%=classs %><br>자금 :<%=money %><br>MP :<%=MP %><br>출생지 :<%=nativee %></p>
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
	<input type="button" value="로그아웃" onclick="form.jsp">
	</body>
	</html>