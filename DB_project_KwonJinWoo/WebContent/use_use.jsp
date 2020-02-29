<%@page import="java.sql.SQLException"%>
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
<title>Insert title here</title>
</head>
<body>
	<h1>마법 등록 성공 창</h1>
	<%String url= request.getHeader("referer"); %>
	<%   	// use use 테이블에 필요 재료 정보를 등록해줌
try{//get 방식은 url에 뜬다, post 방식은 값을 숨겨서 보낸다(url 에 도출 X).
		String driver = "org.mariadb.jdbc.Driver";//connection jar 파일
		Statement stmt = null;
		Connection conn = null;
		ResultSet rs = null;//SQL 출력 받아올때 사용
		String redirect = null;
		
		int material_cnt1 = 0;
		int material_cnt2 = 0;
		int material_cnt3 = 0;
		String jdbcDriver = "jdbc:mariadb://localhost:3306/rodus";
		String dbUser = "root";
		String dbPass = "1103";
			Class.forName(driver);//등록
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//연결
			stmt=conn.createStatement();
		
		int newmagic_ID1 = (Integer)session.getAttribute("newmagic_ID1");
		int material_ID1 = (Integer)session.getAttribute("material_ID1");
		int material_ID2 = (Integer)session.getAttribute("material_ID2");
		int material_ID3 = (Integer)session.getAttribute("material_ID3");
		material_cnt1 = (Integer)session.getAttribute("material_cnt1");
		material_cnt2 = (Integer)session.getAttribute("material_cnt2");
		material_cnt3 = (Integer)session.getAttribute("material_cnt3");
		String use_reg1 = (String)session.getAttribute("use_reg1");
		String use_reg2 = (String)session.getAttribute("use_reg2");
		String use_reg3 = (String)session.getAttribute("use_reg3");
		String magic_name = (String)session.getAttribute("magic_name");

		use_reg1 = "insert into use_use(magic_ID, material_ID, material_cnt) values("+newmagic_ID1+", "+material_ID1+", "+material_cnt1+")";
		use_reg2 = "insert into use_use(magic_ID, material_ID, material_cnt) values("+newmagic_ID1+", "+material_ID2+", "+material_cnt2+")";
		use_reg3 = "insert into use_use(magic_ID, material_ID, material_cnt) values("+newmagic_ID1+", "+material_ID3+", "+material_cnt3+")";
		
		if(material_cnt1 != 0)
		{
			stmt.executeQuery(use_reg1);
		}
		if(material_cnt2 != 0)
		{
			stmt.executeQuery(use_reg2);
		}
		if(material_cnt3 != 0)
		{
			stmt.executeQuery(use_reg3);
		}
		int count = 0;
		session.setAttribute("count", count);
		%>
		마법이 성공적으로 등록되었습니다!<br>
		등록된 마법 이름:<%=magic_name %><br>
		<input type="button" value="돌아가기" onclick="location.href='http://localhost:8080/1113/logonMA.jsp'"><br>
		<%
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