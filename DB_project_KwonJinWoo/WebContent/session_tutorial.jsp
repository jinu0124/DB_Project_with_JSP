<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%//������ �ǽ��ð�
	if(request.getParameter("name")!=null)
	{
		session.removeAttribute("zzz");
		response.sendRedirect("session_tutorial.jsp");
		
	}
session.setAttribute("test",001);
String name = "home";
%>
<a href="form.jsp" target="_blank">visit</a>
<a href="test.jsp?name=<%=name %>">Ŭ��</a>
<%String zz = (String)session.getAttribute("zzz");
if(zz!=null)
{
	%>
	<p> <%=zz %></p>
	<%
}
	%>
<a href ="session_tutorial.jsp?name=<%="erase"%>">�����</a>
</body>
</html>