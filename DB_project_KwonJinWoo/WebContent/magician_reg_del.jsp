<%@page import="java.util.function.Function"%>
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
<title>magician_reg_del</title>
</head>
<body><% // ��ȸ���� ������ ���, ����, �˻��� �� �� �ִ� â
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
		
		List<Object> magician_ID = new ArrayList<Object>();
		List<Object> Fname = new ArrayList<Object>();
		List<Object> Lname = new ArrayList<Object>();
		List<Object> MAproperty = new ArrayList<Object>();
		List<Object> MAclass = new ArrayList<Object>();//int��
		List<Object> MAtribe = new ArrayList<Object>();
		List<Object> STtribe = new ArrayList<Object>();
		
		List<Object> Amagician_ID = new ArrayList<Object>();
		List<Object> AFname = new ArrayList<Object>();
		List<Object> ALname = new ArrayList<Object>();
		List<Object> AMAproperty = new ArrayList<Object>();
		List<Object> AMAclass = new ArrayList<Object>();//int��
		List<Object> AMAtribe = new ArrayList<Object>();
		List<Object> ASTtribe = new ArrayList<Object>();
		List<Object> MAstore_ID = new ArrayList<Object>();
		List<Object> MAstore_name = new ArrayList<Object>();
		
		
		List<Object> Dmagician_ID = new ArrayList<Object>();
		List<Object> DFname = new ArrayList<Object>();
		List<Object> DLname = new ArrayList<Object>();
		List<Object> Dage = new ArrayList<Object>();
		List<Object> Dproperty = new ArrayList<Object>();
		List<Object> Dclass = new ArrayList<Object>();
		List<Object> Dtribe = new ArrayList<Object>();
		List<Object> Dmoney = new ArrayList<Object>();
		
		stmt=conn.createStatement();
		String user_ST_ID = (String)request.getParameter("user_ST_ID");
		int store_ID = Integer.parseInt(request.getParameter("store_ID"));
		String magicianlistQ = "select magician_ID, Fname, Lname, property, class, tribe, store_ID from magician;";
		String magician_regableQ = "select magician_ID, Fname, Lname, magician.property, class, magician.tribe, store.tribe as STtribe from magician, store where magician.store_ID <> store.store_ID and user_ST_ID = '"+user_ST_ID+"' and class_permit >= magician.class or magician.store_ID is null and class_permit >= magician.class and user_ST_ID = '"+user_ST_ID+"' ORDER BY magician.class desc;";
		String magician_delQ = "select magician_ID, Fname, Lname, age, property, class, tribe, money from magician where Store_ID = "+store_ID+"";
		//��ϰ����� �����縦 �� list ����� ���� Query(class �� + �̹� ��ϵ� ������ ���� + class ���� �������� �޾ƿ���), store.tribe �޾ƿͼ� �� 
		
		rs = stmt.executeQuery(magician_regableQ);//��� ������ ������ ���
		while(rs.next())
		{
			magician_ID.add(rs.getInt("magician_ID"));
			Fname.add(rs.getString("Fname"));
			Lname.add(rs.getString("Lname"));
			MAproperty.add(rs.getString("magician.property"));
			MAclass.add(rs.getInt("magician.class"));
			MAtribe.add(rs.getString("magician.tribe"));
			STtribe.add(rs.getString("STtribe"));
			
		}
		rs = stmt.executeQuery(magicianlistQ);//��� ������ list
		int p = 0;
		
		while(rs.next())
		{
			Amagician_ID.add(rs.getInt("magician_ID"));
			AFname.add(rs.getString("Fname"));
			ALname.add(rs.getString("Lname"));
			AMAproperty.add(rs.getString("property"));
			AMAclass.add(rs.getInt("class"));
			AMAtribe.add(rs.getString("tribe"));
			MAstore_ID.add(rs.getInt("store_ID"));//as�� attribute�̸��� �����Ͽ� �޾ƿ�
			if(MAstore_ID.get(p) == null)
			{
				MAstore_ID.add(p, 0);
			}
			p++;
			//MAstore_name.add(rs.getString("store_name"));
		}
		int j = 0;
		System.out.println("store_ID :"+MAstore_ID);
		
		rs = stmt.executeQuery(magician_delQ);//�Ҽӵ� ������ list�ޱ�
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
		}
		
		%>
		<form action = "magician_search.jsp" method  = "post">
		<input type = "hidden" name = "store_ID" value=<%=store_ID %>>
		<select name = "search_kind">
		<option value="magician_name">�����̸�</option><option value="tribe">����</option><option value="class">Ŭ����</option><option value="property">�Ӽ�</option>
		</select>
		<input type="text" name="search">
		<button type = "submit">������ �˻�</button>
		</form>
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>��ü ������ LIST(Click)</h2>
		</a><div style="DISPLAY: none">
		<%
			for(int i=0; i<Amagician_ID.size(); i++)
			{
				j++;
				%>
				<a href="magician_info.jsp?store_ID=<%=MAstore_ID.get(i) %>"> <%=j %>. ������ID :<%=Amagician_ID.get(i) %>/�̸�(��) :<%=AFname.get(i) %>/�̸� :<%=ALname.get(i) %>/�Ӽ� :<%=AMAproperty.get(i) %>/���� :<%=AMAtribe.get(i) %>/�Ҽ� ���� :<%=MAstore_ID.get(i) %>/Ŭ����:<%=AMAclass.get(i) %></a><br>
			<%
			}
		%>
		</div>
		
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>��� ������ ������ list(Click)</h2>
		</a><div style="DISPLAY: none">
		<%
			j = 0;
			for(int i=0; i<magician_ID.size(); i++)
			{
				j++;
				%>
				<a href="magician_regcomplete.jsp?magician_ID=<%=magician_ID.get(i) %>&store_ID=<%=store_ID %>"> <%=j %>. ������ID :<%=magician_ID.get(i) %>/Ŭ���� :<%=MAclass.get(i) %>/�̸�(��) :<%=Fname.get(i) %>/�̸� :<%=Lname.get(i) %>/�Ӽ� :<%=MAproperty.get(i) %>/���� :<%=MAtribe.get(i) %> (����ϱ�)</a><br>
			<%
			}
		%>
		
		</div>
		
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>������ ������ list(��������)(Click)</h2>
		</a><div style="DISPLAY: none">
		<%
			j = 0;
			for(int i=0; i<Dmagician_ID.size(); i++)
			{
				j++;
				%>
				<a href="magician_delcomplete.jsp?magician_ID=<%=Dmagician_ID.get(i) %>&store_ID=<%=store_ID %>"> <%=j %>. ������ID :<%=Dmagician_ID.get(i) %>/���� :<%=Dage.get(i) %>/Ŭ���� :<%=Dclass.get(i) %>/�̸�(��) :<%=DFname.get(i) %>/�̸� :<%=DLname.get(i) %>/�Ӽ� :<%=Dproperty.get(i) %>/���� :<%=Dtribe.get(i) %>/ �ڱ� :<%=Dmoney.get(i) %> (�����ϱ�)</a><br>
			<%
			}
		%>
		
		
		</div>
		<input type="button" value="���ư���" onclick="location.href='<%=url %>'">
		
		<input type="submit" value="�α׾ƿ�" onclick="location.href='http://localhost:8080/1113/form.jsp'">
			
		<%
		//magician_ID = Integer.parseInt(request.getParameter("magician_ID"));
		//magic_ID = Integer.parseInt(request.getParameter("magic_ID"));
		
		//System.out.println("here :"+magician_ID+magic_ID);
		
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
<SCRIPT LANGUAGE='JAVASCRIPT'>
	function test0(){
		a = document.getElementById("k").value;
		alert("0");
	}
</SCRIPT>
</body>
</html>