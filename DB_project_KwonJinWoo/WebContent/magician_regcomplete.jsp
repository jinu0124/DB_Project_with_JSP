<%@page import="java.util.function.Function"%>
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
<title>magician_regcomplete</title>
</head>
<body>
<h4><% // 상회에서 마법사를 등록 시키는 창 //마법 테이블과 마법사 테이블 둘 다 상회 이동을 하여주어야 함
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
	
	int magician_ID = 0;
	int store_ID = 0;
	store_ID = Integer.parseInt(request.getParameter("store_ID"));
	magician_ID = Integer.parseInt(request.getParameter("magician_ID"));
	String maregister = "update magician set store_ID = "+store_ID+" where magician_ID = "+magician_ID+";";
	String magic = "update magic set store_ID = "+store_ID+" where magician_ID = "+magician_ID+"";
	%>
	STORE ID:<%=store_ID %> 에  MAGICIAN ID:<%=magician_ID %>가 등록되었습니다.
	<%
	stmt.executeQuery(maregister);
	stmt.executeQuery(magic);//magic table의 store_ID foreign key 도 함께 일관성 있게 바꾸어 주어야한다.
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
	}%>
<input type="button" value="돌아가기" onclick="history.go(-1)">

<input type="submit" value="로그아웃" onclick="location.href='http://localhost:8080/1113/form.jsp'">
			
</h4>
</body>
</html>