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
<title>Login</title>
</head>
<body>
	<h1>�α��� â</h1>
	<%	String url= request.getHeader("referer"); %> 
	<%//�α��� �� ������ �޾Ƽ� ID ��ġ���� Ȥ�� ID ���翩�� Ȯ�� �� ���� �����ְų� ���� �� �� ���ұ��� �´� �α��� â���� �Ѱ��ֱ�
	try{//get ����� url�� ���, post ����� ���� ���ܼ� ������(url �� ���� X).// �α��� âSQL���� ���ؼ� ������, �Һ���, �������� ID�� �޾ƿͼ� ���翩�� ����, ��й�ȣ�� ��ġ�ϸ�
		// �α��� â���� �Ѿ -> ��й�ȣ Ʋ���� ��й�ȣ ����â����, ID�� �������� ������ ��
		
		String driver = "org.mariadb.jdbc.Driver";//connection jar ����
		
		Statement stmt = null;
		Connection conn = null;
		ResultSet rs = null;
		
		String csID;
		String csPW;
		String maID;
		String maPW;
		String stID;
		String stPW;
		
		String jdbcDriver = "jdbc:mariadb://localhost:3306/rodus";
		String dbUser = "root";
		String dbPass = "1103";
		String redirect = null;
		try {
			Class.forName(driver);//���
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//����
		}
		catch(ClassNotFoundException e)
		{
			e.printStackTrace();
		}
		
		String ID = request.getParameter("ID");//request�� ��Ŭ�������� �����Ǵ� �Լ�
		String PW = request.getParameter("PW");//request�� ��Ŭ�������� �����Ǵ� �Լ�
		//String insert = request.getParameter("register");
	
		
		System.out.println("login :"+ID);
		
		stmt=conn.createStatement();
		//pw�� ��ȣȭ�ؼ� ����
		String compareID1 = "select user_CS_ID, des_decrypt(user_pw) as user_pw from consumer;";
		String compareID2 = "select user_MA_ID, des_decrypt(user_pw) as user_pw from magician;";
		String compareID3 = "select user_ST_ID, des_decrypt(user_pw) as user_pw from store;";
		//PreparedStatement preStmt = conn.prepareStatement(compareID);
		//String IDS = stmt.executeQuery(compareID).getString("IDS");
		//stmt = conn.prepareStatement(compareID);
		//preStmt.setString(1, compareID);
		rs = stmt.executeQuery(compareID1);
		int count = 0;
		while(rs.next()){
			csID = rs.getString("user_CS_ID");//
			csPW = rs.getString("user_pw");
			if(ID.equals(csID) && PW.equals(csPW))
			{
				session.setAttribute("ID", ID);
				redirect = "logonCS.jsp";
			}
			else if(ID.equals(csID) && !PW.equals(csPW))
			{
				%><p> �߸��� ��й�ȣ�Դϴ�.<%
				count++;
			}
			else{
				
			}
		}
		
		rs = stmt.executeQuery(compareID2);
		while(rs.next()){
			maID = rs.getString("user_MA_ID");//
			maPW = rs.getString("user_pw");
			if(ID.equals(maID) && PW.equals(maPW))
			{
				session.setAttribute("ID", ID);
				redirect = "logonMA.jsp";
			}
			else if(ID.equals(maID) && !PW.equals(maPW))
			{
				%><p> �߸��� ��й�ȣ�Դϴ�.<%
				count++;
			}
			else{
				
			}
		}
		
		rs = stmt.executeQuery(compareID3);
		while(rs.next()){
			stID = rs.getString("user_ST_ID");//
			stPW = rs.getString("user_pw");
			if(ID.equals(stID) && PW.equals(stPW))
			{
				session.setAttribute("ID", ID);//ID�� unique�� ���̹Ƿ� ID�� �Ѱܵ� ��
				redirect = "logonST.jsp";
			}
			else if(ID.equals(stID) && !PW.equals(stPW))
			{
				%><p> �߸��� ��й�ȣ�Դϴ�.<%
				count++;
			}
			else{
				
			}
		}
		
		System.out.println(count);
		if (redirect != null)
		{
			response.sendRedirect(redirect);
		}
		else if(count == 0){
			%><p>�������� �ʴ� ID�Դϴ�.
		<%}
		
	//	preStmt.close();
		conn.close();
		}catch(NumberFormatException e)//�߸��� ���� �Ķ���ͷ� �޾����� exception e
	{%>
	<p> �ùٸ��� ���� �����Դϴ�. 
	<%
	}
	%>
	<input type="button" value="���ư���" onclick="location.href='<%=url %>'">
</body>
</html>