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
try{//ID �ߺ��˻縦 ����
		
		String driver = "org.mariadb.jdbc.Driver";//connection jar ����
		
		Statement stmt = null;
		Connection conn = null;
		ResultSet rs = null;
		
		String jdbcDriver = "jdbc:mariadb://localhost:3306/rodus";
		String dbUser = "root";
		String dbPass = "1103";
		String redirect = null;
		try {
			Class.forName(driver);//���
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//����
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
String address = (String)request.getParameter("address");//request�� ��Ŭ�������� �����Ǵ� �Լ�
if(address.equals("ETC"))
{
	address = (String)request.getParameter("address1");
}
String tribe = (String)request.getParameter("tribe");//request�� ��Ŭ�������� �����Ǵ� �Լ�
String STID = (String)request.getParameter("STID");//String "name" �Ķ���͸� �޾ƿ�//jsp ���� �������� request.getParameter
String STPW = (String)request.getParameter("STPW");//request�� ��Ŭ�������� �����Ǵ� �Լ�
int money = Integer.parseInt(request.getParameter("money"));//request�� ��Ŭ�������� �����Ǵ� �Լ�
int classs = Integer.parseInt(request.getParameter("class"));//request�� ��Ŭ�������� �����Ǵ� �Լ�
String store_name = (String)request.getParameter("store_name");//request�� ��Ŭ�������� �����Ǵ� �Լ�

//get ����� url�� ���, post ����� ���� ���ܼ� ������(url �� ���� X).// �޾ƿ� ����(form â���� ����)
		String url= request.getHeader("referer");
		String Name;

		String role = (String)session.getAttribute("store");//String "name" �Ķ���͸� �޾ƿ�
		String Fname = (String)session.getAttribute("Fname");//request�� ��Ŭ�������� �����Ǵ� �Լ�
		String Lname = (String)session.getAttribute("Lname");//request�� ��Ŭ�������� �����Ǵ� �Լ�
		
		//int age = (Integer)(session.getAttribute("age"));
		/*Fname.concat(Lname);
		Name = Fname;
		System.out.printf("����� �̸� :", Name);*/
		Fname = Fname.toUpperCase();//Name�� �빮�ڷ� ��ȯ �Ϸ�
		Lname = Lname.toUpperCase();
		String boss = Fname + Lname;
		
		int MP = 0;
		session.setAttribute("role", role);//name ���� user_name�� �ֱ�(�Ķ���ͷ� ������ ��)
		session.setAttribute("boss", boss);
		session.setAttribute("address", address);//name ���� user_name�� �ֱ�(�Ķ���ͷ� ������ ��)
		session.setAttribute("tribe", tribe);
		session.setAttribute("STID", STID);
		session.setAttribute("STPW", STPW);//name ���� user_name�� �ֱ�(�Ķ���ͷ� ������ ��)
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