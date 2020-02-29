<%@page import="java.sql.Time"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>마법 등록 창</h1>
	<%	String url= request.getHeader("referer"); %>
	<%
try{//get 방식은 url에 뜬다, post 방식은 값을 숨겨서 보낸다(url 에 도출 X).
		String driver = "org.mariadb.jdbc.Driver";//connection jar 파일
		String user_MA_ID = request.getParameter("user_MA_ID");
		System.out.println("material_reg :"+user_MA_ID);
		Statement stmt = null;
		Connection conn = null;
		ResultSet rs = null;//SQL 출력 받아올때 사용
		
		int classs = Integer.parseInt(request.getParameter("class"));
		String property = (String)request.getParameter("property");
		int sale_price = Integer.parseInt(request.getParameter("sale_price"));
		int magician_ID = Integer.parseInt(request.getParameter("magician_ID"));
		int store_ID = Integer.parseInt(request.getParameter("store_ID"));
		String magic_name = request.getParameter("magic_name");
		String magic_exp = request.getParameter("magic_exp");
		String kind = request.getParameter("kind");
		int effect = Integer.parseInt(request.getParameter("effect"));
		int MP_consume = Integer.parseInt(request.getParameter("MP_consume"));
		
		String material_name1 = (String)request.getParameter("material_namelist1");
		int material_cnt1 = Integer.parseInt(request.getParameter("material_cnt1"));
		String material_name2 = (String)request.getParameter("material_namelist2");
		int material_cnt2 = Integer.parseInt(request.getParameter("material_cnt2"));
		String material_name3 = (String)request.getParameter("material_namelist3");
		int material_cnt3 = Integer.parseInt(request.getParameter("material_cnt3"));
		
		//System.out.println("material_name1 :"+material_name1);
		
		if(magic_name != null)
		{
			magic_name = magic_name.toUpperCase();
		}
		
		String magicD_reg = "insert into magic_detail(magic_name, magic_exp, kind, effect, MP_consume) values('"+magic_name+"', '"+magic_exp+"', '"+kind+"', '"+effect+"', '"+MP_consume+"');";
		String magic_reg = "insert into magic(class, property, sale_price, magician_ID, store_ID, magic_name) values("+classs+", '"+property+"', "+sale_price+", "+magician_ID+", "+store_ID+", '"+magic_name+"');";
		String jdbcDriver = "jdbc:mariadb://localhost:3306/rodus";
		String dbUser = "root";
		String dbPass = "1103";
		String redirect = null;
		String magician_cls = "select class from magician where user_MA_ID = '"+user_MA_ID+"';";
		String material_IDQ1 = "select material_ID from material where material_name = '"+material_name1+"'";
		String material_IDQ2 = "select material_ID from material where material_name = '"+material_name2+"'";
		String material_IDQ3 = "select material_ID from material where material_name = '"+material_name3+"'";
		
		int material_ID1 = 0;
		int material_ID2 = 0;
		int material_ID3 = 0;
		int newmagic_ID1 = 0;
		
		String newmagic_IDQ1 = "select magic_ID from magic where magic_name = '"+magic_name+"'";
		
		String magic_name_dupl = "select magic_name from magic where magic_name='"+magic_name+"'";//같은 magic name이 있는지 확인하기 위해서 받아옴
		try {
			Class.forName(driver);//등록
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);//연결
			stmt=conn.createStatement();
			//String magician_class = stmt.executeQuery(magician_cls);
			rs = stmt.executeQuery(material_IDQ1);
			while(rs.next())
			{
				material_ID1 = rs.getInt("material_ID");
			}
			
			rs = stmt.executeQuery(material_IDQ2);
			while(rs.next())
			{
				material_ID2 = rs.getInt("material_ID");
			}
			
			rs = stmt.executeQuery(material_IDQ3);
			while(rs.next())
			{
				material_ID3 = rs.getInt("material_ID");
			}
			
			System.out.println("material_ID :"+material_ID1);
			
			rs = stmt.executeQuery(magician_cls);
			int magician_class = 0;
			int count = 0;
			redirect = null;
			System.out.println("ID1:"+material_ID1);
			System.out.println("ID2:"+material_ID2);
			System.out.println("ID3:"+material_ID3);
			if(material_ID1 == material_ID2 || material_ID1 == material_ID2 || material_ID2 == material_ID3){
				%>
				<form action = "logonMA.jsp" method = "post">
				<%
				count = 1;
				Integer duplerr = 1;
				session.setAttribute("count", count);
				session.setAttribute("duplerr", duplerr);
				redirect = "logonMA.jsp";
				if (redirect != null){
					response.sendRedirect(redirect);//생성하려는 마법ID가 중복 될때 돌려보냄 count를 싣어서 (count가 1이 되면 logonMA에서는 알림을 발생시킴)
				}				
				%></form><%
			}
			else{
				count = 0;				
			}
			while(rs.next())
			{
				magician_class = rs.getInt("class");
			}
			if(magician_class>=classs && count == 0)
			{
				rs = stmt.executeQuery(magic_name_dupl);
				while(rs.next())
				{
					magic_name_dupl = rs.getString("magic_name");
				}
				System.out.println("while(magic_dupl) :"+magic_name_dupl);
				if(!magic_name.equals(magic_name_dupl))
				{
					stmt.executeQuery(magicD_reg);
					stmt.executeQuery(magic_reg);
				}
				rs = null;
				rs = stmt.executeQuery(newmagic_IDQ1);
				if(rs != null)
				{
					while(rs.next())
					{
						newmagic_ID1 = rs.getInt("magic_ID");
					}
					//System.out.println("newmagic_IDQ1 :"+newmagic_ID1);
					session.setAttribute("newmagic_ID1",newmagic_ID1);
					session.setAttribute("material_ID1",material_ID1);
					session.setAttribute("material_ID2",material_ID2);
					session.setAttribute("material_ID3",material_ID3);
					session.setAttribute("material_cnt1",material_cnt1);
					session.setAttribute("material_cnt2",material_cnt2);
					session.setAttribute("material_cnt3",material_cnt3);
					session.setAttribute("magic_name",magic_name);
					
					if(redirect == null)
					{
						redirect = "use_use.jsp";//최종 생성 class허가조건, 마법이름 중복 유무체크, 생성하려는 마법 재료 체크 후 PASS -> 등록 으로 넘어감
						if (redirect != null)
						{
							response.sendRedirect(redirect);//등록으로 session정보 넘기기
						}
					}
				}
				else{
					%><p> 중복되는 마법이름이 존재합니다.</p> <br>
					마법 생성 실패!<br>
					<input type="button" value="돌아가기" onclick="location.href='<%=url %>'"><br><%
				}
			}
			else{
				%> 당신의 CLASS가 생성하려는 마법CLASS : <%=classs %> 보다 낮습니다!<br> 등록실패!
				<input type="button" value="돌아가기" onclick="location.href='<%=url %>'">
				<%
			}
		}
		catch(ClassNotFoundException e)
		{
			e.printStackTrace();
		}
	}catch(NumberFormatException e)//잘못된 값을 파라미터로 받았을때 exception e
	{%>
	<p> 올바르지 못한 정보입니다. <input type="button" value="돌아가기" onclick="location.href='<%=url %>'">
	<%
	}
		%><input type="button" value="로그아웃" onclick="location.href='http://localhost:8080/1113/form.jsp'">
</body>
</html>