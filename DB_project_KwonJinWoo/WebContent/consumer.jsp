<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.Scanner"%>
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
<%	String url= request.getHeader("referer");//회원가입시 소비자 가입 화면 %>
		<form action = "csregister.jsp" method = "post">
	<div><% //박스 %>
			USER ID
			<input name="CSID" type="text"/><% //text형식의 입력을 받는다. // text가 아닌 password 로 하면 입력창이 안보이게 된다%>
			<br>USER PW<input name="CSPW" type="password"/><br>
	</div>
	
	<div>
			<label>원하는 속성 선택</label><br>
			<input type="radio" name="property" value="elder"> ELDER
			<%/*Scanner scan = new Scanner(System.in); 
			String message;
			message = scan.nextLine();*/
			%>
			<input type="number" name="coupon" value="0"> <- (ELDER전용)쿠폰 번호를 입력하시오<br>
			<input type="radio" name="property" value="electron" checked> ELECTRON <br><% //radio 버튼은 무조건 하나만 선택 가능%>
			<input type="radio" name="property" value="fire"> FIRE <br>
			<input type="radio" name="property" value="nightmare"> NIGHTMARE <br>  <% //name은 파라미터 형식으로 넘어감%>
			<input type="radio" name="property" value="sand"> SAND <br><% //radio 버튼은 무조건 하나만 선택 가능%>
			<input type="radio" name="property" value="sun"> SUN <br>
			<input type="radio" name="property" value="water"> WATER <br>
			<input type="radio" name="property" value="wind"> WIND <br><% //radio 버튼은 무조건 하나만 선택 가능%>
	</div>
	<div><% //박스 %>
			보유 Money<br>
			<%/*
			double randomV = Math.random();
			int Money = (int)(randomV*20000)+1;*/
			%>
			<input type="radio" name="money" value=1000 checked> Money(1000) <br>
	</div>
	
	<div>
			<label>활동할 마을(주소) 선택</label><br>
			(자신의 주소 입력 가능)<br>
			<input type="radio" name="address" value="BOOMHILL" checked> BOOMHILL <br>
			<input type="radio" name="address" value="CRAZYPARK"> CRAZYPARK <br><% //radio 버튼은 무조건 하나만 선택 가능%>
			<input type="radio" name="address" value="SHADOW"> SHADOW <br>
			<input type="radio" name="address" value="NORTHEU"> NORTHEU <br>  <% //name은 파라미터 형식으로 넘어감%>
			<input type="radio" name="address" value="PILTOVER"> PILTOVER <br><% //radio 버튼은 무조건 하나만 선택 가능%>
			<input type="radio" name="address" value="SINDORIM"> SINDORIM <br>
			<input type="radio" name="address" value="VEGAS"> VEGAS <br>
			<input type="radio" name="address" value="ETC"> ETC <br>
			<input name="address1" type="text"/><br><br>
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