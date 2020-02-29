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
    pageEncoding="EUC-KR" session="false"%><!-- 세션 false -->
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>FORM</title>
</head>
<%// 첫 화면
response.setHeader("Pragma", "no-cache");//돌아갈때 세션 만료시키기!!
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setDateHeader("Expires", 0L);//do not cache in proxy server
%>
<script type="text/javascript">
history.pushState(null, null, location.href);//로그아웃 후 돌아가기하지 못하도록 막기
window.onpopstate = function () {
    history.go(1);
};
</script>
<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
<h1> WELCOME TO RODUS WORLD</h1>
	<div>
		<h1> 회원가입하기</h1>
	</div>
	<form action = "result.jsp" method = "post">
		<div><% //박스 %>
			<label><%//이름 성별 입력받기%>
				이름(First name)
			</label>
			<input name="Fname" type="text"/><% //text형식의 입력을 받는다. // text가 아닌 password 로 하면 입력창이 안보이게 된다%>
			<br>
			<label><%//이름 성별 입력받기%>
				이름(Last name)
			</label>
		<input name="Lname" type="text"/>
		</div>
		<div>
			<label>원하는 역할 선택(상점주, 마법사, 소비자)</label><br>
			<input type="radio" name="role" value="store" checked> 상점주인  </input><% //radio 버튼은 무조건 하나만 선택 가능%>
			<input type="radio" name="role" value="magician"> 마법사   </input>
			<input type="radio" name="role" value="consumer"> 소비자 <br>   </input><% //name은 파라미터 형식으로 넘어감%>
		</div>
		<div><% //name=""은 파라미터로 전달됨%>
			<label>나이(1~150)</label><br>
			<input name="age" type="number" min="1" max="150" value="20"/><%//value는 기본값 ,  required="" 
			//required는 무조건 ""사이값을 입력받아야 할때 사용%>
		</div><%//max, min 값을 설정%>
		
		<div>
			<label>DB에 등록하시겠습니까?(등록시 반드시 체크)</label><br>
			<input name="register" type="checkbox" value="on"/>
		</div>
		<button type="submit">전송하기(Enter) </button><%//submit%><br>
	</form>
	<form action = "login.jsp" method = "post">
	<div>
		<h1> Login하기</h1>
	</div>
		<div><% //박스 %>
			<label><%//이름 성별 입력받기%>
				USER ID
			</label>
			<input name="ID" type="text"/><% //text형식의 입력을 받는다. // text가 아닌 password 로 하면 입력창이 안보이게 된다%>
			<br>USER PW<input name="PW" type="password"/>
		</div><br>
		<button type="submit">로그인(Login) </button><br>
	</form>
		
	<%
		HttpSession session = request.getSession(false);
		if(session != null)
		{
			session.invalidate();//세션 만료시키기
		}
		%>
</body>
</html>