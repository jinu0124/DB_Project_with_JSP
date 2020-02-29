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
<div>
	<h1>Login</h1>
	<%
	try{//get ����� url�� ���, post ����� ���� ���ܼ� ������(url �� ���� X).
		String driver = "org.mariadb.jdbc.Driver";//connection jar ����
		String ID = (String)session.getAttribute("ID");
		Statement stmt = null;
		Connection conn = null;
		ResultSet rs = null;//SQL ��� �޾ƿö� ���
		
		System.out.println(ID);
		
		String IDS = "select Fname, Lname,user_MA_ID, property from magician;";
		String magician_IDS = "select magician_ID, store_ID, class, property from magician where user_MA_ID = '"+ID+"';";
		String material_info = "select material_ID, material_name, price from material";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/rodus";
		String dbUser = "root";
		String dbPass = "1103";
		String redirect = null;
		int magician_ID=0; // 0���� �ʱ�ȭ, ���߿� ������ ����Ǿ����� üũ�Ҷ� Ȱ��
		int store_ID=0;
		String property = null;
		int classs = 0;
		String material_ID = null;
		String material_name = null;
		int price = 0;
		List<Object> material_IDlist=new ArrayList<Object>();
		List<Object> material_namelist=new ArrayList<Object>();
		List<Object> pricelist=new ArrayList<Object>();
		
		try {
			Class.forName(driver);//���
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//����
			
			stmt=conn.createStatement();
			rs = stmt.executeQuery(material_info);
			while(rs.next())
			{
				material_ID = rs.getString("material_ID");
				material_name = rs.getString("material_name");
				price = rs.getInt("price");
				material_IDlist.add(material_ID);
				material_namelist.add(material_name);
				pricelist.add(price);
			}
			System.out.println(material_IDlist);
			
			rs = stmt.executeQuery(magician_IDS);
			
			while(rs.next())
			{
				magician_ID = rs.getInt("magician_ID");
				classs = rs.getInt("class");
				property = rs.getString("property");
				store_ID = rs.getInt("store_ID");
				
			}
			if(magician_ID == 0)// �޾ƿ� magician_ID�� ������ �� ������ ����Ǿ �������� ���� ���̹Ƿ� �߸��� ���� ǥ���ϱ�
			{
					%><p> �߸��� �����Դϴ�.</p>
			<%}
			System.out.println("ID : "+magician_ID+store_ID);
			
			rs = stmt.executeQuery(IDS);
			
			while(rs.next())//SQL ���� ���ؼ� �α����� ����� ������ �޾ƿͼ� �α����� ȯ�� �� �ǵ��ư��� ��ư
			{
				String user_MA_ID = rs.getString("user_MA_ID");
				String Fname = rs.getString("Fname");
				String Lname = rs.getString("Lname");
				int count = 0;
				if(user_MA_ID != null)
				{
					if(user_MA_ID.equals(ID))
					{
						session.setAttribute("user_MA_ID", user_MA_ID);
						%>
						<form action="createMA.jsp" method="get">
						<input type="hidden" name="magician_ID" value=<%=magician_ID %>>
						<input type="submit" value="â���� ���� Ȯ���ϱ�" onclick="createMA.jsp">
						</form>
						<p> <%=Fname %><%=Lname %> �� ȯ���մϴ�.</p>
						<p> ���ұ� : ������          class : <%=classs %><br>
						<p> �Ӽ� : <%=property %>
						<form action = "material_reg.jsp" method = "post">
						</div>
						<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
						<h2>���� ��� ����ϱ�(Click)</h2>
						</a><div style="DISPLAY: none">
						<input type="hidden" name="user_MA_ID" value=<%=user_MA_ID %>>
						MATERIAL NAME :<input type="text" name="material_name" required = ""><br>
						ORIGIN :<input type="text" name="origin" required = ""><br>
						KIND :<input type="text" name="kind" required = ""><br>
						PRICE :<input type="number" name="price" min="1" value="100" required = ""><br>
						<input type="submit" value="������ �����"> <br>
						</div>
						<br>
						</form>
						
						
						<form action = "magic_reg.jsp" method = "post">
						<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
						<h2>���� ����ϱ�(click)</h2>
						</a><div style="DISPLAY: none">
						<input type="hidden" name="user_MA_ID" value=<%=user_MA_ID %>><br>
						MAGIC NAME :<input type="text" name="magic_name" required = ""><br>
						<label> CLASS </label>
						<select name="class">
						<option>1</option> <option>2</option> <option>3</option>
						<option>4</option> <option>5</option> <option>6</option>
						<option>7</option> <option>8</option> <option>9</option> <option>10</option>
						</select><br>
						PROPERTY : <%=property %><input type="hidden" name="property" value=<%=property %>><br>
						SALE PRICE :<input type="number" name="sale_price" min="1" value="100"><br>
						MAGICIAN ID : <%=magician_ID %><input type="hidden" name="magician_ID" value=<%=magician_ID %>><br>
						STORE ID : <%=store_ID %><input type="hidden" name="store_ID" value=<%=store_ID %>><br>
						MAGIC Expression :<input type="text" name="magic_exp" required = ""><br>
						<label> MAGIC KIND </label>
						<select name="kind">
						<option>UTIL</option> <option>DEFENSE</option> <option>ATTACK</option>
						</select><br>
						EFFECT :<input type="number" name="effect" value="1" required = ""><br>
						MP_consume :<input type="number" name="MP_consume" required = ""><br>
						<label> �ʿ��� ��� �� ���� </label>
						<select name="material_namelist1">
						<%int a = 0;
						for(int i=0; i<material_namelist.size(); i++)
							{
								%><option><%=material_namelist.get(i) %></option>
								<%
								a = i;
							}%></select>
						<input type="number" name="material_cnt1" value="0" min="1"><br>
						<label> �ʿ��� ��� �� ���� </label>
						<select name="material_namelist2">
						<%for(int i=1; i<material_namelist.size()+1; i++)
							{
								if(i < material_namelist.size())
								{
								%><option><%=material_namelist.get(i) %></option>
								<%
								}
								else{
									%><option><%=material_namelist.get(0) %></option><%
								}
							}%></select>
						<input type="number" name="material_cnt2" value="0" min="0"><br>
						<label> �ʿ��� ��� �� ���� </label>
						<select name="material_namelist3">
						<%for(int i=material_namelist.size()-1; i>=0; i--)
							{
								%><option><%=material_namelist.get(i) %></option>
								<%
							}%></select>
						<input type="number" name="material_cnt3" value="0" min="0"><br>
						
						<input type="submit" value="���� ���"><br>
						</form>
						<form action="magic_reg.jsp" method ="post">
						<%
							Integer duplerr = null;
							duplerr = (Integer)session.getAttribute("duplerr");
							if(duplerr != null)
							{
								count = (Integer)session.getAttribute("count");
								if(count==1){
									JOptionPane.showMessageDialog(null,"�ߺ����� ��Ḧ �������� �����ּ���.\nEx)ICE, ICE)");//ùȭ����� �ߴ°� ��ġ�� ������ȣ �߸��Է� ��
								}
							}%>
						</div>
						</form>
						
						<form action = "magic_trade_info.jsp" method = "post">
						<input type = "hidden" name = "magician_ID" value=<%=magician_ID %>>
						<input type = "hidden" name = "Fname" value=<%=Fname %>>
						<input type = "hidden" name = "Lname" value=<%=Lname %>>
						<input type = "hidden" name = "property" value=<%=property %>>
						<button type = "submit">�� ���� �ŷ����� Ȯ��</button>
						</form>
						<br>
						<%
					}
				}
			}
			System.out.println("magician_ID :"+magician_ID);
			%>
			</form>
			<form action = "MAnotice.jsp" method="post">
			<input type ="hidden" name= "magician_ID" value=<%=magician_ID %>>
			<button type="submit">���� ���� Ȯ��/����</button>
			</form>
		<form action = "form.jsp" method = "get">
			<% magician_ID = 0;%>
			<input type="hidden" name="expire" value=<%=magician_ID %>>
			<input type="submit" value="�α׾ƿ�" onclick="location.href='http://localhost:8080/1113/form.jsp'">
			<br>
			</form>
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
		
</body>

		