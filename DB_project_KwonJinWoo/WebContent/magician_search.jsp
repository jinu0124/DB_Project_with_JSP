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
<body><% //��ȸ���� �����縦 �˻��� ���� �޾Ƽ� ���ؼ� �ѷ��ִ� ������
String url= request.getHeader("referer");
	String driver = "org.mariadb.jdbc.Driver";//connection jar ����
	Statement stmt = null;
	Connection conn = null;
	ResultSet rs = null;//SQL ��� �޾ƿö� ���
	
	String jdbcDriver = "jdbc:mariadb://localhost:3306/rodus";
	String dbUser = "root";
	String dbPass = "1103";
	String redirect = null;
	try {
		Class.forName(driver);//���
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//����
		
		stmt=conn.createStatement();
		//rs = stmt.executeQuery();
		String store_ID = (String)request.getParameter("store_ID");
		String search_kind = (String)request.getParameter("search_kind");
		String search = (String)request.getParameter("search");
		
		int searchint = 0;
		if(search_kind.equals("class"))
		{
			searchint = Integer.parseInt(search);// class�� �˻� �� , Integer������ ����ȯ
		}
		//concat(A, B) like '%__%'�� ���ؼ� A,B �� ���̺��� data(tuple)�� catenation �ؼ� �̸� �˻��� ����� �� �ִ�.
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
		else{//class <- ���� int
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
		<p>�˻� ���<p>
		<p><%=i+1 %>. ���� ID :<%=magician_ID.get(i) %>/�̸�(��) :<%=Fname.get(i) %> <%=Lname.get(i) %>/���� :<%=age.get(i) %><br>
		���� :<%=tribe.get(i) %>/����� :<%=nativee.get(i) %>/
		���� :<%=job.get(i) %>/Ŭ���� :<%=classs.get(i) %><br>
		�Ӽ� :<%=property.get(i) %>/MP :<%=MP.get(i) %>/
		�ڱ� :<%=money.get(i) %><br></p>
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
	<input type="button" value="���ư���" onclick="history.go(-1)">
	<input type="button" value="�α׾ƿ�" onclick="form.jsp">
	</body>
	</html>