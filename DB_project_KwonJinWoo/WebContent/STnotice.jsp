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
<title>ST_notice</title>
</head>
<body><% // ��ȸ�� ���� Ȯ�� �� �����ϱ� ���� â
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
		int store_ID = Integer.parseInt(request.getParameter("store_ID"));
		
		String store_info = "select store_ID, store_name, address, boss, tribe, user_ST_ID, des_decrypt(user_pw) as user_pw, class_permit, money from store where store_ID = "+store_ID+"";
		String magician_have = "select magician_ID, Fname, Lname, age, property, class, tribe, money, MP, native from magician where Store_ID = "+store_ID+"";
		//���� ������ list ����
		String material_have = "select material_have.material_ID as material_ID, material_cnt, material_name from material_have, material where material_have.material_ID = material.material_ID and store_ID = "+store_ID+"";
		//������ material ID, count, name 
		
		//magician_ID = Integer.parseInt(request.getParameter("magician_ID"));
		//magic_ID = Integer.parseInt(request.getParameter("magic_ID"));
		rs = stmt.executeQuery(store_info);
		String store_name = null;
		String address = null;
		String boss = null;
		String tribe = null;
		String user_ST_ID = null;
		String user_pw = null;
		int class_permit = 0;
		int money = 0;
		
		//���� ��� list
		List<Object> material_ID = new ArrayList<Object>();
		List<Object> material_cnt = new ArrayList<Object>();
		List<Object> material_name = new ArrayList<Object>();
		
		//������ ������ list
		List<Object> Dmagician_ID = new ArrayList<Object>();
		List<Object> DFname = new ArrayList<Object>();
		List<Object> DLname = new ArrayList<Object>();
		List<Object> Dage = new ArrayList<Object>();
		List<Object> Dproperty = new ArrayList<Object>();
		List<Object> Dclass = new ArrayList<Object>();
		List<Object> Dtribe = new ArrayList<Object>();
		List<Object> Dmoney = new ArrayList<Object>();
		List<Object> DMP = new ArrayList<Object>();
		List<Object> Dnative = new ArrayList<Object>();
		
		while(rs.next())
		{
			store_name = rs.getString("store_name");
			address = rs.getString("address");
			boss = rs.getString("boss");
			tribe = rs.getString("tribe");
			user_ST_ID = rs.getString("user_ST_ID");
			user_pw = rs.getString("user_pw");
			class_permit = rs.getInt("class_permit");
			money = rs.getInt("money");
		}
		//System.out.println("here :"+magician_ID+magic_ID);
		String addressQ = "(select distinct address from store)union(select distinct native from magician)union(select distinct address from consumer);";
		//��� �Ӽ��̸��� address�� �޾ƿ��� union�� �̿��Ͽ� ��� ������ ������
		List<Object> Alladdress = new ArrayList<Object>();
		rs = stmt.executeQuery(addressQ);
		while(rs.next())
		{
			Alladdress.add(rs.getString("address"));
		}
		int addressnumber = 0;
		for(int t=0; t<Alladdress.size(); t++)
		{
			if(address.equals(Alladdress.get(t)))
				addressnumber = t;
		}
		int n = 0;
		%>
		<form action = "ST_info_mod.jsp" method = post">
		<h4> ��ȸ ���� </h4>
		��ȸ �߱� ID : <%=store_ID %><br>
		<input type = "hidden" name = "store_ID" value = <%=store_ID %>>
		<p> ��ȸ�� : <%=store_name %><input type = "text" name = "store_name" value = <%=store_name %>>(���� ����)<br>
		 �ּ� : <%=address %>  <select name="address">
		<%for(int k=addressnumber; k<Alladdress.size()+addressnumber; k++)
		{
			if(k < Alladdress.size())
				{
				%><option><%=Alladdress.get(k) %></option>
				<%}
			else
			{
				n = k-Alladdress.size();
			%><option><%=Alladdress.get(n) %></option><%}
		}
		%></select><br> 
		 ��ǥ�ڸ� : <%=boss %> <input type = "text" name = "boss" value = <%=boss %>>(���� ����)<br> 
		 ���� : <%=tribe %> <input type = "hidden" name = "tribe" value = <%=tribe %>><br> 
		 �㰡Ŭ���� : <%=class_permit %> 
		 <select name="class_permit">
			<%for(int p=class_permit; p<=10; p++)
			{
				%><option><%=p %></option> <%
			}
			%>(��� ��¸� ����)
			</select><br> 
		 �ڱ� : <%=money %> <input type = "hidden" name = "money" value = <%=money %>><br> 
		 �����ID : <%=user_ST_ID %> <input type = "text" name = "user_ST_ID" value = <%=user_ST_ID %>>(���� ����)<br> 
		 ����� PW : <input type = "text" name = "user_pw" value = <%=user_pw %>>(���� ����)<br></p>
		<input type = "submit" value = "���������ϱ�">
		</form>
		<%
		rs = stmt.executeQuery(magician_have);//�Ҽӵ� ������ list�ޱ�
		while(rs.next())//magician_ID, Fname, Lname, age, property, class, tribe, money
		{
			Dmagician_ID.add(rs.getInt("magician_ID"));
			DFname.add(rs.getString("Fname"));
			DLname.add(rs.getString("Lname"));
			Dage.add(rs.getInt("age"));
			Dproperty.add(rs.getString("property"));
			Dclass.add(rs.getInt("class"));
			Dtribe.add(rs.getString("tribe"));
			Dmoney.add(rs.getInt("money"));
			DMP.add(rs.getInt("MP"));
			Dnative.add(rs.getString("native"));
		}
		int j;
		%>
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>��ȸ�� ������ ������ list(Click)</h2>
		</a><div style="DISPLAY: none">
		<%
			j = 0;
			for(int i=0; i<Dmagician_ID.size(); i++)
			{
				System.out.println("magician_ST :"+Dmagician_ID.get(i)+DFname.get(i)+DLname.get(i)+Dage.get(i)+Dtribe.get(i)+Dclass.get(i)+Dproperty.get(i)+Dmoney.get(i)+DMP.get(i)+Dnative.get(i));
				j++;
				%>
				<a href="magician_ST_info.jsp?magician_ID=<%=Dmagician_ID.get(i) %>&property=<%=Dproperty.get(i) %>&tribe=<%=Dtribe.get(i) %>&age=<%=Dage.get(i) %>&class=<%=Dclass.get(i) %>&Fname=<%=DFname.get(i) %>&Lname=<%=DLname.get(i) %>"> <%=j %>. ������ID :<%=Dmagician_ID.get(i) %>/�̸�(��) :<%=DFname.get(i) %>/�̸� :<%=DLname.get(i) %>(��������)</a><br>
			<%
			}
		%>
		</div>
		
		<%
		rs = stmt.executeQuery(material_have);
		while(rs.next())
		{
			material_ID.add(rs.getInt("material_ID"));
			material_cnt.add(rs.getInt("material_cnt"));
			material_name.add(rs.getString("material_name"));
		}
		
		%>
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>��ȸ�� ������ ��� list(Click)</h2>
		</a><div style="DISPLAY: none">
		<%
			j = 0;
			for(int i=0; i<material_ID.size(); i++)
			{
				System.out.println("material_ID :"+material_ID.get(i)+material_name.get(i)+material_cnt.get(i));
				j++;
				%>
				<a href="material_ST_info.jsp?material_ID=<%=material_ID.get(i) %>"> <%=j %>. ��� ID :<%=material_ID.get(i) %>/��� ���� :<%=material_cnt.get(i) %>/����̸� :<%=material_name.get(i) %>(����������)</a><br>
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