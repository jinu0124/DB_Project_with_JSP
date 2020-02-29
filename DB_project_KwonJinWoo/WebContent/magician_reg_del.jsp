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
<body><% // 상회에서 마법사 등록, 삭제, 검색을 할 수 있는 창
String url= request.getHeader("referer");
	String driver = "org.mariadb.jdbc.Driver";//connection jar 파일
	String ID = (String)session.getAttribute("ID");
	Statement stmt = null;
	Connection conn = null;
	ResultSet rs = null;//SQL 출력 받아올때 사용
	
	String jdbcDriver = "jdbc:mariadb://localhost:3306/rodus";
	String dbUser = "root";
	String dbPass = "1103";
	String redirect = null;
	try {
		Class.forName(driver);//등록
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//연결
		
		List<Object> magician_ID = new ArrayList<Object>();
		List<Object> Fname = new ArrayList<Object>();
		List<Object> Lname = new ArrayList<Object>();
		List<Object> MAproperty = new ArrayList<Object>();
		List<Object> MAclass = new ArrayList<Object>();//int형
		List<Object> MAtribe = new ArrayList<Object>();
		List<Object> STtribe = new ArrayList<Object>();
		
		List<Object> Amagician_ID = new ArrayList<Object>();
		List<Object> AFname = new ArrayList<Object>();
		List<Object> ALname = new ArrayList<Object>();
		List<Object> AMAproperty = new ArrayList<Object>();
		List<Object> AMAclass = new ArrayList<Object>();//int형
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
		//등록가능한 마법사를 고른 list 만들기 위한 Query(class 비교 + 이미 등록된 마법사 제외 + class 순을 내림차순 받아오기), store.tribe 받아와서 비교 
		
		rs = stmt.executeQuery(magician_regableQ);//등록 가능한 마법사 목록
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
		rs = stmt.executeQuery(magicianlistQ);//모든 마법사 list
		int p = 0;
		
		while(rs.next())
		{
			Amagician_ID.add(rs.getInt("magician_ID"));
			AFname.add(rs.getString("Fname"));
			ALname.add(rs.getString("Lname"));
			AMAproperty.add(rs.getString("property"));
			AMAclass.add(rs.getInt("class"));
			AMAtribe.add(rs.getString("tribe"));
			MAstore_ID.add(rs.getInt("store_ID"));//as로 attribute이름을 변경하여 받아옴
			if(MAstore_ID.get(p) == null)
			{
				MAstore_ID.add(p, 0);
			}
			p++;
			//MAstore_name.add(rs.getString("store_name"));
		}
		int j = 0;
		System.out.println("store_ID :"+MAstore_ID);
		
		rs = stmt.executeQuery(magician_delQ);//소속된 마법사 list받기
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
		<option value="magician_name">법사이름</option><option value="tribe">종족</option><option value="class">클래스</option><option value="property">속성</option>
		</select>
		<input type="text" name="search">
		<button type = "submit">마법사 검색</button>
		</form>
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>전체 마법사 LIST(Click)</h2>
		</a><div style="DISPLAY: none">
		<%
			for(int i=0; i<Amagician_ID.size(); i++)
			{
				j++;
				%>
				<a href="magician_info.jsp?store_ID=<%=MAstore_ID.get(i) %>"> <%=j %>. 마법사ID :<%=Amagician_ID.get(i) %>/이름(성) :<%=AFname.get(i) %>/이름 :<%=ALname.get(i) %>/속성 :<%=AMAproperty.get(i) %>/부족 :<%=AMAtribe.get(i) %>/소속 상점 :<%=MAstore_ID.get(i) %>/클래스:<%=AMAclass.get(i) %></a><br>
			<%
			}
		%>
		</div>
		
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>등록 가능한 마법사 list(Click)</h2>
		</a><div style="DISPLAY: none">
		<%
			j = 0;
			for(int i=0; i<magician_ID.size(); i++)
			{
				j++;
				%>
				<a href="magician_regcomplete.jsp?magician_ID=<%=magician_ID.get(i) %>&store_ID=<%=store_ID %>"> <%=j %>. 마법사ID :<%=magician_ID.get(i) %>/클래스 :<%=MAclass.get(i) %>/이름(성) :<%=Fname.get(i) %>/이름 :<%=Lname.get(i) %>/속성 :<%=MAproperty.get(i) %>/부족 :<%=MAtribe.get(i) %> (등록하기)</a><br>
			<%
			}
		%>
		
		</div>
		
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>보유한 마법사 list(삭제가능)(Click)</h2>
		</a><div style="DISPLAY: none">
		<%
			j = 0;
			for(int i=0; i<Dmagician_ID.size(); i++)
			{
				j++;
				%>
				<a href="magician_delcomplete.jsp?magician_ID=<%=Dmagician_ID.get(i) %>&store_ID=<%=store_ID %>"> <%=j %>. 마법사ID :<%=Dmagician_ID.get(i) %>/나이 :<%=Dage.get(i) %>/클래스 :<%=Dclass.get(i) %>/이름(성) :<%=DFname.get(i) %>/이름 :<%=DLname.get(i) %>/속성 :<%=Dproperty.get(i) %>/부족 :<%=Dtribe.get(i) %>/ 자금 :<%=Dmoney.get(i) %> (삭제하기)</a><br>
			<%
			}
		%>
		
		
		</div>
		<input type="button" value="돌아가기" onclick="location.href='<%=url %>'">
		
		<input type="submit" value="로그아웃" onclick="location.href='http://localhost:8080/1113/form.jsp'">
			
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