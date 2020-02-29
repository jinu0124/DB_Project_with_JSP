<%@page import="java.sql.SQLException"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.util.List" %>
<%@page import="java.util.ArrayList" %>
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
<title>MAnotice</title>
</head>
<body><%//마법사 정보 보기 창
String url= request.getHeader("referer");
	String driver = "org.mariadb.jdbc.Driver";//connection jar 파일
	String ID = (String)session.getAttribute("ID");
	Statement stmt = null;
	Connection conn = null;
	ResultSet rs = null;//SQL 출력 받아올때 사용
	
	String jdbcDriver = "jdbc:mariadb://localhost:3306/rodus";
	String dbUser = "root";
	String dbPass = "1103";
	String redirect = null;
	try {
		Class.forName(driver);//등록
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//연결
		
		stmt=conn.createStatement();
		//rs = stmt.executeQuery();
		int magician_ID = Integer.parseInt(request.getParameter("magician_ID"));
		
		String magician_info = "select Fname, Lname, age, tribe, native, job, class, property, MP, money, store_ID, user_MA_ID, des_decrypt(user_pw) as user_pw from magician where magician_ID = "+magician_ID+";";
		
		String Fname = null;
		String Lname = null;
		int age = 0;
		String tribe = null;
		String nativee = null;
		String job = null;
		int classs = 0;
		String property = null;
		int MP = 0;
		int money = 0;
		String user_MA_ID = null;
		String user_pw = null;
		Integer store_ID = 0;
		
		rs = stmt.executeQuery(magician_info);
		while(rs.next())
		{
			Fname = rs.getString("Fname");
			Lname = rs.getString("Lname");
			tribe = rs.getString("tribe");
			user_MA_ID = rs.getString("user_MA_ID");
			nativee = rs.getString("native");
			job = rs.getString("job");
			classs = rs.getInt("class");
			property = rs.getString("property");
			user_pw = rs.getString("user_pw");
			MP = rs.getInt("MP");
			money = rs.getInt("money");
			age = rs.getInt("age");
			store_ID = rs.getInt("store_ID");
		}
		
		System.out.println("MA_INFO_MOD :"+magician_ID+classs+MP+money+age+store_ID+Fname+Lname+tribe+user_MA_ID+nativee+job+property+user_pw);
		String jobQ = "select distinct job from magician";
		List<Object> joblist = new ArrayList<Object>();
		rs = stmt.executeQuery(jobQ);
		while(rs.next())
		{
			joblist.add(rs.getString("job"));
		}
		%>
		<form action = "MA_info_mod.jsp" method = "post">
		<h4> 마법사 정보</h4>
		<p>마법사 ID :<%=magician_ID %></p><input type="hidden" name = "magician_ID" value=<%=magician_ID %>>
		<p>이름 :<%=Fname %> <%=Lname %> 성:<input type="text" name="Fname" value=<%=Fname %>> 이름:<input type="text" name="Lname" value=<%=Lname %>></p>
		<p>부족 :<%=tribe %><input type="hidden" name="tribe" value=<%=tribe %>></p>
		<p>출생지 :<%=nativee %><input type="hidden" name="native" value=<%=nativee %>></p>
		<p>직업 :<%=job %>
		<select name="job">
		<%for(int k=0; k<joblist.size(); k++)
			{%>
			<option><%=joblist.get(k) %></option>
			<%} %>
		</select></p>
		<p>클래스 :<%=classs %>
		<select name="class">	
		<%
		for(int j=classs; j<11; j++)
		{
			%>
			<option><%=j %></option>
			<%
		}
		%>
		</select>
		</p>
		<p>속성 :<%=property %></p><input type ="hidden" name= "property" value=<%=property %>>
		<p>MP :<%=MP %></p><input type ="hidden" name= "MP" value=<%=MP %>>
		<p>자금 :<%=money %></p><input type ="hidden" name= "money" value=<%=money %>>
		<p>나이 :<%=age %><input type = "number" name="age" value =<%=age %>></p>
		<p>사용자 ID :<%=user_MA_ID %><input type="text" name="user_MA_ID" value=<%=user_MA_ID %>></p>
		<p>사용자 PW :<input type="text" name="user_pw" value=<%=user_pw %>></p>
		<input type="hidden" name = "store_ID" value=<%=store_ID %>>
		<button type="submit">수정하기</button>
		</form>
		<%
		if(store_ID == 0)
		{
			%>
			<p>현재 소속된 상회가 없습니다.</p><%
		}
		else{
		%>
		<h4>소속된 상회</h4>
		<a href="MA_ST_info.jsp?store_ID=<%=store_ID %>"> 상회ID :<%=store_ID %>(상회정보보기)</a><br>
		<%
		}
	if(redirect != null)
	{
		//String user_MA_ID = (String)request.getParameter("magician_ID");
	}
}catch(NumberFormatException e)
{
	e.printStackTrace();
}
	catch(SQLException se)
	{
		se.printStackTrace();
	}
	%>
	<input type="button" value="돌아가기" onclick="history.go(-1)">
	<input type="button" value="로그아웃" onclick="location.href='http://localhost:8080/1113/form.jsp'">
	</body>
	</html>