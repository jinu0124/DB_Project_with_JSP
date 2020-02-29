<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
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
try{//get 방식은 url에 뜬다, post 방식은 값을 숨겨서 보낸다(url 에 도출 X).
		//소비자가 가입하는 화면에서 받은 정보를 이용하여 등록 하되 ID 중복 검사, 쿠폰번호 검사 등등을 진행함
		String driver = "org.mariadb.jdbc.Driver";//connection jar 파일
		
		Statement stmt = null;
		Connection conn = null;
		ResultSet rs = null;
		
		String jdbcDriver = "jdbc:mariadb://localhost:3306/rodus";
		String dbUser = "root";
		String dbPass = "1103";
		String redirect = null;
		try {
			Class.forName(driver);//등록
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//연결
			stmt=conn.createStatement();
		}
		catch(ClassNotFoundException e)
		{
			e.printStackTrace();
		}
		String CSIDD = (String)request.getParameter("CSID");
		
		String compareID1 = "select user_CS_ID, user_MA_ID, user_ST_ID from consumer, magician, store;";

		rs = stmt.executeQuery(compareID1);
		while(rs.next())
		{
			String IDD = rs.getString("user_MA_ID");
			String IDF = rs.getString("user_ST_ID");
			String IDE = rs.getString("user_CS_ID");
			if(CSIDD.equals(IDD) || CSIDD.equals(IDF) || CSIDD.equals(IDE))
			{
				redirect = "duplicateID.jsp";
				if (redirect != null)
				{
					response.sendRedirect(redirect);
				}
			}
		}
%>
<form action = "register.jsp" method = "post">
<%
String url= request.getHeader("referer");
	//get 방식은 url에 뜬다, post 방식은 값을 숨겨서 보낸다(url 에 도출 X).// 받아온 정보(form 창으로 부터)
		String address = (String)request.getParameter("address");//request는 이클립스에서 제공되는 함수
		if (address.equals("ETC"))
		{
			address = (String)request.getParameter("address1");
		}
		System.out.println("csreg_ETC address : "+address);
		String property = (String)request.getParameter("property");//request는 이클립스에서 제공되는 함수
		String CSID = (String)request.getParameter("CSID");//String "name" 파라미터를 받아옴//jsp 에서 받을때는 request.getParameter
		String CSPW = (String)request.getParameter("CSPW");//request는 이클립스에서 제공되는 함수
		int money = Integer.parseInt(request.getParameter("money"));//request는 이클립스에서 제공되는 함수
		
		//String url= request.getHeader("referer");
		String Name;
		String elder = "elder";//if문 비교를 위해서 사용
		Integer num = 123;//ELDER를 위한 쿠폰 번호
		Integer coupon = null;
		coupon = Integer.parseInt(request.getParameter("coupon"));//일단 쿠폰번호 받기
		String role = (String)session.getAttribute("consumer");//String "name" 파라미터를 받아옴
		String Fname = (String)session.getAttribute("Fname");//request는 이클립스에서 제공되는 함수
		String Lname = (String)session.getAttribute("Lname");//request는 이클립스에서 제공되는 함수
		int age = (Integer)(session.getAttribute("age"));
		//System.out.println("coupon(in csreg) : "+coupon);
		//System.out.println("property (in cs): "+property);
		int count = 1;
		if(property.equals(elder) && coupon != num)//객체형으로 받아서 NULL값이 와도 에러X,쿠폰번호가 불일치하면 이전페이지로 돌려보냄 
		{//선택한 property가 elder인데 쿠폰번호가 만족되지 않으면 다시 이전화면으로 돌려보냄.
			//System.out.println("coupon(in csreg) : "+coupon);
			//System.out.println("property (in cs): "+property);
			session.setAttribute("couponerr", coupon);
			session.setAttribute("count", count);
			redirect = "consumer.jsp";
			if(redirect != null)
			{
				response.sendRedirect(redirect);
				
			}
			redirect = null;
		}
		/*Fname.concat(Lname);
		Name = Fname;
		System.out.printf("당신의 이름 :", Name);*/
		Fname = Fname.toUpperCase();//Name을 대문자로 변환 완료
		Lname = Lname.toUpperCase();
		//String redirect = null;
		
		System.out.println("CSregister");
		System.out.println(role);
		System.out.println(Fname);
		System.out.println(Lname);
		System.out.println(address);
		System.out.println(property);
		System.out.println(CSID);
		System.out.println(CSPW);
		System.out.println(money);
		System.out.println(age);
		
		int MP = 0;
		int classs = 0;//NULL pointer 방지
		
		session.setAttribute("role", role);//name 값을 user_name에 넣기(파라미터로 전달할 값)
		session.setAttribute("Fname", Fname);
		session.setAttribute("Lname", Lname);
		session.setAttribute("address", address);//name 값을 user_name에 넣기(파라미터로 전달할 값)
		session.setAttribute("property", property);
		session.setAttribute("CSID", CSID);
		session.setAttribute("CSPW", CSPW);//name 값을 user_name에 넣기(파라미터로 전달할 값)
		session.setAttribute("money", money);
		session.setAttribute("age", age);
		session.setAttribute("MP", MP);
		session.setAttribute("class", classs);

		redirect = "register.jsp";

		if(redirect != null)
		{
			response.sendRedirect(redirect);
		}
	}catch(Exception e)
	{
			e.printStackTrace();
	}finally{
		try{
		}catch (Exception e2){
		}
	}
	%>

		</form>
</body>
</html>