<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.Scanner"%>
<%@page import="java.util.Random"%>
<%@page import="javafx.scene.control.Alert"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>magician</title>
</head>
<body>
<%	String url= request.getHeader("referer"); %>
		<form action = "maregister.jsp" method = "post">
		<div><% //박스 %>
	<%
	//session.setMaxInactiveInterval(600);//600초간 세션 유지
	int classMP = 0; // 1을 보내면 class 선택이라는 신호를 test로 보냄 %>
	<a href="test.jsp?test=<%=classMP %>">CLASS,MP 주사위 굴리기</a>
	<%
	if(request.getParameter("classs")!=null)
	{
		session.removeAttribute("class");
		response.sendRedirect("magician.jsp");
	}
	Integer b = (Integer)(session.getAttribute("class"));//int형으로 받으면 혹시라도 NULL값을 받으면 에러남
	Integer c = (Integer)(session.getAttribute("MAMP"));
	//System.out.println(b+c);//확인용 , Integer는 객체형으로 숫자에 Null값이 들어갈 수 있게됨
	%>
	<br>
	<input type="radio" name="class" value=<%=b %> checked> class:<%=b %> </input><br>
	<input type="radio" name="MP" value=<%=c %> checked> MP:<%=c %> </input><br>
	</div>
	<div><% //박스 %>
			USER ID
			<input name="MAID" type="text"/><% //text형식의 입력을 받는다. // text가 아닌 password 로 하면 입력창이 안보이게 된다%>
			<br>USER PW<input name="MAPW" type="password"/><br>
	</div>
	<div>
		<label>부족 선택</label><br>
		<input type="radio" name="tribe" value="MONSTER" checked> MONSTER <br>
		<input type="radio" name="tribe" value="KNIGHT"> KNIGHT <br>
		<input type="radio" name="tribe" value="IDIOT"> IDIOT <br>
		<input type="radio" name="tribe" value="ROYALTY"> ROYALTY <br>
		<input type="radio" name="tribe" value="ALIEN"> ALIEN <br>
	</div>
	<div>
			<label>속성 선택</label><br>
			<input type="radio" name="property" value="elder"> ELDER 
			<input type="number" name="coupon" value="0"> <- (ELDER전용)쿠폰 번호를 입력하시오<br>
			<input type="radio" name="property" value="electron" checked> ELECTRON <br><% //radio 버튼은 무조건 하나만 선택 가능%>
			<input type="radio" name="property" value="fire"> FIRE <br>
			<input type="radio" name="property" value="nightmare"> NIGHTMARE <br>  <% //name은 파라미터 형식으로 넘어감%>
			<input type="radio" name="property" value="sand"> SAND <br><% //radio 버튼은 무조건 하나만 선택 가능%>
			<input type="radio" name="property" value="sun"> SUN <br>
			<input type="radio" name="property" value="water"> WATER <br>
			<input type="radio" name="property" value="wind"> WIND <br><% //radio 버튼은 무조건 하나만 선택 가능%>
	</div>
	<div>
			<label>출신지 선택</label><br>
			(자신의 주소 입력 가능)<br>
			<input type="radio" name="address" value="BOOMHILL"> BOOMHILL <br>
			<input type="radio" name="address" value="CRAZYPARK" checked> CRAZYPARK <br><% //radio 버튼은 무조건 하나만 선택 가능%>
			<input type="radio" name="address" value="SHADOW"> SHADOW <br>
			<input type="radio" name="address" value="NORTHEU"> NORTHEU <br>  <% //name은 파라미터 형식으로 넘어감%>
			<input type="radio" name="address" value="PILTOVER"> PILTOVER <br><% //radio 버튼은 무조건 하나만 선택 가능%>
			<input type="radio" name="address" value="SINDORIM"> SINDORIM <br>
			<input type="radio" name="address" value="VEGAS"> VEGAS <br>
			<input type="radio" name="address" value="ETC"> ETC <br>
			<input name="address1" type="text"/> <- 이외의 마을 추가 가능<br><br>
	</div>
	<div>
			<label>직업 선택</label><br>
			(자신의 주소 입력 가능)<br>
			<input type="radio" name="job" value="LANDLOLD"> LANDLOLD <br>
			<input type="radio" name="job" value="EMPLOYER" checked> EMPLOYER <br><% //radio 버튼은 무조건 하나만 선택 가능%>
			<input type="radio" name="job" value="EMPLOYEE"> EMPLOYEE <br>
			<input type="radio" name="job" value="CLOWN"> CLOWN <br>  <% //name은 파라미터 형식으로 넘어감%>
			<input type="radio" name="job" value="POET"> POET <br><% //radio 버튼은 무조건 하나만 선택 가능%>
			<input type="radio" name="job" value="FIREFIGHTER"> FIREFIGHTER <br>
			<input type="radio" name="job" value="POLICE"> POLICE <br>
			<input type="radio" name="job" value="ETC"> ETC <br>
			<input name="job1" type="text"/> <- 이외의 직업 추가 가능<br>
	</div>
		
	<div><% //박스 %>
			보유 Money<br>
			<%/*
			double randomV = Math.random();
			int Money = (int)(randomV*20000)+1;*/
			%>
			<input type="radio" name="money" value=1000 checked> Money(1000) <br>
	</div>
	
	<%
	//PrintWriter outWriter = response.getWriter();
	Integer couponerr = null;
	couponerr = (Integer)session.getAttribute("couponerr");
	int count=0;
	
	if(couponerr != null)//쿠폰 번호를 보내었는데 다시 되돌아 왔을 때 -> 잘못된 번호여서 다시 돌아옴
	{
		count = (Integer)session.getAttribute("count");//쿠폰 번호가 null이 아닐때 실행하여서 오류 제거, if문으로 감싸지 않으면 처음 이 창 진입 시 null Pointer에러 발생 하기 때문
		System.out.println("couperr :"+couponerr);
		if(count==1){//alert //count가 1일때만 뜨도록 -> 첫 진입시 뜨는것을 막음
			JOptionPane.showMessageDialog(null,"ELDER쿠폰번호가 잘못되었습니다.");//첫화면부터 뜨는거 고침 쿠폰번호 잘못입력 시
		}
	}
	%>
	
	<div>	
	<button type="submit">등록하기(Enter) </button>
	</div>
	<input type="button" value="돌아가기" onclick="location.href='http://localhost:8080/1113/form.jsp'">
				</form>
</body>
</html>