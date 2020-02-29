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
try{//ID 중복검사를 위함
		
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
		String STIDD = (String)request.getParameter("STID");
		
		//String compareID1 = "select user_CS_ID from consumer;";
		//String compareID2 = "select user_MA_ID from magician;";
		String compareID1 = "select user_CS_ID, user_MA_ID, user_ST_ID from consumer, magician, store;";

		rs = stmt.executeQuery(compareID1);
		while(rs.next())
		{
			String IDD = rs.getString("user_MA_ID");
			String IDF = rs.getString("user_ST_ID");
			String IDE = rs.getString("user_CS_ID");
			if(STIDD.equals(IDD) || STIDD.equals(IDF) || STIDD.equals(IDE))
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
<%//TCM
String address = (String)request.getParameter("address");//request는 이클립스에서 제공되는 함수
if(address.equals("ETC"))
{
	address = (String)request.getParameter("address1");
}
String tribe = (String)request.getParameter("tribe");//request는 이클립스에서 제공되는 함수
String STID = (String)request.getParameter("STID");//String "name" 파라미터를 받아옴//jsp 에서 받을때는 request.getParameter
String STPW = (String)request.getParameter("STPW");//request는 이클립스에서 제공되는 함수
int money = Integer.parseInt(request.getParameter("money"));//request는 이클립스에서 제공되는 함수
int classs = Integer.parseInt(request.getParameter("class"));//request는 이클립스에서 제공되는 함수
String store_name = (String)request.getParameter("store_name");//request는 이클립스에서 제공되는 함수

//get 방식은 url에 뜬다, post 방식은 값을 숨겨서 보낸다(url 에 도출 X).// 받아온 정보(form 창으로 부터)
		String url= request.getHeader("referer");
		String Name;

		String role = (String)session.getAttribute("store");//String "name" 파라미터를 받아옴
		String Fname = (String)session.getAttribute("Fname");//request는 이클립스에서 제공되는 함수
		String Lname = (String)session.getAttribute("Lname");//request는 이클립스에서 제공되는 함수
		
		//int age = (Integer)(session.getAttribute("age"));
		/*Fname.concat(Lname);
		Name = Fname;
		System.out.printf("당신의 이름 :", Name);*/
		Fname = Fname.toUpperCase();//Name을 대문자로 변환 완료
		Lname = Lname.toUpperCase();
		String boss = Fname + Lname;
		
		int MP = 0;
		session.setAttribute("role", role);//name 값을 user_name에 넣기(파라미터로 전달할 값)
		session.setAttribute("boss", boss);
		session.setAttribute("address", address);//name 값을 user_name에 넣기(파라미터로 전달할 값)
		session.setAttribute("tribe", tribe);
		session.setAttribute("STID", STID);
		session.setAttribute("STPW", STPW);//name 값을 user_name에 넣기(파라미터로 전달할 값)
		session.setAttribute("money", money);
		session.setAttribute("class", classs);
		session.setAttribute("store_name", store_name);
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