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
<title>������ �α���</title>
</head>
<body>
<%
response.setHeader("Pragma", "no-cache");//���ư��� ���� �����Ű��!!
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setDateHeader("Expires", 0L);//do not cache in proxy server
%>
	<h1>�α��� â</h1>
	<%
	try{//get ����� url�� ���, post ����� ���� ���ܼ� ������(url �� ���� X).
		
		String driver = "org.mariadb.jdbc.Driver";//connection jar ����
		String ID = (String)session.getAttribute("ID");
		Statement stmt = null;
		Connection conn = null;
		ResultSet rs = null;
		System.out.println(ID);
		
		String IDS = "select boss, user_ST_ID, store_ID, class_permit, money from store;";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/rodus";
		String dbUser = "root";
		String dbPass = "1103";
		String redirect = null;

		
		try {
			Class.forName(driver);//���
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//����
			
			stmt=conn.createStatement();
			rs = stmt.executeQuery(IDS);
			while(rs.next())
			{
				String user_ST_ID = rs.getString("user_ST_ID");
				String boss = rs.getString("boss");
				int store_ID = rs.getInt("store_ID");
				int class_permit = rs.getInt("class_permit");
				int money = rs.getInt("money");
				if(user_ST_ID != null)
				{
					if(user_ST_ID.equals(ID))
					{
						%>
						<p> <%=boss %>�� ȯ���մϴ�.</p>
						<p> ���ұ� : ������ȸ����</p> <br>
						<p> �㰡 Ŭ���� :<%=class_permit %></p>
						<p> ������ Money :<%=money %></p>
						<form action = "magician_reg_del.jsp" method = "post">
						<input type = "hidden" name = "user_ST_ID" value=<%=user_ST_ID%>>
						<input type = "hidden" name = "store_ID" value=<%=store_ID%>>
						<button type="submit">������ ���/����</button>
						</form>
						<form action = "store_material_buy.jsp" method = "post">
						<input type = "hidden" name = "store_ID" value = <%=store_ID %>>
						<input type = "hidden" name = "user_ST_ID" value = <%=user_ST_ID %>>
						<input type = "hidden" name = "store_money" value = <%=money %>>
						<button type = "submit">��� ���</button><%//������� ������ϱ�~ %>
						</form>
						<form action = "material_search.jsp" method = "get">
						<input type = "hidden" name = "store_ID" value=<%=store_ID %>>
						<input type = "hidden" name = "user_ST_ID" value=<%=user_ST_ID %>>
						<input type = "hidden" name="money" value=<%= money%>>
						<select name = "material_search">
						<option value="material_name">����̸�</option><option value="origin">������</option><option value="kind">����</option>
						</select>
						<input type="text" name="search">
						<button type = "submit">��� �˻�</button>
						</form>
						<form action = "STnotice.jsp" method = "post">
						<input type = "hidden" name = "store_ID" value = <%=store_ID %>>
						<button type = "submit">��ȸ ����</button>
						</form>
						<form action = "store_trade_info.jsp" method="post">
						<input type = "hidden" name="store_ID" value=<%=store_ID %>>
						<input type = "hidden" name="boss" value=<%=boss %>>
						<button type = "submit">�� ��ȸ�� �ŷ����� Ȯ��</button>
						</form>
						
						<%
					}
				}
				else
				{
					
				}
			}
		String url= request.getHeader("referer");//�α׾ƿ�(�Դ������� �ǵ��ư���)// ������ �Դ� URL�� �����ϰ�����%>
			<input type="submit" value="�α׾ƿ�" onclick="location.href='http://localhost:8080/1113/form.jsp'">
			<%
		}
		catch(ClassNotFoundException e)
		{
			e.printStackTrace();
		}
	}catch(NumberFormatException e)//�߸��� ���� �Ķ���ͷ� �޾����� exception e
	{%>
	<p> �ùٸ��� ���� �����Դϴ�. 
	<%
	}
		%>