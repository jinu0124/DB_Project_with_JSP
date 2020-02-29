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
<title>ST_reg_del</title>
</head>
<body><% // 소비자에서 상회를 등록 하거나 삭제 하면 들어오는 페이지
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
		int reg_del = Integer.parseInt(request.getParameter("register"));
		int consumer_ID = Integer.parseInt(request.getParameter("consumer_ID"));
		int store_ID = Integer.parseInt(request.getParameter("store_ID"));
		
		String regQ = "insert into account(store_ID, consumer_ID) values("+store_ID+", "+consumer_ID+");";
		String delQ = "delete from account where store_ID = "+store_ID+" and consumer_ID = "+consumer_ID+"";
		
		if(reg_del==1)//등록으로 받았을때
		{
			stmt.executeQuery(regQ);
			%>
			<p>성공적으로 등록되었습니다.</p>
			<%
		}
		else if(reg_del==0)//삭제로 받았을때
		{
			stmt.executeQuery(delQ);
			%><p>성공적으로 삭제되었습니다.</p><%
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