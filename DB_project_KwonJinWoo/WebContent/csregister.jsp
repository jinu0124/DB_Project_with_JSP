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
try{//get ����� url�� ���, post ����� ���� ���ܼ� ������(url �� ���� X).
		//�Һ��ڰ� �����ϴ� ȭ�鿡�� ���� ������ �̿��Ͽ� ��� �ϵ� ID �ߺ� �˻�, ������ȣ �˻� ����� ������
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
		String CSIDD = (String)request.getParameter("CSID");
		
		String compareID1 = "select user_CS_ID, user_MA_ID, user_ST_ID from consumer, magician, store;";

		rs = stmt.executeQuery(compareID1);
		while(rs.next())
		{
			String IDD = rs.getString("user_MA_ID");
			String IDF = rs.getString("user_ST_ID");
			String IDE = rs.getString("user_CS_ID");
			if(CSIDD.equals(IDD) || CSIDD.equals(IDF) || CSIDD.equals(IDE))
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
String url= request.getHeader("referer");
	//get ����� url�� ���, post ����� ���� ���ܼ� ������(url �� ���� X).// �޾ƿ� ����(form â���� ����)
		String address = (String)request.getParameter("address");//request�� ��Ŭ�������� �����Ǵ� �Լ�
		if (address.equals("ETC"))
		{
			address = (String)request.getParameter("address1");
		}
		System.out.println("csreg_ETC address : "+address);
		String property = (String)request.getParameter("property");//request�� ��Ŭ�������� �����Ǵ� �Լ�
		String CSID = (String)request.getParameter("CSID");//String "name" �Ķ���͸� �޾ƿ�//jsp ���� �������� request.getParameter
		String CSPW = (String)request.getParameter("CSPW");//request�� ��Ŭ�������� �����Ǵ� �Լ�
		int money = Integer.parseInt(request.getParameter("money"));//request�� ��Ŭ�������� �����Ǵ� �Լ�
		
		//String url= request.getHeader("referer");
		String Name;
		String elder = "elder";//if�� �񱳸� ���ؼ� ���
		Integer num = 123;//ELDER�� ���� ���� ��ȣ
		Integer coupon = null;
		coupon = Integer.parseInt(request.getParameter("coupon"));//�ϴ� ������ȣ �ޱ�
		String role = (String)session.getAttribute("consumer");//String "name" �Ķ���͸� �޾ƿ�
		String Fname = (String)session.getAttribute("Fname");//request�� ��Ŭ�������� �����Ǵ� �Լ�
		String Lname = (String)session.getAttribute("Lname");//request�� ��Ŭ�������� �����Ǵ� �Լ�
		int age = (Integer)(session.getAttribute("age"));
		//System.out.println("coupon(in csreg) : "+coupon);
		//System.out.println("property (in cs): "+property);
		int count = 1;
		if(property.equals(elder) && coupon != num)//��ü������ �޾Ƽ� NULL���� �͵� ����X,������ȣ�� ����ġ�ϸ� ������������ �������� 
		{//������ property�� elder�ε� ������ȣ�� �������� ������ �ٽ� ����ȭ������ ��������.
			//System.out.println("coupon(in csreg) : "+coupon);
			//System.out.println("property (in cs): "+property);
			session.setAttribute("couponerr", coupon);
			session.setAttribute("count", count);
			redirect = "consumer.jsp";
			if(redirect != null)
			{
				response.sendRedirect(redirect);
				
			}
			redirect = null;
		}
		/*Fname.concat(Lname);
		Name = Fname;
		System.out.printf("����� �̸� :", Name);*/
		Fname = Fname.toUpperCase();//Name�� �빮�ڷ� ��ȯ �Ϸ�
		Lname = Lname.toUpperCase();
		//String redirect = null;
		
		System.out.println("CSregister");
		System.out.println(role);
		System.out.println(Fname);
		System.out.println(Lname);
		System.out.println(address);
		System.out.println(property);
		System.out.println(CSID);
		System.out.println(CSPW);
		System.out.println(money);
		System.out.println(age);
		
		int MP = 0;
		int classs = 0;//NULL pointer ����
		
		session.setAttribute("role", role);//name ���� user_name�� �ֱ�(�Ķ���ͷ� ������ ��)
		session.setAttribute("Fname", Fname);
		session.setAttribute("Lname", Lname);
		session.setAttribute("address", address);//name ���� user_name�� �ֱ�(�Ķ���ͷ� ������ ��)
		session.setAttribute("property", property);
		session.setAttribute("CSID", CSID);
		session.setAttribute("CSPW", CSPW);//name ���� user_name�� �ֱ�(�Ķ���ͷ� ������ ��)
		session.setAttribute("money", money);
		session.setAttribute("age", age);
		session.setAttribute("MP", MP);
		session.setAttribute("class", classs);

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