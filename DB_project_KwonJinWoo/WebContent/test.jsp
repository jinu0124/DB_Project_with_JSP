<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>TO_random</title>
</head>
<body>
	<% //주사위를 굴린값을 random.jsp로 돌려주는 곳
		String sendRedirect = null;
		int MP = 0;
		int classs = 0;
		int classMP = Integer.parseInt(request.getParameter("test"));//0받으면 class, 1 -> MP

		if(classMP==0)//magician 에서 random 요청시 flag 0
		{
			double randomR = Math.random();
			classs = (int)(randomR*10)+1;
			double randomM = Math.random();
			MP = (int)(randomM*5000)+1;
		}
		
		if(classMP==1)//store에서 random 요청시 flag 1
		{
			double randomR = Math.random();
			classs = (int)(randomR*10)+1;
		}
		
		System.out.println(MP);
		if(classs != 0 || MP != 0)
		{
			session.setAttribute("MP", MP);//MP, class random gen 해서 둘다 0이 아니면 보냄 
			session.setAttribute("class", classs);
		}
		if(classs != 0 || MP == 0)
		{
			session.setAttribute("MP", MP);//MP는 0을 보내서 control함
			session.setAttribute("class", classs);//class random generate해서 보냄
		}
		response.sendRedirect("random.jsp");%>

</body>
</html>