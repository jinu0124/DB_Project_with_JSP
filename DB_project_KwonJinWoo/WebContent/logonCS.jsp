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
<title>LogonCS</title>
</head>
<body>
	<h1>�α��� �Ǿ����ϴ�.</h1>
	<%
	try{//get ����� url�� ���, post ����� ���� ���ܼ� ������(url �� ���� X).
		
		String driver = "org.mariadb.jdbc.Driver";//connection jar ����
		String ID = (String)session.getAttribute("ID");
		Statement stmt = null;
		Connection conn = null;
		ResultSet rs = null;
		

		System.out.println(ID);
		
		
		String IDS = "select Fname, Lname,user_CS_ID,age, property, money, consumer_ID from consumer;";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/rodus";
		String dbUser = "root";
		String dbPass = "1103";
		String redirect = null;

		
		try {
			Class.forName(driver);//���
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//����
			
			stmt=conn.createStatement();
			
			List<Object> Hstore_ID = new ArrayList<Object>();
			List<Object> Hstore_name = new ArrayList<Object>();
			List<Object> Haddress = new ArrayList<Object>();
			List<Object> Hclass_permit = new ArrayList<Object>();
			List<Object> Hboss = new ArrayList<Object>();
			List<Object> Htribe = new ArrayList<Object>();
			int consumer_ID = 0;
			int money1 = 0;
			
			rs = stmt.executeQuery(IDS);
			while(rs.next())
			{
				String user_CS_ID = rs.getString("user_CS_ID");
				String Fname = rs.getString("Fname");//
				String Lname = rs.getString("Lname");//
				int age = rs.getInt("age");
				int money = rs.getInt("money");
				String property = rs.getString("property");//
				consumer_ID = rs.getInt("consumer_ID");
				
				
				int j = 0;
				
				if(user_CS_ID != null)
				{
					if(user_CS_ID.equals(ID))
					{
						money1 = money;
						%>
						<p> <%=Fname %><%=Lname %> �� ȯ���մϴ�.</p>
						<p> ���ұ� : �Һ���</p>
						<p> �ڱ� : <%=money %></p>
						<p> ���� : <%=age %></p>
						<p> �Ӽ� : <%=property %></p>
						<form action = "CS_ST_reg.jsp" method = "post">
						<input type = "hidden" name = "user_CS_ID" value=<%=user_CS_ID%>>
						<input type = "hidden" name = "consumer_ID" value=<%=consumer_ID%>>
						<button type="submit">�ŷ���ȸ ���/����</button>
						</form>
						<form action = "store_search.jsp" method = "post">
						<input type = "hidden" name = "consumer_ID" value=<%=consumer_ID %>>
						<select name = "search_kind">
						<option value="store_name">��ȣ��</option><option value="boss">��ǥ�ڸ�</option><option value="class_permit">�㰡Ŭ����</option>
						</select>
						<input type="text" name="search">
						<button type = "submit">��ȸ �˻�</button>
						</form>
						
						<%
						System.out.println("consumer_ID :"+consumer_ID);
						String store_have = "select store.store_ID as store_ID, store_name, address, tribe, class_permit, boss from store, account where account.store_ID = store.store_ID and consumer_ID = "+consumer_ID+";";

						rs = stmt.executeQuery(store_have);
						
						while(rs.next())
						{
							Hstore_ID.add(rs.getInt("store_ID"));
							Hstore_name.add(rs.getString("store_name"));
							Haddress.add(rs.getString("address"));
							Hclass_permit.add(rs.getInt("class_permit"));
							Hboss.add(rs.getString("boss"));
							Htribe.add(rs.getString("tribe"));
						}
						System.out.println("Hstore_ID list :"+Hstore_ID);
						%>
						
						<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
						<h4> ��ȸ list(���, �������� ����)</h4>
						</a><div style="DISPLAY: none">
						<%
							j = 0;
							for(int i=0; i<Hstore_ID.size(); i++)
							{
								j++;
								%>
								<a href="ST_buy.jsp?consumer_ID=<%=consumer_ID %>&store_ID=<%=Hstore_ID.get(i) %>&money=<%=money1 %>&property=<%=property %>"> <%=j %>. ��ȸ ID :<%=Hstore_ID.get(i) %>/��ȸ �̸� :<%=Hstore_name.get(i) %>/�ּ� :<%=Haddress.get(i) %>/Ŭ���� :<%=Hclass_permit.get(i) %>/��ǥ�ڸ� :<%=Hboss.get(i) %>(����)</a><br>
								<%
							}
						%>
						</div>
						<form action = "CS_info.jsp" method = "post">
						<input type = "hidden" name = "consumer_ID" value = <%=consumer_ID %>>
						<button type = "submit">ȸ�� ���� Ȯ��/����</button>
						</form>
						
						<form action = "CS_trade_info.jsp" method = "post">
						<input type = "hidden" name = "consumer_ID" value = <%=consumer_ID %>>
						<input type = "hidden" name = "Fname" value = <%=Fname %>>
						<input type = "hidden" name = "Lname" value = <%=Lname %>>
						<button type = "submit">�� �ŷ� ���� Ȯ��</button>
						</form>
						<%
					}
				}
				else
				{
					
				}
			}
			
			
		String url= request.getHeader("referer");//�α׾ƿ�(�Դ������� �ǵ��ư���)// ������ �Դ� URL�� �����ϰ�����%>
			<input type="button" value="�α׾ƿ�" onclick="location.href='<%=url %>'">
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
		