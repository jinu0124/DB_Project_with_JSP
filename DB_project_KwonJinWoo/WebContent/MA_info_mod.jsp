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
<title>MA_info_mod</title>
</head>
<body><%// 마법사의 정보 수정 화면 -> 수정 정보 받아서 테이블에 update하기
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
		int magician_ID = 0;
		magician_ID = Integer.parseInt(request.getParameter("magician_ID"));
		int classs = Integer.parseInt(request.getParameter("class"));
		int MP = Integer.parseInt(request.getParameter("MP"));
		int money = Integer.parseInt(request.getParameter("money"));
		int age = Integer.parseInt(request.getParameter("age"));
		int store_ID = Integer.parseInt(request.getParameter("store_ID"));
		String Fname = (String)request.getParameter("Fname");
		String Lname = (String)request.getParameter("Lname");
		String tribe = (String)request.getParameter("tribe");
		String user_MA_ID = (String)request.getParameter("user_MA_ID");
		String nativee = (String)request.getParameter("native");
		String job = (String)request.getParameter("job");
		String property = (String)request.getParameter("property");
		String user_pw = (String)request.getParameter("user_pw");
		
		System.out.println("MA_INFO_MOD2 :"+magician_ID+classs+MP+money+age+store_ID+Fname+Lname+tribe+user_MA_ID+nativee+job+property+user_pw);
		String updMA = "update magician set class = "+classs+",MP = "+MP+",money = "+money+",age = "+age+",store_ID = "+store_ID+",Fname = '"+Fname+"',Lname = '"+Lname+"',tribe = '"+tribe+"',user_MA_ID = '"+user_MA_ID+"',user_pw = des_encrypt('"+user_pw+"'),native = '"+nativee+"',job = '"+job+"' where magician_ID = "+magician_ID+";";
		stmt.executeQuery(updMA);
		if(magician_ID != 0)
		{
			stmt.executeQuery(updMA);
			%>
			<p>성공적으로 수정이 완료되었습니다.</p>
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
	<input type="button" value="돌아가기" onclick="history.go(-1)">
	<input type="button" value="로그아웃" onclick="location.href='http://localhost:8080/1113/form.jsp'">
	</body>
	</html>