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
<title>���� �˻� â</title>
</head>
<body>
<div>
<%
	String driver = "org.mariadb.jdbc.Driver";//connection jar ����
	Statement stmt = null;
	Connection conn = null;
	ResultSet rs = null;//SQL ��� �޾ƿö� ���
	
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
		Class.forName(driver);//���
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//����
		stmt=conn.createStatement();
		//rs = stmt.executeQuery();
		search = (String)request.getParameter("search");
		//searchint = Integer.parseInt(request.getParameter("search"));
		//System.out.println("dddddddd:"+search);
		magic_IDlist = (List<Object>)session.getAttribute("magic_IDlist");
		magic_namelist = (List<Object>)session.getAttribute("magic_namelist");//����Ʈ object �ޱ�
		classlist = (List<Object>)session.getAttribute("classlist");//���� �迭�� �ޱ�
		for (int i = 0; i < search.length(); i++){
				if((search.charAt(i) == '0' || search.charAt(i) == '1' || search.charAt(i) == '2'
                        || search.charAt(i) == '3' || search.charAt(i) == '4' || search.charAt(i) == '5'
                        || search.charAt(i) == '6' || search.charAt(i) == '7' || search.charAt(i) == '8'
                        || search.charAt(i) == '9'
                    ))
					searchint = Integer.parseInt(search);
		}
		%>
		<p> ã�� ����</p>
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
				//System.out.println("�̰͵��ǤǤ�"+findclass);
			}
		}*/
		//System.out.println("findclass"+findclass);
		//System.out.println("fineMAID : �̰Ŵ�"+findMAID);
		
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
			<a href="material_cnt.jsp?magic_findID=<%=magic_findID %>&count=<%=count1 %>"><%=p %>. ����ID :<%=magic_findIDlist.get(j) %>/Ŭ���� :<%=classs.get(j) %>/�ǸŰ��� :<%=sale_price.get(j) %>/�Ҽӻ���ID :<%=store_ID.get(j) %>/���� �̸� :<%=magic_name.get(j) %></a><br>
			<%
		}//��ư Ŭ���� �̺�Ʈ �߻�(�ʿ����)�� ���� ���ؼ� parameter�� ���° ������ ������
		
		%><input type="button" value="���ư���" onclick="history.go(-1)">
		
		<input type="submit" value="�α׾ƿ�" onclick="location.href='http://localhost:8080/1113/form.jsp'">
			
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