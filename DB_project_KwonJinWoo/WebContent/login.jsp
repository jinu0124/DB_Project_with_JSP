<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Login</title>
</head>
<body>
	<h1>로그인 창</h1>
	<%	String url= request.getHeader("referer"); %> 
	<%//로그인 시 정보를 받아서 ID 일치정보 혹은 ID 존재여부 확인 후 값을 돌려주거나 다음 각 각 역할군에 맞는 로그인 창으로 넘겨주기
	try{//get 방식은 url에 뜬다, post 방식은 값을 숨겨서 보낸다(url 에 도출 X).// 로그인 창SQL문을 통해서 마법사, 소비자, 상점주인 ID를 받아와서 존재여부 비교후, 비밀번호와 일치하면
		// 로그인 창으로 넘어감 -> 비밀번호 틀리면 비밀번호 오류창으로, ID가 존재하지 않으면 땡
		
		String driver = "org.mariadb.jdbc.Driver";//connection jar 파일
		
		Statement stmt = null;
		Connection conn = null;
		ResultSet rs = null;
		
		String csID;
		String csPW;
		String maID;
		String maPW;
		String stID;
		String stPW;
		
		String jdbcDriver = "jdbc:mariadb://localhost:3306/rodus";
		String dbUser = "root";
		String dbPass = "1103";
		String redirect = null;
		try {
			Class.forName(driver);//등록
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//연결
		}
		catch(ClassNotFoundException e)
		{
			e.printStackTrace();
		}
		
		String ID = request.getParameter("ID");//request는 이클립스에서 제공되는 함수
		String PW = request.getParameter("PW");//request는 이클립스에서 제공되는 함수
		//String insert = request.getParameter("register");
	
		
		System.out.println("login :"+ID);
		
		stmt=conn.createStatement();
		//pw를 복호화해서 받음
		String compareID1 = "select user_CS_ID, des_decrypt(user_pw) as user_pw from consumer;";
		String compareID2 = "select user_MA_ID, des_decrypt(user_pw) as user_pw from magician;";
		String compareID3 = "select user_ST_ID, des_decrypt(user_pw) as user_pw from store;";
		//PreparedStatement preStmt = conn.prepareStatement(compareID);
		//String IDS = stmt.executeQuery(compareID).getString("IDS");
		//stmt = conn.prepareStatement(compareID);
		//preStmt.setString(1, compareID);
		rs = stmt.executeQuery(compareID1);
		int count = 0;
		while(rs.next()){
			csID = rs.getString("user_CS_ID");//
			csPW = rs.getString("user_pw");
			if(ID.equals(csID) && PW.equals(csPW))
			{
				session.setAttribute("ID", ID);
				redirect = "logonCS.jsp";
			}
			else if(ID.equals(csID) && !PW.equals(csPW))
			{
				%><p> 잘못된 비밀번호입니다.<%
				count++;
			}
			else{
				
			}
		}
		
		rs = stmt.executeQuery(compareID2);
		while(rs.next()){
			maID = rs.getString("user_MA_ID");//
			maPW = rs.getString("user_pw");
			if(ID.equals(maID) && PW.equals(maPW))
			{
				session.setAttribute("ID", ID);
				redirect = "logonMA.jsp";
			}
			else if(ID.equals(maID) && !PW.equals(maPW))
			{
				%><p> 잘못된 비밀번호입니다.<%
				count++;
			}
			else{
				
			}
		}
		
		rs = stmt.executeQuery(compareID3);
		while(rs.next()){
			stID = rs.getString("user_ST_ID");//
			stPW = rs.getString("user_pw");
			if(ID.equals(stID) && PW.equals(stPW))
			{
				session.setAttribute("ID", ID);//ID는 unique한 값이므로 ID만 넘겨도 됨
				redirect = "logonST.jsp";
			}
			else if(ID.equals(stID) && !PW.equals(stPW))
			{
				%><p> 잘못된 비밀번호입니다.<%
				count++;
			}
			else{
				
			}
		}
		
		System.out.println(count);
		if (redirect != null)
		{
			response.sendRedirect(redirect);
		}
		else if(count == 0){
			%><p>존재하지 않는 ID입니다.
		<%}
		
	//	preStmt.close();
		conn.close();
		}catch(NumberFormatException e)//잘못된 값을 파라미터로 받았을때 exception e
	{%>
	<p> 올바르지 못한 정보입니다. 
	<%
	}
	%>
	<input type="button" value="돌아가기" onclick="location.href='<%=url %>'">
</body>
</html>