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
<%//random���� ���� ���� ���� �޾ƿ���, �ֻ��� ������ ��ư(a href)���� ������ �ٽ� �θ��� �ҷ��� page�� �ٽ� ���� �Ѱ���
			int value = 0;
			Integer mp = (Integer)session.getAttribute("MP");
			Integer classs = (Integer)session.getAttribute("class");
			if(mp != 0)
			{
				%><a href="test.jsp?test=<%=value %>">MP, CLASS�ֻ��� ������</a><%
			}
			else if(mp == 0)
			{
				value = 1;//test�� �ֻ��� ������ ������, �������� �̶�°��� flag ǥ��
				%><a href="test.jsp?test=<%=value %>">CLASS�ֻ��� ������</a><%
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
			session.setAttribute("MAMP", mp);//MAMP�� �Ǿ ���� �غ� ��<form action���� ������>
			session.setAttribute("class", classs);
			if(mp != 0)
			{%>
				<form action = "magician.jsp" method = "post">
				<button type="submit" name="MAMP" value=<%="MAMP"+mp+",CLASS:"+classs %>>����</button><br>
				</form>
			<%}
			else if(mp == 0)
			{
				%><form action = "store.jsp" method = "post">
				<button type="submit" name="classST" value=<%="CLASS:"+classs %>>����</button><br>
				</form>
			<%}
			%>
			
			
</body>
</html>