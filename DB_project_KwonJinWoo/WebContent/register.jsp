<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%//���� DB�� ���� ���� session.getAttribute�� ����
String property = "0";
String role = "0";
String Fname = "0";
String Lname = "0";
int age = 0;
String address = "0";
String CSID = "0";
String CSPW = "0";
int money = 0;
String STID = "0";
String tribe ="0";
String STPW = "0";
String store = "0";
String boss = "0";
String store_name = "0";
String MAID = "0";
String MAPW = "0";
String job = "0";//���������� �������� NULL ���� �ʱ�ȭ 0
 // �빮�ڷ� ��ȯ�Ͽ� �����Ҷ� NULL ���� ����
role = (String)session.getAttribute("role");//String "name" �Ķ���͸� �޾ƿ�
Fname = (String)session.getAttribute("Fname");//request�� ��Ŭ�������� �����Ǵ� �Լ�
Lname = (String)session.getAttribute("Lname");//request�� ��Ŭ�������� �����Ǵ� �Լ�
age = (Integer)(session.getAttribute("age"));//���� DB�� ���� ���� session.getAttribute�� ����
address = (String)session.getAttribute("address");//request�� ��Ŭ�������� �����Ǵ� �Լ�
property = (String)session.getAttribute("property");//request�� ��Ŭ�������� �����Ǵ� �Լ�
CSID = (String)session.getAttribute("CSID");//String "name" �Ķ���͸� �޾ƿ�
CSPW = (String)session.getAttribute("CSPW");//request�� ��Ŭ�������� �����Ǵ� �Լ�
money = (Integer)(session.getAttribute("money"));//request�� ��Ŭ�������� �����Ǵ� �Լ� 
if(property != null){
property = property.toUpperCase();
}
if(address != null){
address = address.toUpperCase();
}
//-------------------------------------------------
STID = (String)session.getAttribute("STID");
/*if(role.equals("store") && STID != null)
{*/

STPW = (String)session.getAttribute("STPW");
store_name = (String)session.getAttribute("store_name");
boss = (String)session.getAttribute("boss");//request�� ��Ŭ�������� �����Ǵ� �Լ�
//}
if(store_name != null)
{
	store_name = store_name.toUpperCase();
}
MAID = (String)session.getAttribute("MAID");

int classs=0;
int MP=0;
/*if(role.equals("magician") && MAID != null)
{*/
MAPW = (String)session.getAttribute("MAPW");//name ���� user_name�� �ֱ�(�Ķ���ͷ� ������ ��)
tribe = (String)session.getAttribute("tribe");
job = (String)session.getAttribute("job");//name ���� user_name�� �ֱ�(�Ķ���ͷ� ������ ��)
classs = (Integer)(session.getAttribute("class"));
MP = (Integer)(session.getAttribute("MP"));
/*}*/
if(job != null)
{
job = job.toUpperCase();
}
if(tribe != null)
{
tribe = tribe.toUpperCase();
}//money int ������ �޾ƿ���
	
	String url= request.getHeader("referer");
	String dbName = "rodus";
	String jdbcDriver = "jdbc:mariadb://localhost:3306/rodus";
	String dbUser = "root";
	String dbPass = "1103";
	String query = "Select * from magician";
	String update_query = "";
	
	System.out.println("register");
	System.out.println(role);
	System.out.println(Fname);
	System.out.println(Lname);
	
	Connection conn = null;
	Statement stmt = null;
	Integer store_ID = 1001;
	
	//address�� ������(magician)�� native
try{
	String driver = "org.mariadb.jdbc.Driver";
	Class.forName(driver);
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	stmt = conn.createStatement();
	if(CSID != null && role.equals("consumer"))
	{
		CSPW = "des_encrypt('" +CSPW+ "')";
		String insert_value_singleCS = "insert into consumer(Fname, Lname, age, address, property, money, user_CS_ID, user_PW) values('"+Fname+"', '" +Lname+ "', "+age+", '"+address+"','"+property+"', "+money+", '"+CSID+"',"+CSPW+");";
		
		stmt.executeQuery(insert_value_singleCS);%>
		<p class="Lead">Conducted SQL statement : <%=insert_value_singleCS %>
		<%
	}
	if(MAID != null && role.equals("magician"))
	{
		MAPW = "des_encrypt('" +MAPW+ "')";
		String insert_value_singleMA = "insert into magician(Fname, Lname, age, tribe, native, job, class, property, MP, money, store_ID, user_MA_ID, user_pw) values('"+Fname+"', '" +Lname+ "', "+age+", '"+tribe+"','"+address+"', '"+job+"', "+classs+",'"+property+"', "+MP+", "+money+", "+store_ID+", '"+MAID+"', "+MAPW+");";

		stmt.executeQuery(insert_value_singleMA);%>
		<p class="Lead">Conducted SQL statement : <%=insert_value_singleMA %>
		<%
	}
	if(STID != null && role.equals("store"))
	{
		STPW = "des_encrypt('" +STPW+ "')";
		String insert_value_singleST = "insert into store(store_name, address, boss, tribe, user_ST_ID, user_pw, class_permit, money) values('"+store_name+"', '" +address+"', '"+boss+"', '"+tribe+"','"+STID+"', "+STPW+", "+classs+", "+money+");";

		stmt.executeQuery(insert_value_singleST);%>
		<p class="Lead">Conducted SQL statement : <%=insert_value_singleST %>
		<%
	}
%>
	<h1>���������� Data�� ��ϵǾ����ϴ�. </h1>
	<p>successfully registered in Rodus database <%=dbName %>
	<input type="button" value="Ȯ��" onclick="location.href='http://localhost:8080/1113/form.jsp'">
	<%
	System.out.println("����");

}catch(SQLException se)
{
	se.printStackTrace();
}

%>

	
</body>
</html>