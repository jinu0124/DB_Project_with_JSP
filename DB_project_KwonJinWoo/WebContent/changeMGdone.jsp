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
<title>changeMGdone</title>
</head>
<body><% // 최종 수정할 정보를 받아와서 쿼리로 수정을 해주는 곳
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
		//rs = stmt.executeQuery();
		int magic_ID = 0;
		int classs = 0;
		String magic_name = null;
		String magic_exp = null;
		String originMA_name = null;
		int sale_price = 0;
		String kind = null;
		int effect = 0;
		int MP_consume = 0;
		
		magic_ID = (Integer)session.getAttribute("magic_ID");
		classs = Integer.parseInt(request.getParameter("class"));
		originMA_name = (String)session.getAttribute("originMA_name");
		magic_name = (String)request.getParameter("magic_name");
		magic_exp = (String)request.getParameter("magic_exp");
		sale_price = Integer.parseInt(request.getParameter("sale_price"));
		kind = (String)request.getParameter("kind");
		effect = Integer.parseInt(request.getParameter("effect"));
		MP_consume = Integer.parseInt(request.getParameter("MP_consume"));
		
		magic_name = magic_name.toUpperCase();
		magic_exp = magic_exp.toUpperCase();
		kind = kind.toUpperCase();
		
		System.out.println("magic_name and magic_exp(수정될 받은 값) :"+magic_name+magic_exp+magic_ID+classs+MP_consume+kind+effect);
		String magicupdateQ2 = "update magic_detail set magic_name='"+magic_name+"' , magic_exp='"+magic_exp+"', kind='"+kind+"', effect="+effect+", MP_consume="+MP_consume+" where magic_name = '"+originMA_name+"';";
		String magicupdateQ = "update magic set class="+classs+", sale_price="+sale_price+" where magic_ID = "+magic_ID+";";
		
		stmt.executeUpdate(magicupdateQ);
		stmt.executeUpdate(magicupdateQ2);
		
		if(magic_ID != 0)
		{
		%>
		성공적으로 마법이 수정되었습니다.
		마법 내용 <br>/CLASS :<%=classs %><br>/SALE PRICE :<%=sale_price %><br>/MAGIC_NAME :<%=magic_name %><br>/MAGIC Expression :<%=magic_exp %><br>/KIND :<%=kind %><br>/EFFECT :<%=effect %><br>/MP_consume<%=MP_consume %>
		<input type="button" value="돌아가기" onclick="history.go(-1)">
		<input type="submit" value="로그아웃" onclick="location.href='http://localhost:8080/1113/form.jsp'">
<%}
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
	</body>
	</html>