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
<body><% // ��ȸ���� ���,���� �ŷ����� Ȯ�� 
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
		int store_ID = Integer.parseInt(request.getParameter("store_ID"));
		String boss = (String)(request.getParameter("boss"));//��ǥ�ڸ�
		
		List<Object> trade_ID = new ArrayList<Object>();
		List<Object> material_ID = new ArrayList<Object>();
		List<Object> material_name = new ArrayList<Object>();
		List<Object> tot_price = new ArrayList<Object>();
		List<Object> count = new ArrayList<Object>();
		List<Object> consumer_ID = new ArrayList<Object>();
		//------------��� ���� ���� ����Ʈ
		
		List<Object> MAtrade_ID = new ArrayList<Object>();
		List<Object> magic_ID = new ArrayList<Object>();
		List<Object> magic_name = new ArrayList<Object>();
		List<Object> sale_price = new ArrayList<Object>();
		List<Object> MAconsumer_ID = new ArrayList<Object>();
		List<Object> Fname = new ArrayList<Object>();
		List<Object> Lname = new ArrayList<Object>();
		//------------���� ���� ���� ����Ʈ
		
		List<Object> MTmaterial_ID = new ArrayList<Object>();
		List<Object> material_cnt = new ArrayList<Object>();
		List<Object> MTmaterial_name = new ArrayList<Object>();
		//------------��� ���� ���� ����Ʈ
		
		String tradeQ = "SELECT trade_ID, sale_purchase.consumer_ID as consumer_ID, sale_purchase.material_ID as material_ID, material_name, price*COUNT as tot_price, count FROM material, store, sale_purchase WHERE store.store_ID = sale_purchase.store_ID AND material.material_ID = sale_purchase.material_ID AND sale_purchase.store_ID = "+store_ID+" AND sale_purchase.material_ID IS NOT NULL ORDER BY trade_ID;";
		//�ŷ�, ��ȸ, ��� ���̺��� ���ļ� trade_ID, trade ID������ ���� , ������ �ŷ����� �̾ƿ��� natural join + ��ȸ�� ID ������ �� ����
		rs = stmt.executeQuery(tradeQ);
		while(rs.next())
		{
			trade_ID.add(rs.getInt("trade_ID"));
			material_ID.add(rs.getInt("material_ID"));
			material_name.add(rs.getString("material_name"));
			tot_price.add(rs.getInt("tot_price"));
			count.add(rs.getInt("count"));
			consumer_ID.add(rs.getInt("consumer_ID"));
		}
		int j = 0;
		%>
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>�Ǹ� ���ŷ� LIST(Click)</h2>
		</a><div style="DISPLAY: none">
		<%
			for(int i=0; i<trade_ID.size(); i++)
			{
				j++;
				%>
			<p><%=j %>.�ŷ���ȣ:<%=trade_ID.get(i) %>/���ID:<%=material_ID.get(i) %>/����̸�:<%=material_name.get(i) %>/����:<%=tot_price.get(i) %>/����:<%=count.get(i) %>/�Һ���ID:<%=consumer_ID.get(i) %></p>
			<%
		}
		%>
		</div>
		<%
		
		String MAtradeQ = "SELECT trade_ID, sale_purchase.magic_ID AS magic_ID, magic_name, sale_price, sale_purchase.consumer_ID AS consumer_ID, Fname, Lname FROM magic, sale_purchase, store, consumer WHERE consumer.consumer_ID = sale_purchase.consumer_ID and magic.magic_ID = sale_purchase.magic_ID AND store.store_ID = magic.store_ID AND sale_purchase.store_ID = "+store_ID+" AND sale_purchase.magic_ID IS NOT NULL ORDER BY trade_ID;";
		//�ŷ�, ��ȸ, ���, �Һ��� ���̺��� ���ļ� trade_ID, trade ID������ ���� , �������� �ŷ����� �̾ƿ��� natural join + ��ȸ�� ID ������ �� ���� ���
		rs = stmt.executeQuery(MAtradeQ);
		while(rs.next())
		{
			MAtrade_ID.add(rs.getInt("trade_ID"));
			magic_ID.add(rs.getInt("magic_ID"));
			magic_name.add(rs.getString("magic_name"));
			sale_price.add(rs.getInt("sale_price"));
			MAconsumer_ID.add(rs.getInt("consumer_ID"));
			Fname.add(rs.getString("Fname"));
			Lname.add(rs.getString("Lname"));
		}
		
		j = 0;
		%>
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>�Ǹ� �����ŷ� LIST(Click)</h2>
		</a><div style="DISPLAY: none">
		<%
			for(int i=0; i<MAtrade_ID.size(); i++)
			{
				j++;
				%>
			<p><%=j %>.�ŷ���ȣ:<%=MAtrade_ID.get(i) %>/����ID:<%=magic_ID.get(i) %>/�����̸�:<%=magic_name.get(i) %>/�ǸŰ���:<%=sale_price.get(i) %>/�Һ���ID:<%=MAconsumer_ID.get(i) %>/�Һ����̸�:<%=Fname.get(i) %> <%=Lname.get(i) %></p>
			<%
		}
		%>
		</div>
		<%
		
		String MTQ = "select distinct material_have.material_ID, material_name, material_cnt from material, material_have where material.material_ID = material_have.material_ID and material_have.store_ID = "+store_ID+";";
		rs = stmt.executeQuery(MTQ);
		
		while(rs.next())
		{
			MTmaterial_ID.add(rs.getInt("material_ID"));
			material_cnt.add(rs.getInt("material_cnt"));
			MTmaterial_name.add(rs.getString("material_name"));
		}
		j = 0;
		%>
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>���� ��� LIST(Click)</h2>
		</a><div style="DISPLAY: none">
		<%
			for(int i=0; i<MTmaterial_ID.size(); i++)
			{
				j++;
				%>
			<p><%=j %>.���ID:<%=MTmaterial_ID.get(i) %>/��᰹��:<%=material_cnt.get(i) %>/��� �̸�:<%=MTmaterial_name.get(i) %></p>
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