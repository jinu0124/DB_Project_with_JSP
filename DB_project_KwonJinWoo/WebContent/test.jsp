<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>TO_random</title>
</head>
<body>
	<% //�ֻ����� �������� random.jsp�� �����ִ� ��
		String sendRedirect = null;
		int MP = 0;
		int classs = 0;
		int classMP = Integer.parseInt(request.getParameter("test"));//0������ class, 1 -> MP

		if(classMP==0)//magician ���� random ��û�� flag 0
		{
			double randomR = Math.random();
			classs = (int)(randomR*10)+1;
			double randomM = Math.random();
			MP = (int)(randomM*5000)+1;
		}
		
		if(classMP==1)//store���� random ��û�� flag 1
		{
			double randomR = Math.random();
			classs = (int)(randomR*10)+1;
		}
		
		System.out.println(MP);
		if(classs != 0 || MP != 0)
		{
			session.setAttribute("MP", MP);//MP, class random gen �ؼ� �Ѵ� 0�� �ƴϸ� ���� 
			session.setAttribute("class", classs);
		}
		if(classs != 0 || MP == 0)
		{
			session.setAttribute("MP", MP);//MP�� 0�� ������ control��
			session.setAttribute("class", classs);//class random generate�ؼ� ����
		}
		response.sendRedirect("random.jsp");%>

</body>
</html>