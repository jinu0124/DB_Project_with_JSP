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
<title>change magic</title>
</head>
<body><% // �����簡 ������ �����ϱ� ���� â
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

		int magician_ID = 0;
		int magic_ID = 0;
		int magician_class = 0;
		String property = null;
		
		int classs = 0;
		int sale_price =0;
		String magic_name = null;
		String magic_exp = null;
		String kind = null;
		int effect = 0;
		int MP_consume = 0;
		
		magician_ID = Integer.parseInt(request.getParameter("magician_ID"));
		magic_ID = Integer.parseInt(request.getParameter("magic_ID"));
		
		System.out.println("���° ���� ID���� :"+magic_ID);
		String magicianQ = "select class, property from magician where magician_ID = "+magician_ID+";";
		String magicQ = "select class, sale_price, magic_detail.magic_name, magic_exp, kind, effect, MP_consume from magic, magic_detail where magic.magic_name = magic_detail.magic_name and magic_ID = "+magic_ID+";";
		
		rs = stmt.executeQuery(magicianQ);
		while(rs.next())
		{
			magician_class = rs.getInt("class");
			property = rs.getString("property");
		}
		rs = stmt.executeQuery(magicQ);
		while(rs.next())
		{
			classs = rs.getInt("class");
			sale_price = rs.getInt("sale_price");
			magic_name = rs.getString("magic_detail.magic_name");
			magic_exp = rs.getString("magic_exp");
			kind = rs.getString("kind");
			effect = rs.getInt("effect");
			MP_consume = rs.getInt("MP_consume");
		}
		
		System.out.println("here :"+magician_class+property+classs+sale_price+magic_name+magic_exp+kind+effect+MP_consume);
		System.out.println("class , property"+magician_class+property);
		%>
		<form action="changeMGdone.jsp" method="post">
			<%session.setAttribute("magic_ID", magic_ID);//session.setAttribute�� �̿��Ͽ��� form submit�Ҷ� ���� session������ �Ѱ���
			session.setAttribute("originMA_name", magic_name);%>
			Magic ID :<%=magic_ID %><br>
			<label>Ŭ����(<%=magician_class %>���� ���ƾ���)</label>
			<select name="class">
			<%for(int j=1; j<=magician_class; j++)
			{
				%><option><%=j %></option> <%
			}
			%>
			</select><br>
			Magic Name :<input type="text" name = "magic_name" value = <%=magic_name %> required = ""><br>
			Magic_Exression :<input type="text" name = "magic_exp" value = <%=magic_exp %>required = ""><br>
			SALE PRICE :<input type="number" name = "sale_price" min = "0" max = "999999" value = <%=sale_price %> required=""><br>
			<label>����</label>
			<select name="kind" value = <%=kind %>>
			<option>DEFFENSE</option> <option>ATTACK</option> <option>HEAL</option>
			</select><br>
			EFFECT :<input type="number" name="effect" min = "0" max = "99999" value = <%=effect %> required=""><br>
			MP_consume :<input type="number" name="MP_consume" min = "0" max = "5000" value = <%=MP_consume %> required=""><br>
			PROPERTY :<%=property %> (����� �� ����)<br>
			<button type="submit">�����ϱ�</button>
			<input type="button" value="���ư���" onclick="history.go(-1)">
		</form>
		<%
		
	//	String magicupdateQ = "update magic set class="+classs+", sale_price="+price+" where magic_ID = '"+magic_ID+"';";
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