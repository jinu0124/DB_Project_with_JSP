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
<title>Consumer_trade_info</title>
</head>
<body><% // �Һ��ڿ��� �ŷ����� Ȯ���ϴ� â
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
		String Fname = (String)(request.getParameter("Fname"));
		String Lname = (String)(request.getParameter("Lname"));
		
		List<Object> trade_ID = new ArrayList<Object>();
		List<Object> material_ID = new ArrayList<Object>();
		List<Object> material_name = new ArrayList<Object>();
		List<Object> count = new ArrayList<Object>();
		List<Object> tot_price = new ArrayList<Object>();
		
		String tradeQ = "SELECT trade_ID, sale_purchase.material_ID AS material_ID, material_name, COUNT, count*price AS tot_price FROM sale_purchase, material, consumer WHERE consumer.consumer_ID = sale_purchase.consumer_ID and sale_purchase.material_ID = material.material_ID AND sale_purchase.material_ID IS NOT NULL AND sale_purchase.consumer_ID = "+consumer_ID+" ORDER BY trade_ID;";
		//�ŷ�, �Һ���, ���� ���̺��� ���ļ� trade_ID, �Ǹŵ� ����, ������ �Һ����� ����, �����̸� �� ������, natural join + �������� ID ������ �� ����
		rs = stmt.executeQuery(tradeQ);
		while(rs.next())
		{
			trade_ID.add(rs.getInt("trade_ID"));
			material_ID.add(rs.getInt("material_ID"));
			material_name.add(rs.getString("material_name"));
			count.add(rs.getInt("COUNT"));
			tot_price.add(rs.getInt("tot_price"));
		}
		int j = 0;
		%>
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>��� �ŷ� ���� LIST(Click)</h2>
		</a><div style="DISPLAY: none">
		<%
		for(int i=0; i<trade_ID.size(); i++)
		{
			j++;
			%>
			<p><%=j %>.�ŷ���ȣ:<%=trade_ID.get(i) %>/���ID:<%=material_ID.get(i) %>/����̸�:<%=material_name.get(i) %>/����:<%=count.get(i) %>/����:<%=tot_price.get(i) %></p>
			<%
		}
		%>
		</div>
		<%
			
		List<Object> MAtrade_ID = new ArrayList<Object>();
		List<Object> magic_ID = new ArrayList<Object>();
		List<Object> magic_name = new ArrayList<Object>();
		List<Object> sale_price = new ArrayList<Object>();
		String MAtradeQ = "SELECT trade_ID, sale_purchase.magic_ID AS magic_ID, magic_name, sale_price FROM sale_purchase, magic WHERE sale_purchase.magic_ID = magic.magic_ID AND sale_purchase.magic_ID IS NOT NULL AND sale_purchase.consumer_ID = "+consumer_ID+" ORDER BY trade_ID;";
		rs = stmt.executeQuery(MAtradeQ);
		while(rs.next())
		{
			MAtrade_ID.add(rs.getInt("trade_ID"));
			magic_ID.add(rs.getInt("magic_ID"));
			magic_name.add(rs.getString("magic_name"));
			sale_price.add(rs.getInt("sale_price"));
		}
		%>
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>���� �ŷ� ���� LIST(Click)</h2>
		</a><div style="DISPLAY: none">
		<%
		for(int i=0; i<MAtrade_ID.size(); i++)
		{
			j++;
			%>
			<p><%=j %>.�ŷ���ȣ:<%=MAtrade_ID.get(i) %>/����ID:<%=magic_ID.get(i) %>/�����̸�:<%=magic_name.get(i) %>/����:<%=sale_price.get(i) %></p>
			<%
		}
	%>
</div>
<%
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