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
<title>����â��</title>
</head>
<body>
<form>
<%//�����簡 ������ â���ϴ� â
	String driver = "org.mariadb.jdbc.Driver";//connection jar ����
	String ID = (String)session.getAttribute("ID");
	Statement stmt = null;
	Connection conn = null;
	ResultSet rs = null;//SQL ��� �޾ƿö� ���
	
	String jdbcDriver = "jdbc:mariadb://localhost:3306/rodus";
	String dbUser = "root";
	String dbPass = "1103";
	String redirect = null;
	int user_MA_ID =0;
	user_MA_ID = Integer.parseInt(request.getParameter("magician_ID"));//magician_ID�� �޾ƿͼ� â���� ���� �˾Ƴ���
	String create_list = "Select magic_name, magic_ID, class, property, sale_price from magic where magician_ID = '"+user_MA_ID+"'";
	
	List<Object> magic_namelist=new ArrayList<Object>();
	List<Object> propertylist=new ArrayList<Object>();//�迭 ����Ʈ �ʱ�ȭ �ϱ�
	List<Object> classlist=new ArrayList<Object>();
	List<Object> magic_IDlist=new ArrayList<Object>();//���� �迭 �����
	List<Object> sale_pricelist=new ArrayList<Object>();
	
	try {
		Class.forName(driver);//���
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//����
		
		stmt=conn.createStatement();
		rs = stmt.executeQuery(create_list);
		String magic_name;
		String property;
		int magic_ID = 0;
		int classs = 0;
		int i = 0;
		int sale_price = 0;
		while(rs.next())
		{
			magic_name = rs.getString("magic_name");
			property = rs.getString("property");
			magic_ID = rs.getInt("magic_ID");
			classs = rs.getInt("class");
			sale_price = rs.getInt("sale_price");
			magic_namelist.add(magic_name);//�迭 ����Ʈ�� �ϳ��� ���
			propertylist.add(property);
			magic_IDlist.add(magic_ID);//���� �迭����Ʈ�� �ϳ��� ���
			classlist.add(classs);
			sale_pricelist.add(sale_price);
			i++;//<a onclick �� ��ġ�� ���⸦ ���� ���
		}
		if(user_MA_ID == 0)// �޾ƿ� magician_ID�� �������� �� ������ ����Ǿ �������� ���� ���̹Ƿ� �߸��� ���� ǥ���ϱ�
			{
			%><p> �߸��� �����Դϴ�.</p>
			
		<%}%>
		</form>
		
		
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>â���� ���� list(Click) <- �������</h2>
		</a><div style="DISPLAY: none">
		<form action = "changeMG.jsp" method = "post">
		<%
		System.out.println("magic_IDlist, magician_ID :"+magic_IDlist+user_MA_ID);
		for(int j=0; j<magic_namelist.size(); j++)
		{
			magic_ID = (Integer)magic_IDlist.get(j);
			System.out.println("magic_ID"+magic_ID);
			i=j+1;
			%>
			<a href="changeMG.jsp?magic_ID=<%=magic_ID %>&magician_ID=<%=user_MA_ID %>"><%=i %>. ����ID :<%=magic_IDlist.get(j) %>/Ŭ���� :<%=classlist.get(j) %>/�ǸŰ��� :<%=sale_pricelist.get(j) %>/�Ӽ� :<%=propertylist.get(j) %>/���� �̸� :<%=magic_namelist.get(j) %></a><br>
			<%}
		%></form></div>
		<br>
			<h2>���� �˻��ϱ�(����ID, �����̸�, Class)</h2><br>
			<p>(���� ���� ������ ��)</p>
			<div>
			<form action="searchMA.jsp" method="post">
			<input type="text" name="search" placeholder="�˻��� �Է�">
			<%
			session.setAttribute("magic_IDlist", magic_IDlist);//���ڹ迭 ������
			session.setAttribute("magic_namelist", magic_namelist);
			session.setAttribute("classlist", classlist);
			%>
			<input type="submit" value="�˻�">
			<br>
			</form>
			<div>
		<input type="button" value="���ư���" onclick="history.go(-1)">
		</div>
		<form action = "form.jsp" method = "get">
			<input type="submit" value="�α׾ƿ�" onclick="location.href='http://localhost:8080/1113/form.jsp'">
			<br>
			</form>
			
			</div>
			
			
			<%
		
}catch(NumberFormatException e)
{
	e.printStackTrace();
}
	catch(SQLException se)
	{
		se.printStackTrace();
}finally{
		try{
		}catch (Exception e2){
		}
	}
	%>
</body>
</html>