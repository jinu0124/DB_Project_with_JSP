<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%	String url= request.getHeader("referer"); //ID ȸ�����Խ�, ID�� �ߺ��ɶ� ���� â (������ ����, �Һ��� ����, ��ȸ���� ���� ���� ��)%>
	<p>�ߺ��� ID�� �����մϴ�.</p>
	<input type="button" value="���ư���" onclick="location.href='<%=url %>'">
</body>
</html>