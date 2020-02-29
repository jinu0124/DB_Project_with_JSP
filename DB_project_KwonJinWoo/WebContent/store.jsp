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
		
	<div><% //박스 %>
			허가CLASS :<%
			int classMP = 1; // 1을 보내면 class 선택이라는 신호를 test로 보냄 %>
		<a href="test.jsp?test=<%=classMP %>">CLASS 주사위 굴리기</a>
	<%
	if(request.getParameter("classs")!=null)
	{
		session.removeAttribute("class");
		response.sendRedirect("store.jsp");
	}
	Integer b = (Integer)(session.getAttribute("class"));//int형으로 받으면 혹시라도 NULL값을 받으면 에러남
	System.out.println("store : randomclass:"+b);
	%>
	<p>CLASS :<%=b %></p><br>
		<input type = "hidden" name = "class" value = <%=b %>>
		USER ID
		<input name="STID" type="text"/><% //text형식의 입력을 받는다. // text가 아닌 password 로 하면 입력창이 안보이게 된다%>
		<br>USER PW<input name="STPW" type="password"/><br>
	</div>
	
	<div>
			<label>마법상회 이름 정하기</label><br>
			<input type="text" name="store_name">

	</div>
	
	<div>
		<label>부족 선택</label><br>
		<input type="radio" name="tribe" value="MONSTER" checked> MONSTER <br>
		<input type="radio" name="tribe" value="KNIGHT"> KNIGHT <br>
		<input type="radio" name="tribe" value="IDIOT"> IDIOT <br>
		<input type="radio" name="tribe" value="ROYALTY"> ROYALTY <br>
		<input type="radio" name="tribe" value="ALIEN"> ALIEN <br>
	</div>
	
	
	
	<div><% //박스 %>
			보유 Money<br>
			<%int mmoney = 10000;
			/*
			double randomV = Math.random();
			int Money = (int)(randomV*20000)+1;*/
			%>
			<input type="radio" name="money" value=<%=mmoney %> checked> Money(10000) <br>
	</div>
	
	<div>
			<label>활동할 마을(주소) 선택</label><br>
			(자신의 주소 입력 가능)<br>
			<input type="radio" name="address" value="BOOMHILL"> BOOMHILL <br> 
			<input type="radio" name="address" value="CRAZYPARK" checked> CRAZYPARK <br><% //radio 버튼은 무조건 하나만 선택 가능%>
			<input type="radio" name="address" value="SHADOW"> SHADOW <br>
			<input type="radio" name="address" value="NORTHEU"> NORTHEU <br>  <% //name은 파라미터 형식으로 넘어감%>
			<input type="radio" name="address" value="PILTOVER"> PILTOVER <br><% //radio 버튼은 무조건 하나만 선택 가능%>
			<input type="radio" name="address" value="SINDORIM"> SINDORIM <br>
			<input type="radio" name="address" value="VEGAS"> VEGAS <br>
			<input type="radio" name="address" value="ETC"> ETC <br>
			<input name="address1" type="text"/><br><br>
	</div>
	<div>	
	<button type="submit">등록하기(Enter) </button>
	</div>
	<input type="button" value="돌아가기" onclick="location.href='<%=url %>'">
				</form>
</body>
</html>