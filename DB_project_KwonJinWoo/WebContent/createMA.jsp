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
<title>마법창조</title>
</head>
<body>
<form>
<%//마법사가 마법을 창조하는 창
	String driver = "org.mariadb.jdbc.Driver";//connection jar 파일
	String ID = (String)session.getAttribute("ID");
	Statement stmt = null;
	Connection conn = null;
	ResultSet rs = null;//SQL 출력 받아올때 사용
	
	String jdbcDriver = "jdbc:mariadb://localhost:3306/rodus";
	String dbUser = "root";
	String dbPass = "1103";
	String redirect = null;
	int user_MA_ID =0;
	user_MA_ID = Integer.parseInt(request.getParameter("magician_ID"));//magician_ID를 받아와서 창조한 마법 알아내기
	String create_list = "Select magic_name, magic_ID, class, property, sale_price from magic where magician_ID = '"+user_MA_ID+"'";
	
	List<Object> magic_namelist=new ArrayList<Object>();
	List<Object> propertylist=new ArrayList<Object>();//배열 리스트 초기화 하기
	List<Object> classlist=new ArrayList<Object>();
	List<Object> magic_IDlist=new ArrayList<Object>();//숫자 배열 만들기
	List<Object> sale_pricelist=new ArrayList<Object>();
	
	try {
		Class.forName(driver);//등록
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//연결
		
		stmt=conn.createStatement();
		rs = stmt.executeQuery(create_list);
		String magic_name;
		String property;
		int magic_ID = 0;
		int classs = 0;
		int i = 0;
		int sale_price = 0;
		while(rs.next())
		{
			magic_name = rs.getString("magic_name");
			property = rs.getString("property");
			magic_ID = rs.getInt("magic_ID");
			classs = rs.getInt("class");
			sale_price = rs.getInt("sale_price");
			magic_namelist.add(magic_name);//배열 리스트에 하나씩 담기
			propertylist.add(property);
			magic_IDlist.add(magic_ID);//숫자 배열리스트에 하나씩 담기
			classlist.add(classs);
			sale_pricelist.add(sale_price);
			i++;//<a onclick 은 펼치기 접기를 위해 사용
		}
		if(user_MA_ID == 0)// 받아온 magician_ID가 없ㅇ으면 즉 세션이 종료되어서 받은것이 없는 것이므로 잘못된 접근 표시하기
			{
			%><p> 잘못된 접근입니다.</p>
			
		<%}%>
		</form>
		
		
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>창조한 마법 list(Click) <- 수정기능</h2>
		</a><div style="DISPLAY: none">
		<form action = "changeMG.jsp" method = "post">
		<%
		System.out.println("magic_IDlist, magician_ID :"+magic_IDlist+user_MA_ID);
		for(int j=0; j<magic_namelist.size(); j++)
		{
			magic_ID = (Integer)magic_IDlist.get(j);
			System.out.println("magic_ID"+magic_ID);
			i=j+1;
			%>
			<a href="changeMG.jsp?magic_ID=<%=magic_ID %>&magician_ID=<%=user_MA_ID %>"><%=i %>. 마법ID :<%=magic_IDlist.get(j) %>/클래스 :<%=classlist.get(j) %>/판매가격 :<%=sale_pricelist.get(j) %>/속성 :<%=propertylist.get(j) %>/마법 이름 :<%=magic_namelist.get(j) %></a><br>
			<%}
		%></form></div>
		<br>
			<h2>마법 검색하기(마법ID, 마법이름, Class)</h2><br>
			<p>(내가 만든 마법들 중)</p>
			<div>
			<form action="searchMA.jsp" method="post">
			<input type="text" name="search" placeholder="검색어 입력">
			<%
			session.setAttribute("magic_IDlist", magic_IDlist);//숫자배열 보내기
			session.setAttribute("magic_namelist", magic_namelist);
			session.setAttribute("classlist", classlist);
			%>
			<input type="submit" value="검색">
			<br>
			</form>
			<div>
		<input type="button" value="돌아가기" onclick="history.go(-1)">
		</div>
		<form action = "form.jsp" method = "get">
			<input type="submit" value="로그아웃" onclick="location.href='http://localhost:8080/1113/form.jsp'">
			<br>
			</form>
			
			</div>
			
			
			<%
		
}catch(NumberFormatException e)
{
	e.printStackTrace();
}
	catch(SQLException se)
	{
		se.printStackTrace();
}finally{
		try{
		}catch (Exception e2){
		}
	}
	%>
</body>
</html>