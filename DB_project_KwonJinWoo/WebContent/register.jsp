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
<%//최종 DB에 넣을 것은 session.getAttribute로 받음
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
String job = "0";//들어오지않은 값에대한 NULL 방지 초기화 0
 // 대문자로 변환하여 저장할때 NULL 에러 방지
role = (String)session.getAttribute("role");//String "name" 파라미터를 받아옴
Fname = (String)session.getAttribute("Fname");//request는 이클립스에서 제공되는 함수
Lname = (String)session.getAttribute("Lname");//request는 이클립스에서 제공되는 함수
age = (Integer)(session.getAttribute("age"));//최종 DB에 넣을 것은 session.getAttribute로 받음
address = (String)session.getAttribute("address");//request는 이클립스에서 제공되는 함수
property = (String)session.getAttribute("property");//request는 이클립스에서 제공되는 함수
CSID = (String)session.getAttribute("CSID");//String "name" 파라미터를 받아옴
CSPW = (String)session.getAttribute("CSPW");//request는 이클립스에서 제공되는 함수
money = (Integer)(session.getAttribute("money"));//request는 이클립스에서 제공되는 함수 
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
boss = (String)session.getAttribute("boss");//request는 이클립스에서 제공되는 함수
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
MAPW = (String)session.getAttribute("MAPW");//name 값을 user_name에 넣기(파라미터로 전달할 값)
tribe = (String)session.getAttribute("tribe");
job = (String)session.getAttribute("job");//name 값을 user_name에 넣기(파라미터로 전달할 값)
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
}//money int 형으로 받아오기
	
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
	
	//address가 마법사(magician)의 native
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
	<h1>성공적으로 Data가 등록되었습니다. </h1>
	<p>successfully registered in Rodus database <%=dbName %>
	<input type="button" value="확인" onclick="location.href='http://localhost:8080/1113/form.jsp'">
	<%
	System.out.println("성공");

}catch(SQLException se)
{
	se.printStackTrace();
}

%>

	
</body>
</html>