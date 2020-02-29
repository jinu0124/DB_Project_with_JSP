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
<title>CS_info</title>
</head>
<body><% // 소비자의 정보 확인/ 수정 창
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
		
		stmt=conn.createStatement();
		//rs = stmt.executeQuery();
		int consumer_ID = Integer.parseInt(request.getParameter("consumer_ID"));
		String consumer_info = "select consumer_ID, Fname, Lname, age, address, property, money, user_CS_ID, des_decrypt(user_pw) as user_pw from consumer where consumer_ID = "+consumer_ID+";";
		String Fname = null;
		String Lname = null;
		int age = 0;
		String address = null;
		String property = null;
		int money = 0;
		String user_CS_ID = null;
		String user_pw = null;
		
		rs = stmt.executeQuery(consumer_info);
		while(rs.next())
		{
			Fname = rs.getString("Fname");
			Lname = rs.getString("Lname");
			age = rs.getInt("age");
			address = rs.getString("address");
			property = rs.getString("property");
			money = rs.getInt("money");
			user_CS_ID = rs.getString("user_CS_ID");
			user_pw = rs.getString("user_pw");
		}
		
		String addressQ = "(select distinct address from store)union(select distinct native from magician)union(select distinct address from consumer);";
		//출력 속성이름은 address로 받아와짐 union을 이용하여 모든 마을을 가져옴
		String store_list = "select distinct store.store_ID as store_ID, store_name, address, boss, class_permit from account, store where consumer_ID = "+consumer_ID+" and store.store_ID = account.store_ID";
		
		List<Object> Alladdress = new ArrayList<Object>();
		rs = stmt.executeQuery(addressQ);
		while(rs.next())
		{
			Alladdress.add(rs.getString("address"));
		}
		int addressnumber = 0;
		for(int t=0; t<Alladdress.size(); t++)
		{
			if(address.equals(Alladdress.get(t)))
				addressnumber = t;
		}
		int n = 0;
		%>
		<form action = "CS_info_mod.jsp" method = post">
		<h4> 소비자 정보 </h4>
		소비자 발급 ID : <%=consumer_ID %><br>
		<input type = "hidden" name = "consumer_ID" value = <%=consumer_ID %>>
		<p> 소비자명 : <%=Fname %> <%=Lname %> 성:<input type = "text" name = "Fname" value = <%=Fname %>> 이름:<input type = "text" name = "Lname" value = <%=Lname %>>(수정 가능)<br>
		 주소 : <%=address %>  <select name = "address">
		<%for(int k=addressnumber; k<Alladdress.size()+addressnumber; k++)
		{
			if(k < Alladdress.size())
				{
				%><option><%=Alladdress.get(k) %></option>
				<%}
			else
			{
				n = k-Alladdress.size();
			%><option><%=Alladdress.get(n) %></option><%}
		}
		int j = 0;
		%></select><br> 
		 나이 : <%=age %> <input type = "number" name = "age" value = <%=age %>>(수정가능)<br> 
		 속성 : <%=property %> <input type = "hidden" name = "property" value = <%=property %>><br>
		 자금 : <%=money %> <input type = "hidden" name = "money" value = <%=money %>><br> 
		 사용자 ID : <%=user_CS_ID %> <input type = "text" name = "user_CS_ID" value = <%=user_CS_ID %>>(수정 가능)<br> 
		 사용자 PW : <input type = "text" name = "user_pw" value = <%=user_pw %>>(수정 가능)<br></p>
		<input type = "submit" value = "정보수정하기"><br>
		</form>
		<%
		
		List<Object> store_ID = new ArrayList<Object>();
		List<Object> store_name = new ArrayList<Object>();
		List<Object> STaddress = new ArrayList<Object>();
		List<Object> boss = new ArrayList<Object>();
		List<Object> class_permit = new ArrayList<Object>();
		
		rs = stmt.executeQuery(store_list);
		while(rs.next())
		{
			store_ID.add(rs.getInt("store_ID"));
			store_name.add(rs.getString("store_name"));
			STaddress.add(rs.getString("address"));
			boss.add(rs.getString("boss"));
			class_permit.add(rs.getInt("class_permit"));
		}
		
		%>
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>거래 상회 list(Click)</h2>
		</a><div style="DISPLAY: none">
		<%
			j = 0;
			for(int i=0; i<store_ID.size(); i++)
			{
				j++;
				%>
				<a href="consumer_ST_info.jsp?store_ID=<%=store_ID.get(i) %>&store_name=<%=store_name.get(i) %>&STaddress=<%=STaddress.get(i) %>&boss=<%=boss.get(i) %>&class_permit=<%=class_permit.get(i) %>"> <%=j %>. 상회 ID :<%=store_ID.get(i) %>/상회이름 :<%=store_name.get(i) %>/주소 :<%=STaddress.get(i) %>(정보보기)</a><br>
			<%
			}
		%>
		</div>
		
		<%
		List<Object> magic_ID_list = new ArrayList<Object>();
		List<Object> magic_name = new ArrayList<Object>();
		List<Object> classs = new ArrayList<Object>();
		List<Object> MGproperty = new ArrayList<Object>();
		List<Object> sale_price = new ArrayList<Object>();
		
		String magic_have = "select distinct magic.magic_ID as magic_ID, magic_name, class, property, sale_price from sale_purchase, magic where consumer_ID = "+consumer_ID+" and sale_purchase.magic_ID is not null and magic.magic_ID = sale_purchase.magic_ID;";
		rs = stmt.executeQuery(magic_have);
		while(rs.next())
		{
			magic_ID_list.add(rs.getInt("magic_ID"));
			magic_name.add(rs.getString("magic_name"));
			classs.add(rs.getInt("class"));
			MGproperty.add(rs.getString("property"));
			sale_price.add(rs.getInt("sale_price"));
		}
		
		%>
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>보유 마법  list(Click)</h2>
		</a><div style="DISPLAY: none">
		<%
			j = 0;
			for(int i=0; i<magic_ID_list.size(); i++)
			{
				j++;
				%>
				<a href="consumer_MG_info.jsp?magic_ID=<%=magic_ID_list.get(i) %>&magic_name=<%=magic_name.get(i) %>&class=<%=classs.get(i) %>&property=<%=MGproperty.get(i) %>&sale_price=<%=sale_price.get(i) %>"> <%=j %>. 마법 ID :<%=magic_ID_list.get(i) %>/마법이름 :<%=magic_name.get(i) %>/속성 :<%=MGproperty.get(i) %>(정보보기)</a><br>
			<%
			}
		%>
		</div>
		<%//useuse 테이블에서 마법 마다 필요한 재료의 갯수를 받아옴
		List<Object> usemagic_ID = new ArrayList<Object>();
		List<Object> usematerial_ID = new ArrayList<Object>();
		List<Object> usematerial_cnt = new ArrayList<Object>();
		for(int h=0; h<magic_ID_list.size(); h++)//for문을 활용해서 보유한 마법 갯수 만큼 돌려줌, 돌때마다 보유한 마법 하나씩 쿼리를 통해서 필요한 마법 갯수 받아옴
			{
			String material_require = "select magic_ID, material_ID, material_cnt from use_use where magic_ID = "+magic_ID_list.get(h)+";";
			rs = stmt.executeQuery(material_require);
			while(rs.next())
			{
				usemagic_ID.add(rs.getInt("magic_ID"));
				usematerial_ID.add(rs.getInt("material_ID"));
				usematerial_cnt.add(rs.getInt("material_cnt"));//보유한 마법 중 필요한 재료 갯수들을 받아옴
			}
		}
		System.out.println("usemagic_ID :"+usemagic_ID);
		%>
		<%
		List<Object> material_ID = new ArrayList<Object>();
		List<Object> material_name = new ArrayList<Object>();
		List<Object> origin = new ArrayList<Object>();
		List<Object> kind = new ArrayList<Object>();
		List<Object> matprice = new ArrayList<Object>();
		List<Object> count = new ArrayList<Object>();
		
		
		String material_have = "SELECT SUM(count) AS count, material.material_ID AS material_ID, material_name, origin, kind, price FROM sale_purchase, material WHERE material.material_ID = sale_purchase.material_ID and consumer_ID = "+consumer_ID+" group by sale_purchase.material_ID having sale_purchase.material_ID is not null;";
		rs = stmt.executeQuery(material_have);
		while(rs.next())
		{
			material_ID.add(rs.getInt("material_ID"));
			material_name.add(rs.getString("material_name"));
			origin.add(rs.getString("origin"));
			kind.add(rs.getString("kind"));
			matprice.add(rs.getInt("price"));
			count.add(rs.getInt("count"));
		}
		%>
		<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
		<h2>보유 재료 list(Click)</h2>
		</a><div style="DISPLAY: none">
		<%
			j = 0;
			for(int i=0; i<material_ID.size(); i++)
			{
				j++;
				%>
				<a href="consumer_MT_info.jsp?material_ID=<%=material_ID.get(i) %>&material_name=<%=material_name.get(i) %>&origin=<%=origin.get(i) %>&kind=<%=kind.get(i) %>&price=<%=matprice.get(i) %>"> <%=j %>. 재료 ID :<%=material_ID.get(i) %>/재료이름 :<%=material_name.get(i) %>/재고량 :<%=count.get(i) %>(정보보기)</a><br>
			<%
			}
		%>
		</div>		
		
		<p>마법 당 필요한 재료</p>
		<%for(int g=0; g<usemagic_ID.size(); g++)
		{
			%><p>마법ID :<%=usemagic_ID.get(g) %>/필요재료 :<%=usematerial_ID.get(g) %>/갯수 :<%=usematerial_cnt.get(g) %></p>
		
		<%}
			
			%>
		<%
		int enough = 0;// for문으로 필요 재료 갯수 찾아주려다가 실패 
		int countt = 0;
		int usematerial_cntt = 0;
		int magic_ID_listt = 0;
		int usemagic_IDD = 0;
		int material_IDD = 0;
		int usematerial_IDD = 0;
		System.out.println("magic_ID_list :"+magic_ID_list);
		System.out.println("usemagic_ID :"+usemagic_ID);
		System.out.println("material_ID :"+material_ID);
		for(int m = 0; m<magic_ID_list.size(); m++)
		{
			System.out.println(m);
			for(int w=0; w<usemagic_ID.size(); w++)
			{	System.out.println("m+w:"+m+w);
				magic_ID_listt = (int)magic_ID_list.get(m);
				usemagic_IDD = (int)usemagic_ID.get(w);
				if(magic_ID_listt == usemagic_IDD)
				{	System.out.println("첫if 안"+m);
					for(int q=0; q<material_ID.size(); q++)
					{	System.out.println("첫 for:"+q);
						for(int b=0; b<usematerial_ID.size(); b++)
						{	System.out.println("두 for:"+b);
							material_IDD = (int)material_ID.get(q);
							usematerial_IDD = (int)usematerial_ID.get(b);
							if(material_IDD == usematerial_IDD)
							{	System.out.println("2"+m + q + b);
								countt = (int)count.get(q);
								usematerial_cntt = (int)usematerial_cnt.get(b);
								if(countt < usematerial_cntt)
								{	
									enough = usematerial_cntt - countt;
									System.out.println("enough :"+enough);
									if(magic_ID_listt == 1009)
									{
									%>
									<p>magic_ID:<%=magic_ID_list.get(m) %>을 위해 재료ID:<%=usematerial_ID.get(b) %>이 <%=enough %>개 부족합니다.</p>
									<%
									}
								}
							}
						}
					}
				}
			}
		}
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
	<input type="button" value="돌아가기" onclick="history.go(-1)">
	<input type="button" value="로그아웃" onclick="location.href='http://localhost:8080/1113/form.jsp'">
	</body>
	</html>