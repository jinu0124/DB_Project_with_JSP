<%@page import="javax.swing.JOptionPane"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.Scanner"%>
<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Consumer</title>
</head>
<body>
<%	String url= request.getHeader("referer");//ȸ�����Խ� �Һ��� ���� ȭ�� %>
		<form action = "csregister.jsp" method = "post">
	<div><% //�ڽ� %>
			USER ID
			<input name="CSID" type="text"/><% //text������ �Է��� �޴´�. // text�� �ƴ� password �� �ϸ� �Է�â�� �Ⱥ��̰� �ȴ�%>
			<br>USER PW<input name="CSPW" type="password"/><br>
	</div>
	
	<div>
			<label>���ϴ� �Ӽ� ����</label><br>
			<input type="radio" name="property" value="elder"> ELDER
			<%/*Scanner scan = new Scanner(System.in); 
			String message;
			message = scan.nextLine();*/
			%>
			<input type="number" name="coupon" value="0"> <- (ELDER����)���� ��ȣ�� �Է��Ͻÿ�<br>
			<input type="radio" name="property" value="electron" checked> ELECTRON <br><% //radio ��ư�� ������ �ϳ��� ���� ����%>
			<input type="radio" name="property" value="fire"> FIRE <br>
			<input type="radio" name="property" value="nightmare"> NIGHTMARE <br>  <% //name�� �Ķ���� �������� �Ѿ%>
			<input type="radio" name="property" value="sand"> SAND <br><% //radio ��ư�� ������ �ϳ��� ���� ����%>
			<input type="radio" name="property" value="sun"> SUN <br>
			<input type="radio" name="property" value="water"> WATER <br>
			<input type="radio" name="property" value="wind"> WIND <br><% //radio ��ư�� ������ �ϳ��� ���� ����%>
	</div>
	<div><% //�ڽ� %>
			���� Money<br>
			<%/*
			double randomV = Math.random();
			int Money = (int)(randomV*20000)+1;*/
			%>
			<input type="radio" name="money" value=1000 checked> Money(1000) <br>
	</div>
	
	<div>
			<label>Ȱ���� ����(�ּ�) ����</label><br>
			(�ڽ��� �ּ� �Է� ����)<br>
			<input type="radio" name="address" value="BOOMHILL" checked> BOOMHILL <br>
			<input type="radio" name="address" value="CRAZYPARK"> CRAZYPARK <br><% //radio ��ư�� ������ �ϳ��� ���� ����%>
			<input type="radio" name="address" value="SHADOW"> SHADOW <br>
			<input type="radio" name="address" value="NORTHEU"> NORTHEU <br>  <% //name�� �Ķ���� �������� �Ѿ%>
			<input type="radio" name="address" value="PILTOVER"> PILTOVER <br><% //radio ��ư�� ������ �ϳ��� ���� ����%>
			<input type="radio" name="address" value="SINDORIM"> SINDORIM <br>
			<input type="radio" name="address" value="VEGAS"> VEGAS <br>
			<input type="radio" name="address" value="ETC"> ETC <br>
			<input name="address1" type="text"/><br><br>
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