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
<title>random</title>
</head>
<body>
<%//random으로 부터 랜덤 값을 받아오고, 주사위 굴리기 버튼(a href)으로 랜덤값 다시 부르기 불러온 page로 다시 값을 넘겨줌
			int value = 0;
			Integer mp = (Integer)session.getAttribute("MP");
			Integer classs = (Integer)session.getAttribute("class");
			if(mp != 0)
			{
				%><a href="test.jsp?test=<%=value %>">MP, CLASS주사위 돌리기</a><%
			}
			else if(mp == 0)
			{
				value = 1;//test로 주사위 던지기 보낼때, 상점주인 이라는것을 flag 표시
				%><a href="test.jsp?test=<%=value %>">CLASS주사위 돌리기</a><%
			}
			
			
			if(classs != 0)
			{
				%>
					<p>CLASS :<%=classs %></p>
				<%
			}
			if(mp != 0)
			{
				%>
				<p>MP :<%=mp %></p>
				<%
			}
			System.out.println("random"+mp);
			session.setAttribute("MAMP", mp);//MAMP로 실어서 보낼 준비 및<form action으로 보내기>
			session.setAttribute("class", classs);
			if(mp != 0)
			{%>
				<form action = "magician.jsp" method = "post">
				<button type="submit" name="MAMP" value=<%="MAMP"+mp+",CLASS:"+classs %>>결정</button><br>
				</form>
			<%}
			else if(mp == 0)
			{
				%><form action = "store.jsp" method = "post">
				<button type="submit" name="classST" value=<%="CLASS:"+classs %>>결정</button><br>
				</form>
			<%}
			%>
			
			
</body>
</html>