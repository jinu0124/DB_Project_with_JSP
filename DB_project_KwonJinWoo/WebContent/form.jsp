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
    pageEncoding="EUC-KR" session="false"%><!-- ���� false -->
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>FORM</title>
</head>
<%// ù ȭ��
response.setHeader("Pragma", "no-cache");//���ư��� ���� �����Ű��!!
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setDateHeader("Expires", 0L);//do not cache in proxy server
%>
<script type="text/javascript">
history.pushState(null, null, location.href);//�α׾ƿ� �� ���ư������� ���ϵ��� ����
window.onpopstate = function () {
    history.go(1);
};
</script>
<body onload="noBack();" onpageshow="if(event.persisted) noBack();" onunload="">
<h1> WELCOME TO RODUS WORLD</h1>
	<div>
		<h1> ȸ�������ϱ�</h1>
	</div>
	<form action = "result.jsp" method = "post">
		<div><% //�ڽ� %>
			<label><%//�̸� ���� �Է¹ޱ�%>
				�̸�(First name)
			</label>
			<input name="Fname" type="text"/><% //text������ �Է��� �޴´�. // text�� �ƴ� password �� �ϸ� �Է�â�� �Ⱥ��̰� �ȴ�%>
			<br>
			<label><%//�̸� ���� �Է¹ޱ�%>
				�̸�(Last name)
			</label>
		<input name="Lname" type="text"/>
		</div>
		<div>
			<label>���ϴ� ���� ����(������, ������, �Һ���)</label><br>
			<input type="radio" name="role" value="store" checked> ��������  </input><% //radio ��ư�� ������ �ϳ��� ���� ����%>
			<input type="radio" name="role" value="magician"> ������   </input>
			<input type="radio" name="role" value="consumer"> �Һ��� <br>   </input><% //name�� �Ķ���� �������� �Ѿ%>
		</div>
		<div><% //name=""�� �Ķ���ͷ� ���޵�%>
			<label>����(1~150)</label><br>
			<input name="age" type="number" min="1" max="150" value="20"/><%//value�� �⺻�� ,  required="" 
			//required�� ������ ""���̰��� �Է¹޾ƾ� �Ҷ� ���%>
		</div><%//max, min ���� ����%>
		
		<div>
			<label>DB�� ����Ͻðڽ��ϱ�?(��Ͻ� �ݵ�� üũ)</label><br>
			<input name="register" type="checkbox" value="on"/>
		</div>
		<button type="submit">�����ϱ�(Enter) </button><%//submit%><br>
	</form>
	<form action = "login.jsp" method = "post">
	<div>
		<h1> Login�ϱ�</h1>
	</div>
		<div><% //�ڽ� %>
			<label><%//�̸� ���� �Է¹ޱ�%>
				USER ID
			</label>
			<input name="ID" type="text"/><% //text������ �Է��� �޴´�. // text�� �ƴ� password �� �ϸ� �Է�â�� �Ⱥ��̰� �ȴ�%>
			<br>USER PW<input name="PW" type="password"/>
		</div><br>
		<button type="submit">�α���(Login) </button><br>
	</form>
		
	<%
		HttpSession session = request.getSession(false);
		if(session != null)
		{
			session.invalidate();//���� �����Ű��
		}
		%>
</body>
</html>