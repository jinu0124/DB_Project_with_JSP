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
<title>magic_trade_info</title>
</head>
<body><% // �����翡�� �����簡 â���� ���� �ŷ����� Ȯ�� 
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
		int magician_ID = Integer.parseInt(request.getParameter("magician_ID"));
		String MAFname = (String)(request.getParameter("Fname"));
		String MALname = (String)(request.getParameter("Lname"));
		String property = (String)(request.getParameter("property"));
		
		List<Object> trade_ID = new ArrayList<Object>();
		List<Object> consumer_ID = new ArrayList<Object>();
		List<Object> sale_price = new ArrayList<Object>();
		List<Object> CSFname = new ArrayList<Object>();
		List<Object> CSLname = new ArrayList<Object>();
		List<Object> address = new ArrayList<Object>();
		List<Object> magic_ID = new ArrayList<Object>();
		List<Object> magic_name = new ArrayList<Object>();
		
		String tradeQ = "SELECT trade_ID, sale_purchase.magic_ID as magic_ID, sale_purchase.consumer_ID as consumer_ID, magic_name, sale_price, Fname, Lname, address FROM sale_purchase, magic, consumer WHERE magic.magic_ID = sale_purchase.magic_ID AND magician_ID = "+magician_ID+" AND sale_purchase.consumer_ID = consumer.consumer_ID;";
		//�ŷ�, �Һ���, ���� ���̺��� ���ļ� trade_ID, �Ǹŵ� ����, ������ �Һ����� ����, �����̸� �� ������, natural join + �������� ID ������ �� ����
		rs = stmt.executeQuery(tradeQ);
		while(rs.next())
		{
			trade_ID.add(rs.getInt("trade_ID"));
			consumer_ID.add(rs.getInt("consumer_ID"));
			sale_price.add(rs.getInt("sale_price"));
			CSFname.add(rs.getString("Fname"));
			CSLname.add(rs.getString("Lname"));
			address.add(rs.getString("address"));
			magic_ID.add(rs.getInt("magic_ID"));
			magic_name.add(rs.getString("magic_name"));
		}
		int j = 0;
		%>
		<h4><%=MAFname %> <%=MALname %>���� �ŷ����� list</h4>
		<%
		for(int i=0; i<trade_ID.size(); i++)
		{
			j++;
			%>
			<p><%=j %>.�ŷ���ȣ:<%=trade_ID.get(i) %>/�Һ���ID:<%=consumer_ID.get(i) %>/����ID:<%=magic_ID.get(i) %>/�Һ���ID:<%=consumer_ID.get(i) %></p>
			<p>�����̸�:<%=magic_name.get(i) %>/�ǸŰ���:<%=sale_price.get(i) %>/�Һ����̸�:<%=CSFname.get(i) %> <%=CSLname.get(i) %>/�Һ����ּ���:<%=address.get(i) %></p>
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
	<input type="button" value="�α׾ƿ�" onclick="location.href='http://localhost:8080/1113/form.jsp'">
	</body>
	</html>