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
<title>MAregister</title>
</head>
<body>

<%
try{//get 방식은 url에 뜬다, post 방식은 값을 숨겨서 보낸다(url 에 도출 X).
		//회원가입 시 마법사로 회원가입 하면 정보를 받아와서 제약조건 검사 후 넘겨주기
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
		String MAIDD = (String)request.getParameter("MAID");
		
		
		
		String compareID1 = "select user_CS_ID, user_MA_ID, user_ST_ID from consumer, magician, store;";

		rs = stmt.executeQuery(compareID1);
		while(rs.next())
		{
			String IDD = rs.getString("user_MA_ID");
			String IDF = rs.getString("user_ST_ID");
			String IDE = rs.getString("user_CS_ID");
			if(MAIDD.equals(IDD) || MAIDD.equals(IDF) || MAIDD.equals(IDE))
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
String address = (String)request.getParameter("address");//request는 이클립스에서 제공되는 함수
if (address.equals("ETC"))//ETC 기타 입력을 받았을때 text 값을 받아오기 위한 if문
{
	address = (String)request.getParameter("address1");
}
String job = (String)request.getParameter("job");
if (job.equals("ETC"))//ETC 기타 입력을 받았을때 text 값을 받아오기 위한 if문
{
	job = (String)request.getParameter("job1");
}
String property = (String)request.getParameter("property");//request는 이클립스에서 제공되는 함수
String MAID = (String)request.getParameter("MAID");//String "name" 파라미터를 받아옴//jsp 에서 받을때는 request.getParameter
String MAPW = (String)request.getParameter("MAPW");//request는 이클립스에서 제공되는 함수
String tribe = (String)request.getParameter("tribe");
int classs = Integer.parseInt(request.getParameter("class"));
int MP = Integer.parseInt(request.getParameter("MP"));
int money = Integer.parseInt(request.getParameter("money"));//request는 이클립스에서 제공되는 함수

String elder = "elder";//if문 비교를 위해서 사용
Integer num = 123;//ELDER를 위한 쿠폰 번호
Integer coupon = null;
coupon = Integer.parseInt(request.getParameter("coupon"));
int count = 1;
if(property.equals(elder) && coupon != num)//객체형으로 받아서 NULL값이 와도 에러X,쿠폰번호가 불일치하면 이전페이지로 돌려보냄 
{//선택한 property가 elder인데 쿠폰번호가 만족되지 않으면 다시 이전화면으로 돌려보냄.
	
	session.setAttribute("couponerr", coupon);
	session.setAttribute("count", count);
	redirect = "magician.jsp";
	if(redirect != null)
	{
		response.sendRedirect(redirect);
		
	}
	redirect = null;
}// <- 쿠폰번호 다를 시 돌려 보내기 이전페이지로 count 값을 1로 주고 coupon err로
//get 방식은 url에 뜬다, post 방식은 값을 숨겨서 보낸다(url 에 도출 X).// 받아온 정보(form 창으로 부터)
		String url= request.getHeader("referer");
		String Name;

		String role = (String)session.getAttribute("magician");//String "name" 파라미터를 받아옴
		String Fname = (String)session.getAttribute("Fname");//request는 이클립스에서 제공되는 함수
		String Lname = (String)session.getAttribute("Lname");//request는 이클립스에서 제공되는 함수
		int age = (Integer)(session.getAttribute("age"));
		/*Fname.concat(Lname);
		Name = Fname;
		System.out.printf("당신의 이름 :", Name);*/
		Fname = Fname.toUpperCase();//Name을 대문자로 변환 완료
		Lname = Lname.toUpperCase();
		
		System.out.println("MAregister");
		System.out.println(role);
		System.out.println(Fname);
		System.out.println(Lname);
		System.out.println(address);
		System.out.println(property);
		System.out.println(MAID);
		System.out.println(MAPW);
		System.out.println(tribe);
		System.out.println(job);
		System.out.println(classs);
		System.out.println(MP);
		System.out.println(age);
		System.out.println(money);
		
		session.setAttribute("role", role);//name 값을 user_name에 넣기(파라미터로 전달할 값)
		session.setAttribute("Fname", Fname);
		session.setAttribute("Lname", Lname);
		session.setAttribute("address", address);//name 값을 user_name에 넣기(파라미터로 전달할 값)
		session.setAttribute("property", property);
		session.setAttribute("MAID", MAID);
		session.setAttribute("MAPW", MAPW);//name 값을 user_name에 넣기(파라미터로 전달할 값)
		session.setAttribute("money", money);
		session.setAttribute("age", age);
		session.setAttribute("tribe", tribe);
		session.setAttribute("job", job);//name 값을 user_name에 넣기(파라미터로 전달할 값)
		session.setAttribute("class", classs);
		session.setAttribute("MP", MP);
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