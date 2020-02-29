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
<title>magician_search</title>
</head>
<body><% //상회에서 마법사를 검색한 값을 받아서 비교해서 뿌려주는 페이지
String url= request.getHeader("referer");
	String driver = "org.mariadb.jdbc.Driver";//connection jar 파일
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
		String store_ID = (String)request.getParameter("store_ID");
		String search_kind = (String)request.getParameter("search_kind");
		String search = (String)request.getParameter("search");
		
		int searchint = 0;
		if(search_kind.equals("class"))
		{
			searchint = Integer.parseInt(search);// class로 검색 시 , Integer형으로 형변환
		}
		//concat(A, B) like '%__%'을 통해서 A,B 두 테이블의 data(tuple)을 catenation 해서 이름 검색에 사용할 수 있다.
		String magicianQ1 = "select * from magician where concat(Fname,Lname) like '%"+search+"%'";
		String magicianQ2 = "select * from magician where tribe like '%"+search+"%'";
		String magicianQ3 = "select * from magician where property like '%"+search+"%'";
		String magicianQ4 = "select * from magician where class = "+searchint+"";
		
		List<Object> magician_ID = new ArrayList<Object>();
		List<Object> Fname = new ArrayList<Object>();
		List<Object> Lname = new ArrayList<Object>();
		List<Object> age = new ArrayList<Object>();
		List<Object> tribe = new ArrayList<Object>();
		List<Object> nativee = new ArrayList<Object>();
		List<Object> job = new ArrayList<Object>();
		List<Object> classs = new ArrayList<Object>();
		List<Object> property = new ArrayList<Object>();
		List<Object> MP = new ArrayList<Object>();
		List<Object> money = new ArrayList<Object>();
		
		
		if(search_kind.equals("magician_name"))
		{
			rs = stmt.executeQuery(magicianQ1);
			while(rs.next())
			{
				magician_ID.add(rs.getInt("magician_ID"));
				Fname.add(rs.getString("Fname"));
				Lname.add(rs.getString("Lname"));
				age.add(rs.getInt("age"));
				tribe.add(rs.getString("tribe"));
				nativee.add(rs.getString("native"));
				job.add(rs.getString("job"));
				classs.add(rs.getInt("class"));
				property.add(rs.getString("property"));
				MP.add(rs.getInt("MP"));
				money.add(rs.getInt("money"));
			}
		}
		else if(search_kind.equals("tribe"))
		{
			rs = stmt.executeQuery(magicianQ2);
			while(rs.next())
			{
				magician_ID.add(rs.getInt("magician_ID"));
				Fname.add(rs.getString("Fname"));
				Lname.add(rs.getString("Lname"));
				age.add(rs.getInt("age"));
				tribe.add(rs.getString("tribe"));
				nativee.add(rs.getString("native"));
				job.add(rs.getString("job"));
				classs.add(rs.getInt("class"));
				property.add(rs.getString("property"));
				MP.add(rs.getInt("MP"));
				money.add(rs.getInt("money"));
			}
		}
		else if(search_kind.equals("property"))
		{
			rs = stmt.executeQuery(magicianQ3);
			while(rs.next())
			{
				magician_ID.add(rs.getInt("magician_ID"));
				Fname.add(rs.getString("Fname"));
				Lname.add(rs.getString("Lname"));
				age.add(rs.getInt("age"));
				tribe.add(rs.getString("tribe"));
				nativee.add(rs.getString("native"));
				job.add(rs.getString("job"));
				classs.add(rs.getInt("class"));
				property.add(rs.getString("property"));
				MP.add(rs.getInt("MP"));
				money.add(rs.getInt("money"));
			}
		}
		else{//class <- 숫자 int
			rs = stmt.executeQuery(magicianQ4);
			while(rs.next())
			{
				magician_ID.add(rs.getInt("magician_ID"));
				Fname.add(rs.getString("Fname"));
				Lname.add(rs.getString("Lname"));
				age.add(rs.getInt("age"));
				tribe.add(rs.getString("tribe"));
				nativee.add(rs.getString("native"));
				job.add(rs.getString("job"));
				classs.add(rs.getInt("class"));
				property.add(rs.getString("property"));
				MP.add(rs.getInt("MP"));
				money.add(rs.getInt("money"));
			}
		}
		for(int i =0; i< magician_ID.size(); i++)
		{
		%>
		<p>검색 결과<p>
		<p><%=i+1 %>. 법사 ID :<%=magician_ID.get(i) %>/이름(성) :<%=Fname.get(i) %> <%=Lname.get(i) %>/나이 :<%=age.get(i) %><br>
		부족 :<%=tribe.get(i) %>/출생지 :<%=nativee.get(i) %>/
		직업 :<%=job.get(i) %>/클래스 :<%=classs.get(i) %><br>
		속성 :<%=property.get(i) %>/MP :<%=MP.get(i) %>/
		자금 :<%=money.get(i) %><br></p>
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
	<input type="button" value="로그아웃" onclick="form.jsp">
	</body>
	</html>