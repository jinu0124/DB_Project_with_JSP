<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Consumer</title>
</head>
<body>
<%	String url= request.getHeader("referer"); %>
		<form action = "stregister.jsp" method = "post">
		
	<div><% //�ڽ� %>
			�㰡CLASS :<%
			int classMP = 1; // 1�� ������ class �����̶�� ��ȣ�� test�� ���� %>
		<a href="test.jsp?test=<%=classMP %>">CLASS �ֻ��� ������</a>
	<%
	if(request.getParameter("classs")!=null)
	{
		session.removeAttribute("class");
		response.sendRedirect("store.jsp");
	}
	Integer b = (Integer)(session.getAttribute("class"));//int������ ������ Ȥ�ö� NULL���� ������ ������
	System.out.println("store : randomclass:"+b);
	%>
	<p>CLASS :<%=b %></p><br>
		<input type = "hidden" name = "class" value = <%=b %>>
		USER ID
		<input name="STID" type="text"/><% //text������ �Է��� �޴´�. // text�� �ƴ� password �� �ϸ� �Է�â�� �Ⱥ��̰� �ȴ�%>
		<br>USER PW<input name="STPW" type="password"/><br>
	</div>
	
	<div>
			<label>������ȸ �̸� ���ϱ�</label><br>
			<input type="text" name="store_name">

	</div>
	
	<div>
		<label>���� ����</label><br>
		<input type="radio" name="tribe" value="MONSTER" checked> MONSTER <br>
		<input type="radio" name="tribe" value="KNIGHT"> KNIGHT <br>
		<input type="radio" name="tribe" value="IDIOT"> IDIOT <br>
		<input type="radio" name="tribe" value="ROYALTY"> ROYALTY <br>
		<input type="radio" name="tribe" value="ALIEN"> ALIEN <br>
	</div>
	
	
	
	<div><% //�ڽ� %>
			���� Money<br>
			<%int mmoney = 10000;
			/*
			double randomV = Math.random();
			int Money = (int)(randomV*20000)+1;*/
			%>
			<input type="radio" name="money" value=<%=mmoney %> checked> Money(10000) <br>
	</div>
	
	<div>
			<label>Ȱ���� ����(�ּ�) ����</label><br>
			(�ڽ��� �ּ� �Է� ����)<br>
			<input type="radio" name="address" value="BOOMHILL"> BOOMHILL <br> 
			<input type="radio" name="address" value="CRAZYPARK" checked> CRAZYPARK <br><% //radio ��ư�� ������ �ϳ��� ���� ����%>
			<input type="radio" name="address" value="SHADOW"> SHADOW <br>
			<input type="radio" name="address" value="NORTHEU"> NORTHEU <br>  <% //name�� �Ķ���� �������� �Ѿ%>
			<input type="radio" name="address" value="PILTOVER"> PILTOVER <br><% //radio ��ư�� ������ �ϳ��� ���� ����%>
			<input type="radio" name="address" value="SINDORIM"> SINDORIM <br>
			<input type="radio" name="address" value="VEGAS"> VEGAS <br>
			<input type="radio" name="address" value="ETC"> ETC <br>
			<input name="address1" type="text"/><br><br>
	</div>
	<div>	
	<button type="submit">����ϱ�(Enter) </button>
	</div>
	<input type="button" value="���ư���" onclick="location.href='<%=url %>'">
				</form>
</body>
</html>