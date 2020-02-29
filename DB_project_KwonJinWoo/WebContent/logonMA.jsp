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
<title>마법사 로그인</title>
</head>	
<body>
<%
response.setHeader("Pragma", "no-cache");//돌아갈때 세션 만료시키기!!
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Cache-Control", "no-store");
response.setDateHeader("Expires", 0L);//do not cache in proxy server
%>
<div>
	<h1>Login</h1>
	<%
	try{//get 방식은 url에 뜬다, post 방식은 값을 숨겨서 보낸다(url 에 도출 X).
		String driver = "org.mariadb.jdbc.Driver";//connection jar 파일
		String ID = (String)session.getAttribute("ID");
		Statement stmt = null;
		Connection conn = null;
		ResultSet rs = null;//SQL 출력 받아올때 사용
		
		System.out.println(ID);
		
		String IDS = "select Fname, Lname,user_MA_ID, property from magician;";
		String magician_IDS = "select magician_ID, store_ID, class, property from magician where user_MA_ID = '"+ID+"';";
		String material_info = "select material_ID, material_name, price from material";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/rodus";
		String dbUser = "root";
		String dbPass = "1103";
		String redirect = null;
		int magician_ID=0; // 0으로 초기화, 나중에 세션이 만료되었는지 체크할때 활용
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
			Class.forName(driver);//등록
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//연결
			
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
			if(magician_ID == 0)// 받아온 magician_ID가 없으면 즉 세션이 종료되어서 받은것이 없는 것이므로 잘못된 접근 표시하기
			{
					%><p> 잘못된 접근입니다.</p>
			<%}
			System.out.println("ID : "+magician_ID+store_ID);
			
			rs = stmt.executeQuery(IDS);
			
			while(rs.next())//SQL 문을 통해서 로그인한 사용자 정보를 받아와서 로그인을 환영 및 되돌아가기 버튼
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
						<input type="submit" value="창조한 마법 확인하기" onclick="createMA.jsp">
						</form>
						<p> <%=Fname %><%=Lname %> 님 환영합니다.</p>
						<p> 역할군 : 마법사          class : <%=classs %><br>
						<p> 속성 : <%=property %>
						<form action = "material_reg.jsp" method = "post">
						</div>
						<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
						<h2>마법 재료 등록하기(Click)</h2>
						</a><div style="DISPLAY: none">
						<input type="hidden" name="user_MA_ID" value=<%=user_MA_ID %>>
						MATERIAL NAME :<input type="text" name="material_name" required = ""><br>
						ORIGIN :<input type="text" name="origin" required = ""><br>
						KIND :<input type="text" name="kind" required = ""><br>
						PRICE :<input type="number" name="price" min="1" value="100" required = ""><br>
						<input type="submit" value="마법사 재료등록"> <br>
						</div>
						<br>
						</form>
						
						
						<form action = "magic_reg.jsp" method = "post">
						<a onclick="this.nextSibling.style.display=(this.nextSibling.style.display=='none')?'block':'none';" href="javascript:void(0)">
						<h2>마법 등록하기(click)</h2>
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
						<label> 필요한 재료 및 갯수 </label>
						<select name="material_namelist1">
						<%int a = 0;
						for(int i=0; i<material_namelist.size(); i++)
							{
								%><option><%=material_namelist.get(i) %></option>
								<%
								a = i;
							}%></select>
						<input type="number" name="material_cnt1" value="0" min="1"><br>
						<label> 필요한 재료 및 갯수 </label>
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
						<label> 필요한 재료 및 갯수 </label>
						<select name="material_namelist3">
						<%for(int i=material_namelist.size()-1; i>=0; i--)
							{
								%><option><%=material_namelist.get(i) %></option>
								<%
							}%></select>
						<input type="number" name="material_cnt3" value="0" min="0"><br>
						
						<input type="submit" value="마법 등록"><br>
						</form>
						<form action="magic_reg.jsp" method ="post">
						<%
							Integer duplerr = null;
							duplerr = (Integer)session.getAttribute("duplerr");
							if(duplerr != null)
							{
								count = (Integer)session.getAttribute("count");
								if(count==1){
									JOptionPane.showMessageDialog(null,"중복으로 재료를 선택하지 말아주세요.\nEx)ICE, ICE)");//첫화면부터 뜨는거 고치기 쿠폰번호 잘못입력 시
								}
							}%>
						</div>
						</form>
						
						<form action = "magic_trade_info.jsp" method = "post">
						<input type = "hidden" name = "magician_ID" value=<%=magician_ID %>>
						<input type = "hidden" name = "Fname" value=<%=Fname %>>
						<input type = "hidden" name = "Lname" value=<%=Lname %>>
						<input type = "hidden" name = "property" value=<%=property %>>
						<button type = "submit">내 마법 거래내역 확인</button>
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
			<button type="submit">본인 정보 확인/수정</button>
			</form>
		<form action = "form.jsp" method = "get">
			<% magician_ID = 0;%>
			<input type="hidden" name="expire" value=<%=magician_ID %>>
			<input type="submit" value="로그아웃" onclick="location.href='http://localhost:8080/1113/form.jsp'">
			<br>
			</form>
			<%
		}
		catch(ClassNotFoundException e)
		{
			e.printStackTrace();
		}
	}catch(NumberFormatException e)//잘못된 값을 파라미터로 받았을때 exception e
	{%>
	<p> 올바르지 못한 정보입니다. 
	<%
	}
		%>
		
</body>

		