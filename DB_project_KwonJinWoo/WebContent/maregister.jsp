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
try{//get ����� url�� ���, post ����� ���� ���ܼ� ������(url �� ���� X).
		//ȸ������ �� ������� ȸ������ �ϸ� ������ �޾ƿͼ� �������� �˻� �� �Ѱ��ֱ�
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
String address = (String)request.getParameter("address");//request�� ��Ŭ�������� �����Ǵ� �Լ�
if (address.equals("ETC"))//ETC ��Ÿ �Է��� �޾����� text ���� �޾ƿ��� ���� if��
{
	address = (String)request.getParameter("address1");
}
String job = (String)request.getParameter("job");
if (job.equals("ETC"))//ETC ��Ÿ �Է��� �޾����� text ���� �޾ƿ��� ���� if��
{
	job = (String)request.getParameter("job1");
}
String property = (String)request.getParameter("property");//request�� ��Ŭ�������� �����Ǵ� �Լ�
String MAID = (String)request.getParameter("MAID");//String "name" �Ķ���͸� �޾ƿ�//jsp ���� �������� request.getParameter
String MAPW = (String)request.getParameter("MAPW");//request�� ��Ŭ�������� �����Ǵ� �Լ�
String tribe = (String)request.getParameter("tribe");
int classs = Integer.parseInt(request.getParameter("class"));
int MP = Integer.parseInt(request.getParameter("MP"));
int money = Integer.parseInt(request.getParameter("money"));//request�� ��Ŭ�������� �����Ǵ� �Լ�

String elder = "elder";//if�� �񱳸� ���ؼ� ���
Integer num = 123;//ELDER�� ���� ���� ��ȣ
Integer coupon = null;
coupon = Integer.parseInt(request.getParameter("coupon"));
int count = 1;
if(property.equals(elder) && coupon != num)//��ü������ �޾Ƽ� NULL���� �͵� ����X,������ȣ�� ����ġ�ϸ� ������������ �������� 
{//������ property�� elder�ε� ������ȣ�� �������� ������ �ٽ� ����ȭ������ ��������.
	
	session.setAttribute("couponerr", coupon);
	session.setAttribute("count", count);
	redirect = "magician.jsp";
	if(redirect != null)
	{
		response.sendRedirect(redirect);
		
	}
	redirect = null;
}// <- ������ȣ �ٸ� �� ���� ������ ������������ count ���� 1�� �ְ� coupon err��
//get ����� url�� ���, post ����� ���� ���ܼ� ������(url �� ���� X).// �޾ƿ� ����(form â���� ����)
		String url= request.getHeader("referer");
		String Name;

		String role = (String)session.getAttribute("magician");//String "name" �Ķ���͸� �޾ƿ�
		String Fname = (String)session.getAttribute("Fname");//request�� ��Ŭ�������� �����Ǵ� �Լ�
		String Lname = (String)session.getAttribute("Lname");//request�� ��Ŭ�������� �����Ǵ� �Լ�
		int age = (Integer)(session.getAttribute("age"));
		/*Fname.concat(Lname);
		Name = Fname;
		System.out.printf("����� �̸� :", Name);*/
		Fname = Fname.toUpperCase();//Name�� �빮�ڷ� ��ȯ �Ϸ�
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
		
		session.setAttribute("role", role);//name ���� user_name�� �ֱ�(�Ķ���ͷ� ������ ��)
		session.setAttribute("Fname", Fname);
		session.setAttribute("Lname", Lname);
		session.setAttribute("address", address);//name ���� user_name�� �ֱ�(�Ķ���ͷ� ������ ��)
		session.setAttribute("property", property);
		session.setAttribute("MAID", MAID);
		session.setAttribute("MAPW", MAPW);//name ���� user_name�� �ֱ�(�Ķ���ͷ� ������ ��)
		session.setAttribute("money", money);
		session.setAttribute("age", age);
		session.setAttribute("tribe", tribe);
		session.setAttribute("job", job);//name ���� user_name�� �ֱ�(�Ķ���ͷ� ������ ��)
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