<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	String user_name = (String) session.getAttribute("user_name");//�޾ƿö� Object�� �޾ƿ��� ������ String���� ����ȯ
	String url= request.getHeader("referer");//�α׾ƿ�(�Դ������� �ǵ��ư���)// ������ �Դ� URL�� �����ϰ�����
%>	
	<h1> ȯ���մϴ�. <%=user_name %>�� :)</h1>
	
	<input type="button" value="���ư���" onclick="location.href='<%=url %>'">
	
	<div>
	
	</div>
</body>
</html>