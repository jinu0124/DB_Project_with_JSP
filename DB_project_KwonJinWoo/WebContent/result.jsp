<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>result</title>
</head>
<body>
<form action = "consumer.jsp" method = "post">
	<%//form â���� �Ѿ�� ��� -> �Һ���, ������, ���������� �з��ؼ� �� �������� �Ѱ���

	try{//get ����� url�� ���, post ����� ���� ���ܼ� ������(url �� ���� X).//ȸ������ ���â ������ ������ â
		String Fname = request.getParameter("Fname");//request�� ��Ŭ�������� �����Ǵ� �Լ�
		String Lname = request.getParameter("Lname");//request�� ��Ŭ�������� �����Ǵ� �Լ�
		String role = request.getParameter("role");//String "name" �Ķ���͸� �޾ƿ�
		String insert = request.getParameter("register");
		int age = Integer.parseInt(request.getParameter("age"));
		//System.out.println(role);
		String url= request.getHeader("referer");
		
		String redirect = null;
		String trigger_name1 = "consumer";
		String trigger_name2 = "magician";
		String trigger_name3 = "store";
		
		System.out.println("result");
		System.out.println(role);
		System.out.println(age);
		System.out.println(Fname);
		System.out.println(Lname);
		//ages = age;

		if(insert != null && insert.equals("on"))
		{
			if(role.equals(trigger_name1))//���� ���ڿ��� ������ ���ڿ��� ��ġ�ϸ�
			{
				redirect = null;
				session.setAttribute("consumer", role);
				session.setAttribute("Fname", Fname);
				session.setAttribute("Lname", Lname);
				session.setAttribute("age", age);
				
				redirect = "consumer.jsp";//welcome.jsp���� ������
				if (redirect != null && role.equals("consumer"))
				{
					response.sendRedirect(redirect);
				}
			}
			
			else if(role.equals(trigger_name2))
			{
				redirect = null;
				session.setAttribute("magician", role);//name ���� user_name�� �ֱ�
				session.setAttribute("Fname", Fname);
				session.setAttribute("Lname", Lname);
				session.setAttribute("age", age);
				redirect = "magician.jsp";//welcome.jsp���� ������
				if (redirect != null && role.equals("magician"))
				{
					response.sendRedirect(redirect);
				}
			}
			else if(role.equals(trigger_name3))
			{
				session.setAttribute("store", role);//name ���� user_name�� �ֱ�
				session.setAttribute("Fname", Fname);
				session.setAttribute("Lname", Lname);
				session.setAttribute("age", age);
				redirect = "store.jsp";//welcome.jsp���� ������
				if (redirect != null && role.equals("store"))
				{
					response.sendRedirect(redirect);
				}
			}
			else
				System.out.println("������ ���� �����Դϴ�.\n�ٽ� �õ����ּ���.");%>
				<input type="button" value="���ư���" onclick="location.href='<%=url %>'"><%
		}
		else{
			System.out.println("��ϵ��� �ʴ� ����Դϴ�.");%>
			��ϵ��� �ʴ� ����Դϴ�.<br>
		<input type="button" value="���ư���" onclick="location.href='<%=url %>'">
		<%
		}
		%>
	<%
		/*
		String insert = request.getParameter("register");//DB�� ���� Register�Ұ͵� ������(register.jsp)
		if (insert != null)
		{
			insert = "on";
		}
		
		if(insert != null && insert.equals("on"))
		{
			session.setAttribute("age", age);
			session.setAttribute("name", name);
			session.setAttribute("gender", gender);
			redirect = "register.jsp";
		}*/
		%>
		<%
		
	}catch(NumberFormatException e)//�߸��� ���� �Ķ���ͷ� �޾����� exception e
	{%>
	<p> �ùٸ��� ���� �����Դϴ�. 
	<%
	}
	%>
</form>

</body>
</html>