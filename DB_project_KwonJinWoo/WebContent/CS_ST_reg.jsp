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
<title>CS_ST_reg</title>
</head>
<body><%// �Һ��ڿ��� ��ȸ�� ����Ϸ��Ҷ�, ���, ����, list
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
		String user_CS_ID = (String)request.getParameter("user_CS_ID");
		int consumer_ID = Integer.parseInt(request.getParameter("consumer_ID"));
		
		String store_list = "select * from store";
		String store_have = "select store.store_ID as store_ID, store_name, address, tribe, class_permit, boss from store, account where account.store_ID = store.store_ID and consumer_ID = "+consumer_ID+";";
		String store_Dhave = "(select store_ID, store_name, address, class_permit, boss, tribe FROM store) except (SELECT distinct store.store_ID, store_name, address, class_permit, boss, tribe FROM store, ACCOUNT WHERE store.store_ID = account.store_ID AND ACCOUNT.consumer_ID = "+consumer_ID+");";
		List<Object> store_ID = new ArrayList<Object>();
		List<Object> store_name = new ArrayList<Object>();
		List<Object> address = new ArrayList<Object>();
		List<Object> class_permit = new ArrayList<Object>();
		List<Object> boss = new ArrayList<Object>();
		List<Object> tribe = new ArrayList<Object>();
		
		List<Object> Hstore_ID = new ArrayList<Object>();
		List<Object> Hstore_name = new ArrayList<Object>();
		List<Object> Haddress = new ArrayList<Object>();
		List<Object> Hclass_permit = new ArrayList<Object>();
		List<Object> Hboss = new ArrayList<Object>();
		List<Object> Htribe = new ArrayList<Object>();
		
		List<Object> Nstore_ID = new ArrayList<Object>();
		List<Object> Nstore_name = new ArrayList<Object>();
		List<Object> Naddress = new ArrayList<Object>();
		List<Object> Nclass_permit = new ArrayList<Object>();
		List<Object> Nboss = new ArrayList<Object>();
		List<Object> Ntribe = new ArrayList<Object>();
		
		rs = stmt.executeQuery(store_list);
		
		List<Object> del = new ArrayList<Object>();
		List<Object> reg = new ArrayList<Object>();
		
		while(rs.next())
		{
			store_ID.add(rs.getInt("store_ID"));
			store_name.add(rs.getString("store_name"));
			address.add(rs.getString("address"));
			class_permit.add(rs.getInt("class_permit"));
			boss.add(rs.getString("boss"));
			tribe.add(rs.getString("tribe"));
			del.add(0);
			reg.add(1);
		}
		int j = 0;
		%>
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>��ü ��ȸ list(Click)</h2>
		</a><div style="DISPLAY: none">
		<%
			j = 0;
			for(int i=0; i<store_ID.size(); i++)
			{
				//System.out.println("store_ID :"+store_ID.get(i)+DFname.get(i)+DLname.get(i)+Dage.get(i)+Dtribe.get(i)+Dclass.get(i)+Dproperty.get(i)+Dmoney.get(i)+DMP.get(i)+Dnative.get(i));
				j++;
				%>
				<p>��ȸ ID :<%=store_ID.get(i) %>/��ȸ �̸� :<%=store_name.get(i) %>/�ּ� :<%=address.get(i) %>/Ŭ���� :<%=class_permit.get(i) %>/��ǥ�ڸ� :<%=boss.get(i) %>
				<%
			}
		%>
		</div>
		
		<%
		rs = stmt.executeQuery(store_have);
		
		while(rs.next())
		{
			Hstore_ID.add(rs.getInt("store_ID"));
			Hstore_name.add(rs.getString("store_name"));
			Haddress.add(rs.getString("address"));
			Hclass_permit.add(rs.getInt("class_permit"));
			Hboss.add(rs.getString("boss"));
			Htribe.add(rs.getString("tribe"));
			del.add(0);
			reg.add(1);
		}
		
		%>
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>��ϵ� ��ȸ list(��������)</h2>
		</a><div style="DISPLAY: none">
		<%
			j = 0;
			for(int i=0; i<Hstore_ID.size(); i++)
			{
				//System.out.println("store_ID :"+store_ID.get(i)+DFname.get(i)+DLname.get(i)+Dage.get(i)+Dtribe.get(i)+Dclass.get(i)+Dproperty.get(i)+Dmoney.get(i)+DMP.get(i)+Dnative.get(i));
				j++;
				%>
				<a href="ST_reg_del.jsp?consumer_ID=<%=consumer_ID %>&store_ID=<%=Hstore_ID.get(i) %>&register=<%=del.get(i) %>"> <%=j %>. ��ȸ ID :<%=Hstore_ID.get(i) %>/��ȸ �̸� :<%=Hstore_name.get(i) %>/�ּ� :<%=address.get(i) %>/Ŭ���� :<%=class_permit.get(i) %>/��ǥ�ڸ� :<%=boss.get(i) %>(�����ϱ�)</a><br>
				<%
			}
		%>
		</div>
		
		<%
		rs = stmt.executeQuery(store_Dhave);
		
		while(rs.next())
		{
			Nstore_ID.add(rs.getInt("store_ID"));
			Nstore_name.add(rs.getString("store_name"));
			Naddress.add(rs.getString("address"));
			Nclass_permit.add(rs.getInt("class_permit"));
			Nboss.add(rs.getString("boss"));
			Ntribe.add(rs.getString("tribe"));
			del.add(0);
			reg.add(1);
		}
		%>
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>��ϰ����� ��ȸ list(��ϰ���)</h2>
		</a><div style="DISPLAY: none">
		<%
			j = 0;
			for(int i=0; i<Nstore_ID.size(); i++)
			{
				j++;
				%>
				<a href="ST_reg_del.jsp?consumer_ID=<%=consumer_ID %>&store_ID=<%=Nstore_ID.get(i) %>&register=<%=reg.get(i) %>"> <%=j %>. ��ȸ ID :<%=Nstore_ID.get(i) %>/��ȸ �̸� :<%=Nstore_name.get(i) %>/�ּ� :<%=Naddress.get(i) %>/Ŭ���� :<%=Nclass_permit.get(i) %>/��ǥ�ڸ� :<%=Nboss.get(i) %>(����ϱ�)</a><br>
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