<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.Scanner"%>
<%@page import="java.util.Random"%>
<%@page import="javafx.scene.control.Alert"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>magician</title>
</head>
<body>
<%	String url= request.getHeader("referer"); %>
		<form action = "maregister.jsp" method = "post">
		<div><% //�ڽ� %>
	<%
	//session.setMaxInactiveInterval(600);//600�ʰ� ���� ����
	int classMP = 0; // 1�� ������ class �����̶�� ��ȣ�� test�� ���� %>
	<a href="test.jsp?test=<%=classMP %>">CLASS,MP �ֻ��� ������</a>
	<%
	if(request.getParameter("classs")!=null)
	{
		session.removeAttribute("class");
		response.sendRedirect("magician.jsp");
	}
	Integer b = (Integer)(session.getAttribute("class"));//int������ ������ Ȥ�ö� NULL���� ������ ������
	Integer c = (Integer)(session.getAttribute("MAMP"));
	//System.out.println(b+c);//Ȯ�ο� , Integer�� ��ü������ ���ڿ� Null���� �� �� �ְԵ�
	%>
	<br>
	<input type="radio" name="class" value=<%=b %> checked> class:<%=b %> </input><br>
	<input type="radio" name="MP" value=<%=c %> checked> MP:<%=c %> </input><br>
	</div>
	<div><% //�ڽ� %>
			USER ID
			<input name="MAID" type="text"/><% //text������ �Է��� �޴´�. // text�� �ƴ� password �� �ϸ� �Է�â�� �Ⱥ��̰� �ȴ�%>
			<br>USER PW<input name="MAPW" type="password"/><br>
	</div>
	<div>
		<label>���� ����</label><br>
		<input type="radio" name="tribe" value="MONSTER" checked> MONSTER <br>
		<input type="radio" name="tribe" value="KNIGHT"> KNIGHT <br>
		<input type="radio" name="tribe" value="IDIOT"> IDIOT <br>
		<input type="radio" name="tribe" value="ROYALTY"> ROYALTY <br>
		<input type="radio" name="tribe" value="ALIEN"> ALIEN <br>
	</div>
	<div>
			<label>�Ӽ� ����</label><br>
			<input type="radio" name="property" value="elder"> ELDER 
			<input type="number" name="coupon" value="0"> <- (ELDER����)���� ��ȣ�� �Է��Ͻÿ�<br>
			<input type="radio" name="property" value="electron" checked> ELECTRON <br><% //radio ��ư�� ������ �ϳ��� ���� ����%>
			<input type="radio" name="property" value="fire"> FIRE <br>
			<input type="radio" name="property" value="nightmare"> NIGHTMARE <br>  <% //name�� �Ķ���� �������� �Ѿ%>
			<input type="radio" name="property" value="sand"> SAND <br><% //radio ��ư�� ������ �ϳ��� ���� ����%>
			<input type="radio" name="property" value="sun"> SUN <br>
			<input type="radio" name="property" value="water"> WATER <br>
			<input type="radio" name="property" value="wind"> WIND <br><% //radio ��ư�� ������ �ϳ��� ���� ����%>
	</div>
	<div>
			<label>����� ����</label><br>
			(�ڽ��� �ּ� �Է� ����)<br>
			<input type="radio" name="address" value="BOOMHILL"> BOOMHILL <br>
			<input type="radio" name="address" value="CRAZYPARK" checked> CRAZYPARK <br><% //radio ��ư�� ������ �ϳ��� ���� ����%>
			<input type="radio" name="address" value="SHADOW"> SHADOW <br>
			<input type="radio" name="address" value="NORTHEU"> NORTHEU <br>  <% //name�� �Ķ���� �������� �Ѿ%>
			<input type="radio" name="address" value="PILTOVER"> PILTOVER <br><% //radio ��ư�� ������ �ϳ��� ���� ����%>
			<input type="radio" name="address" value="SINDORIM"> SINDORIM <br>
			<input type="radio" name="address" value="VEGAS"> VEGAS <br>
			<input type="radio" name="address" value="ETC"> ETC <br>
			<input name="address1" type="text"/> <- �̿��� ���� �߰� ����<br><br>
	</div>
	<div>
			<label>���� ����</label><br>
			(�ڽ��� �ּ� �Է� ����)<br>
			<input type="radio" name="job" value="LANDLOLD"> LANDLOLD <br>
			<input type="radio" name="job" value="EMPLOYER" checked> EMPLOYER <br><% //radio ��ư�� ������ �ϳ��� ���� ����%>
			<input type="radio" name="job" value="EMPLOYEE"> EMPLOYEE <br>
			<input type="radio" name="job" value="CLOWN"> CLOWN <br>  <% //name�� �Ķ���� �������� �Ѿ%>
			<input type="radio" name="job" value="POET"> POET <br><% //radio ��ư�� ������ �ϳ��� ���� ����%>
			<input type="radio" name="job" value="FIREFIGHTER"> FIREFIGHTER <br>
			<input type="radio" name="job" value="POLICE"> POLICE <br>
			<input type="radio" name="job" value="ETC"> ETC <br>
			<input name="job1" type="text"/> <- �̿��� ���� �߰� ����<br>
	</div>
		
	<div><% //�ڽ� %>
			���� Money<br>
			<%/*
			double randomV = Math.random();
			int Money = (int)(randomV*20000)+1;*/
			%>
			<input type="radio" name="money" value=1000 checked> Money(1000) <br>
	</div>
	
	<%
	//PrintWriter outWriter = response.getWriter();
	Integer couponerr = null;
	couponerr = (Integer)session.getAttribute("couponerr");
	int count=0;
	
	if(couponerr != null)//���� ��ȣ�� �������µ� �ٽ� �ǵ��� ���� �� -> �߸��� ��ȣ���� �ٽ� ���ƿ�
	{
		count = (Integer)session.getAttribute("count");//���� ��ȣ�� null�� �ƴҶ� �����Ͽ��� ���� ����, if������ ������ ������ ó�� �� â ���� �� null Pointer���� �߻� �ϱ� ����
		System.out.println("couperr :"+couponerr);
		if(count==1){//alert //count�� 1�϶��� �ߵ��� -> ù ���Խ� �ߴ°��� ����
			JOptionPane.showMessageDialog(null,"ELDER������ȣ�� �߸��Ǿ����ϴ�.");//ùȭ����� �ߴ°� ��ħ ������ȣ �߸��Է� ��
		}
	}
	%>
	
	<div>	
	<button type="submit">����ϱ�(Enter) </button>
	</div>
	<input type="button" value="���ư���" onclick="location.href='http://localhost:8080/1113/form.jsp'">
				</form>
</body>
</html>