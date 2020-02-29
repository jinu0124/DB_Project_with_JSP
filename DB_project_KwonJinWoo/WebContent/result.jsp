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
	<%//form 창에서 넘어온 결과 -> 소비자, 마법사, 상점주인을 분류해서 각 페이지로 넘겨줌

	try{//get 방식은 url에 뜬다, post 방식은 값을 숨겨서 보낸다(url 에 도출 X).//회원가입 결과창 마지막 마무리 창
		String Fname = request.getParameter("Fname");//request는 이클립스에서 제공되는 함수
		String Lname = request.getParameter("Lname");//request는 이클립스에서 제공되는 함수
		String role = request.getParameter("role");//String "name" 파라미터를 받아옴
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
			if(role.equals(trigger_name1))//받은 문자열과 지정한 문자열이 일치하면
			{
				redirect = null;
				session.setAttribute("consumer", role);
				session.setAttribute("Fname", Fname);
				session.setAttribute("Lname", Lname);
				session.setAttribute("age", age);
				
				redirect = "consumer.jsp";//welcome.jsp으로 보내기
				if (redirect != null && role.equals("consumer"))
				{
					response.sendRedirect(redirect);
				}
			}
			
			else if(role.equals(trigger_name2))
			{
				redirect = null;
				session.setAttribute("magician", role);//name 값을 user_name에 넣기
				session.setAttribute("Fname", Fname);
				session.setAttribute("Lname", Lname);
				session.setAttribute("age", age);
				redirect = "magician.jsp";//welcome.jsp으로 보내기
				if (redirect != null && role.equals("magician"))
				{
					response.sendRedirect(redirect);
				}
			}
			else if(role.equals(trigger_name3))
			{
				session.setAttribute("store", role);//name 값을 user_name에 넣기
				session.setAttribute("Fname", Fname);
				session.setAttribute("Lname", Lname);
				session.setAttribute("age", age);
				redirect = "store.jsp";//welcome.jsp으로 보내기
				if (redirect != null && role.equals("store"))
				{
					response.sendRedirect(redirect);
				}
			}
			else
				System.out.println("예기지 못한 오류입니다.\n다시 시도해주세요.");%>
				<input type="button" value="돌아가기" onclick="location.href='<%=url %>'"><%
		}
		else{
			System.out.println("등록되지 않는 양식입니다.");%>
			등록되지 않는 양식입니다.<br>
		<input type="button" value="돌아가기" onclick="location.href='<%=url %>'">
		<%
		}
		%>
	<%
		/*
		String insert = request.getParameter("register");//DB에 정보 Register할것들 보내기(register.jsp)
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
		
	}catch(NumberFormatException e)//잘못된 값을 파라미터로 받았을때 exception e
	{%>
	<p> 올바르지 못한 정보입니다. 
	<%
	}
	%>
</form>

</body>
</html>