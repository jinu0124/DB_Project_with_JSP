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
<title>ST_magic_buy</title>
</head>
<body><% // �Һ��ڿ��� ������ȸ�� ���� �춧 ������ page
String url= request.getHeader("referer");
	String driver = "org.mariadb.jdbc.Driver";//connection jar ����
	String ID = (String)session.getAttribute("ID");
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
		int consumer_ID = Integer.parseInt(request.getParameter("consumer_ID"));
		int store_ID = Integer.parseInt(request.getParameter("store_ID"));
		int money = Integer.parseInt(request.getParameter("money"));//consumer�� ���� �Ӵ�
		double sale_price = Integer.parseInt(request.getParameter("sale_price"));//�����⸦ ���� double ������ ����
		int magic_ID = Integer.parseInt(request.getParameter("magic_ID"));
		//String property = (String)(request.getParameter("property"));
		
		Integer magic_IDQ = 0;//magic_ID �� null�� �Ǹ� �޾ƿ°��� �����Ƿ� �������� ���� magic�̱� ������ ���� ����
		System.out.println("ST_magic_buy :"+consumer_ID+store_ID+money+sale_price+magic_ID);
		String magic_info = "select property, magic_name, class from magic where magic_ID = "+magic_ID+";";
		String magic_buy = "insert into sale_purchase(store_ID, consumer_ID, magic_ID) values("+store_ID+", "+consumer_ID+", "+magic_ID+")";
		String magic_haveQ = "select magic_ID from sale_purchase where consumer_ID = "+consumer_ID+" and magic_ID = "+magic_ID+";";
		
		String magician = "select magician_ID from magic where magic_ID = "+magic_ID+";";
		String property = null;
		String magic_name = null;
		int classs = 0;
		
		int magician_ID = 0;
		rs = stmt.executeQuery(magician);
		while(rs.next())
		{
			magician_ID = rs.getInt("magician_ID");
		}//������ â���� ������ ID
		
		rs = stmt.executeQuery(magic_info);
		while(rs.next())
		{
			property = rs.getString("property");
			magic_name = rs.getString("magic_name");
			classs = rs.getInt("class");
		}
		String CSproperty = null;
		String consumer_property = "select property from consumer where consumer_ID = "+consumer_ID+";";
		rs = stmt.executeQuery(consumer_property);
		while(rs.next())
		{
			CSproperty = rs.getString("property");//����� ������ �Ӽ��� ������ �����ֱ� ���ؼ� property �ҷ���
		}
		
		if(CSproperty.equals(property))//������1 ��ȯ , property:������ �Ӽ�, CSproperty:�Һ����� �Ӽ� -> ������ ���� 10��
		{//�ڽ� �Ӽ��� ���� ���� 10�� ����
			sale_price = Math.ceil(sale_price*0.9);//10�� �����ϵ� �Ҽ����� �ø���.
			System.out.println("���ι��� 90�� ���� :"+sale_price);
		}
		
		double sale_pricefloor = 0;
		double sale_priceceil = 0;
		
		sale_pricefloor = Math.floor(sale_price/2);//����(math�Լ� ���)//���� �ŷ��� ���� �ݶ��ϱ�
		sale_priceceil = Math.ceil(sale_price/2);//�ø�
		System.out.println("���� floor, ceil :"+sale_pricefloor+sale_priceceil);
		
		
		
		String consumer_money = "update consumer set money = case when '"+CSproperty+"' = '"+property+"' then money - "+sale_price+" else money - "+sale_price+" end where consumer_ID = "+consumer_ID+";";
		String magician_money = "update magician set money = case when '"+CSproperty+"' = '"+property+"' then money + "+sale_priceceil+" else money + "+sale_priceceil+" end where magician_ID = "+magician_ID+";";
		String store_money = "update store set money = case when '"+CSproperty+"' = '"+property+"' then money + "+sale_pricefloor+" else money + "+sale_pricefloor+" end where store_ID = "+store_ID+";";
		//�Һ��ڰ� �Ӽ��� ���� ����(10%)�� ������ 0.45�辿 �ް� �������� 0.5�辿 ����(update set = case when then else ���)
		rs = stmt.executeQuery(magic_haveQ);
		while(rs.next())
		{
			magic_IDQ = rs.getInt("magic_ID");
		}
		
		if(money - sale_price >= 0 && magic_IDQ == 0)
		{
			stmt.executeQuery(magic_buy);
			stmt.executeQuery(consumer_money);//�Һ��� �� ���
			stmt.executeQuery(magician_money);//������ �� ����
			stmt.executeQuery(store_money);//��ȸ ������
			%>
			����<%=magic_name %>��(��) ���������� �����Ͽ����ϴ�.<br>
			<input type="button" value="���ư���" onclick="history.go(-1)">
			<input type="button" value="�α׾ƿ�" onclick="location.href='http://localhost:8080/1113/form.jsp'">
		}
		else if(magic_IDQ == magic_ID)
		{
			%>
			<p>�̹� ������ �����Դϴ�.</p>
			<input type="button" value="���ư���" onclick="history.go(-1)">
			<input type="button" value="�α׾ƿ�" onclick="location.href='http://localhost:8080/1113/form.jsp'">
			<%
		}
		else{
			%>
			������ money�� �����Ͽ� �������� ���Ͽ����ϴ�.<br>
			<input type="button" value="���ư���" onclick="history.go(-1)">
			<input type="button" value="�α׾ƿ�" onclick="location.href='http://localhost:8080/1113/form.jsp'">
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
	
	</body>
	</html>