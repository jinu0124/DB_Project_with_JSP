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
<title>magician_regcomplete</title>
</head>
<body>
<h4><% // ��ȸ���� �����縦 ��� ��Ű�� â //���� ���̺�� ������ ���̺� �� �� ��ȸ �̵��� �Ͽ��־�� ��
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
	
	int magician_ID = 0;
	int store_ID = 0;
	store_ID = Integer.parseInt(request.getParameter("store_ID"));
	magician_ID = Integer.parseInt(request.getParameter("magician_ID"));
	String maregister = "update magician set store_ID = "+store_ID+" where magician_ID = "+magician_ID+";";
	String magic = "update magic set store_ID = "+store_ID+" where magician_ID = "+magician_ID+"";
	%>
	STORE ID:<%=store_ID %> ��  MAGICIAN ID:<%=magician_ID %>�� ��ϵǾ����ϴ�.
	<%
	stmt.executeQuery(maregister);
	stmt.executeQuery(magic);//magic table�� store_ID foreign key �� �Բ� �ϰ��� �ְ� �ٲپ� �־���Ѵ�.
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
	}%>
<input type="button" value="���ư���" onclick="history.go(-1)">

<input type="submit" value="�α׾ƿ�" onclick="location.href='http://localhost:8080/1113/form.jsp'">
			
</h4>
</body>
</html>