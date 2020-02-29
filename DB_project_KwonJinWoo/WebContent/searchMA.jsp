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
<%//@page import="StringUtils.java"%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>마법 검색 창</title>
</head>
<body>
<div>
<%
	String driver = "org.mariadb.jdbc.Driver";//connection jar 파일
	Statement stmt = null;
	Connection conn = null;
	ResultSet rs = null;//SQL 출력 받아올때 사용
	
	String jdbcDriver = "jdbc:mariadb://localhost:3306/rodus";
	String dbUser = "root";
	String dbPass = "1103";
	String redirect = null;
	
	List<Object> magic_IDlist = new ArrayList<Object>();	
	List<Object> magic_namelist = new ArrayList<Object>();
	List<Object> classlist = new ArrayList<Object>();
	String search = null;
	int searchint = 0;
	try {
		Class.forName(driver);//등록
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//연결
		stmt=conn.createStatement();
		//rs = stmt.executeQuery();
		search = (String)request.getParameter("search");
		//searchint = Integer.parseInt(request.getParameter("search"));
		//System.out.println("dddddddd:"+search);
		magic_IDlist = (List<Object>)session.getAttribute("magic_IDlist");
		magic_namelist = (List<Object>)session.getAttribute("magic_namelist");//리스트 object 받기
		classlist = (List<Object>)session.getAttribute("classlist");//숫자 배열을 받기
		for (int i = 0; i < search.length(); i++){
				if((search.charAt(i) == '0' || search.charAt(i) == '1' || search.charAt(i) == '2'
                        || search.charAt(i) == '3' || search.charAt(i) == '4' || search.charAt(i) == '5'
                        || search.charAt(i) == '6' || search.charAt(i) == '7' || search.charAt(i) == '8'
                        || search.charAt(i) == '9'
                    ))
					searchint = Integer.parseInt(search);
		}
		%>
		<p> 찾은 마법</p>
		<%
		int findMAID = 0;
		int findclass = 0;
		String findMAname = null;
		System.out.println("search in MA:"+search);
		
		/*
		for(int i = 0; i < magic_namelist.size(); i++)
		{
			if((int)magic_IDlist.get(i) == searchint)
			{
			  findMAID = (int)magic_IDlist.get(i);
			}
		}
		//System.out.println("magic_namelis"+(String)magic_namelist.get(2));
		for(int i = 0; i < magic_namelist.size(); i++)
		{
			if(search.equals(magic_namelist.get(i)))
			{
				findMAname = search;
			}
		}
		for(int i = 0; i < magic_namelist.size(); i++)
		{
			if((int)classlist.get(i) == searchint)
			{
				findclass = (int)classlist.get(i);
				//System.out.println("이것도ㅗㅗㅗ"+findclass);
			}
		}*/
		//System.out.println("findclass"+findclass);
		//System.out.println("fineMAID : 이거다"+findMAID);
		
		String findMAQ = "select magic_ID, class, sale_price, store_ID, magic_name from magic where magic_name like '%"+search+"%' or magic_ID = "+searchint+" or class = "+searchint+"";
		rs = stmt.executeQuery(findMAQ);
		List<Object> magic_findIDlist = new ArrayList<Object>();
		List<Object> classs = new ArrayList<Object>();
		List<Object> sale_price = new ArrayList<Object>();
		List<Object> store_ID = new ArrayList<Object>();
		List<Object> magic_name = new ArrayList<Object>();
		//List<Object> k = new ArrayList<Object>();
		while(rs.next())
		{
			magic_findIDlist.add(rs.getInt("magic_ID"));
			classs.add(rs.getInt("class"));
			sale_price.add(rs.getInt("sale_price"));
			store_ID.add(rs.getInt("store_ID"));
			magic_name.add(rs.getString("magic_name"));
			
		}
		//session.setAttribute("magic_findIDlist",magic_findIDlist);
		//System.out.println("magic_findIDlist"+magic_findIDlist);
		int p = 0, p1=1;
		int magic_findID = 0;
		int count = 0;
		int count1 = 1;
		int magic_ID = 0;
		for(int j = 0; j<magic_findIDlist.size(); j++)
		{
			magic_findID = (int)magic_findIDlist.get(j);
			p = p + p1;%>
			<a href="material_cnt.jsp?magic_findID=<%=magic_findID %>&count=<%=count1 %>"><%=p %>. 마법ID :<%=magic_findIDlist.get(j) %>/클래스 :<%=classs.get(j) %>/판매가격 :<%=sale_price.get(j) %>/소속상점ID :<%=store_ID.get(j) %>/마법 이름 :<%=magic_name.get(j) %></a><br>
			<%
		}//버튼 클릭시 이벤트 발생(필요재료)를 띄우기 위해서 parameter로 몇번째 것인지 보내줌
		
		%><input type="button" value="돌아가기" onclick="history.go(-1)">
		
		<input type="submit" value="로그아웃" onclick="location.href='http://localhost:8080/1113/form.jsp'">
			
		<div><%
		%></div>
		<p></p>
		<!--  <script type="text/javascript">
	function confirm_alert(k) {
		var t = 1;
    return confirm(t);
</script>
}-->
		<%
}catch(NumberFormatException e)
{
	e.printStackTrace();
}
	catch(SQLException se)
	{
		se.printStackTrace();
	}
	%>