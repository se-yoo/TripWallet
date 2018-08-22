<%@page import="java.util.StringTokenizer"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
<title></title>
<style>
.tripBox{
	width:90%;
	height:250px;
	margin:auto;
	color:white;
	font-family:tvn;
	font-size:1.7em;
	position:relative;
	text-align:center;
	text-shadow: -2px 1px 0 #424f59,-1px 1px 0 #424f59, -2px -1px 0 #424f59,-1px -1px 0 #424f59 ,0px 0px 0 #424f59, 1px 1px 0 #424f59 , 2px 1px 0 #424f59, 1px -1px 0 #424f59 , 2px -1px 0 #424f59;
}
.tripBox .ct{
	border: 5px solid #8aa9c2;
	width:100px;
	height:100px;
	border-radius:50%;
	overflow:hidden;
	position:relative;
	z-index:1;
}
.back{
	z-index:-1;
	width:100%;
	height:250px;
	background-size:auto 250px;
	position:absolute;
	left:0px;
	opacity:0.3;
}
.tripBox div img{
	position:absolute;
	height:100px;
	left:-25%;
}
font{
	text-shadow: -2px 1px 0 white,-1px 1px 0 white, -2px -1px 0 white,-1px -1px 0 white ,0px 0px 0 white, 1px 1px 0 white , 2px 1px 0 white, 1px -1px 0 white , 2px -1px 0 white;
}
#buttonBox{
	position:absolute;
	right:6%;
	z-index:20;
}
#buttonBox img{
	width:50px;
	margin:15px 5px;
}
#buttonBox2{
	display:inline-block;
	width:50%;
}
#buttonBox2 img{
	width:70px;
	margin:15px 10px;
}
#progress{
	width:1000px;
	height:50px;
	background-color:#ededed;
	display:inline-block;
}
#progress_{
	height:50px;
	float:left;
	background-color:#8aa9c2;
}
#use{
	margin-right:450px;
}
#left{
	margin-left:450px;
}
.money{
	display:inline-block;
	padding:10px;
	margin:5px 10px;
	border:4px solid #8aa9c2;
	border-radius:5px;
	width:15%;
}
.money span{
	font-family:tvn;
	font-size:1.8em;
	color:#dabc88;
}
.first{
	font-size:5em;
	font-weight:bold;
	padding:0px;
	width:25%;
}
.second{
	width:50%;
	magin:10px 40px;
	text-align:left;
}
.third{
	width:25%;
	color:white;
	font-weight:bold;
	text-align:center;
	text-shadow: -2px 1px 0 #424f59,-1px 1px 0 #424f59, -2px -1px 0 #424f59,-1px -1px 0 #424f59 ,0px 0px 0 #424f59, 1px 1px 0 #424f59 , 2px 1px 0 #424f59, 1px -1px 0 #424f59 , 2px -1px 0 #424f59;
}
.t{
	width:100px;
	height:100px;
	border-radius:50%;
	margin:auto;
	background-size:100px;
}
.t div{
	padding-top:40%;
}
</style>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String) session.getAttribute("id");
	String tripId=request.getParameter("tId");
	
	String nation[][] = new String[45][4];
	
	String name="";
	String backImg="";
	int country=0;
	String startDate="";
	String endDate="";
	
	int totalMoney=0;
	int spendingMoney=0;
	int leftMoney=0;
	
	double usePer=0.0;

	try {
		String filePath = application.getRealPath("/WEB-INF/exchange rate.txt");
		BufferedReader reader = new BufferedReader(new FileReader(filePath));
		String csvStr = "";
		String tmpStr = "";

		do {
			tmpStr = reader.readLine();
			if (tmpStr != null) {
				csvStr += tmpStr + "`";
			}
		} while (tmpStr != null);
		StringTokenizer parse = new StringTokenizer(csvStr, "`");
		for (int i = 0; i < nation.length; i++) {
			nation[i][0]=parse.nextToken();
			nation[i][1]=parse.nextToken();
			nation[i][2]=parse.nextToken();
			nation[i][3]=parse.nextToken();
		}
	} catch (Exception e) {

	}
	
	File file = new	File(application.getRealPath("/WEB-INF/member/" + id + "_"+tripId+".txt")); 
	boolean	isExists = file.exists();
	
	if (isExists){
		try {
			String filePath = application.getRealPath("/WEB-INF/member/"+id+".txt");
			BufferedReader reader = new BufferedReader(new FileReader(filePath));
			String csvStr = "";
			String tmpStr = "";
			int tripCnt=-1;

			do {
				tmpStr = reader.readLine();
				if (tmpStr != null) {
					csvStr += tmpStr + "/";
					tripCnt++;
				}
			} while (tmpStr != null);
			StringTokenizer parse = new StringTokenizer(csvStr, "/");
			for (int i = 0; i < tripCnt; i++) {
				String t=parse.nextToken();
				name=parse.nextToken();
				backImg=parse.nextToken();
				country=Integer.parseInt(parse.nextToken());
				startDate=parse.nextToken();
				endDate=parse.nextToken();
				if(t.equals(tripId))break;
			}
			
			filePath = application.getRealPath("/WEB-INF/member/"+id + "_"+tripId+".txt");
			reader = new BufferedReader(new FileReader(filePath));
			csvStr = "";
			tmpStr = "";
			int cnt=-1;

			do {
				tmpStr = reader.readLine();
				if (tmpStr != null) {
					csvStr += tmpStr + "`";
					cnt++;
				}
			} while (tmpStr != null);
			
			parse = new StringTokenizer(csvStr, "`");
			totalMoney=Integer.parseInt(parse.nextToken());
			spendingMoney=Integer.parseInt(parse.nextToken());
			leftMoney=totalMoney-spendingMoney;
			
			if(totalMoney>0)usePer=100*(spendingMoney/(double)totalMoney);
			
			usePer=Double.parseDouble(String.format("%.2f",usePer));
		%>
		<div id="buttonBox"><a href="modify.jsp?tId=<%=tripId %>"><img src="resources/modifyButton.PNG"></a>
		<a href="delete.jsp?tId=<%=tripId %>"><img src="resources/delButton.png"></a></div>
		<div class="tripBox">
			<div class="back" style="background-image:url('resources/<%= id+"/"+backImg %>')"></div>
			<table width="30%" style="margin:auto">
			<tr>
				<td width="30%" style="padding-top:13%;"><div class="ct"><img src="<%=nation[country][3]%>"></div>
				</td>
				<td width="70%" style="padding-top:13%;"><%= nation[country][0] %><br><%=startDate %> ~ <%=endDate %><br>
				<font color="#424f59" style="font-size:2em;font-weight:bold;"><%= name %></font>
				</td>
			</tr>
			</table>
		</div><br>
		<div id="buttonBox2"><a href="income.jsp?tId=<%=tripId %>&c=<%=country%>&sD=<%=startDate %>&eD=<%=endDate %>"><img src="resources/addButton.PNG"></a>
		<a href="spending.jsp?tId=<%=tripId %>&c=<%=country%>&sD=<%=startDate %>&eD=<%=endDate %>"><img src="resources/minusButton.PNG"></a>
		<a href="graph.jsp?tId=<%=tripId %>"><img src="resources/graphButton.PNG"></a>
		<a href="calculator.jsp?country=<%= country %>"><img src="resources/CalculButton.PNG"></a></div>
		<br><div id="progress">
		<div id="progress_" style="width:<%=usePer%>%;display:inline-block"></div></div><br>
		<span id="use">사용 <%=usePer%>%</span><span id="left">잔액 <%=100.0-usePer%>%</span><br>
		<div class="money">사용한 금액<br><b><%=nation[country][1] %> <span><%=spendingMoney %></span></b></div><div class="money">남은 금액<br><b><%=nation[country][1] %> <span><%=leftMoney %></span></b></div>
		<br><table width="80%" style="margin:25px auto;">
		<%
			for(int i=0;i<cnt;i++){
				String type=parse.nextToken();
				String n=parse.nextToken();
				String amount=parse.nextToken();
				String img=parse.nextToken();
				String date=parse.nextToken();
				String category=parse.nextToken();
				
				String color="";

				if(type.equals("수입")){
					type="+";
					color="#b8adca";
				}
				else{
					type="-";
					color="#dfc031";
				}
			%>
				<tr height="150px;">
					<td class="first" style="color:<%=color%>"><%=type %></td>
					<td class="second"><%=nation[country][1] %>
					<font color="#8aa9c2" style="font-size:2.5em;font-weight:bold;">&nbsp;&nbsp;<%=amount %></font><br><br><%=date %></td>
					<td class="third"><%
					if(img.equals("null"))out.println("<div class='t' style='background-color:"+color+"'><div>"+n+"<div></div>");
					else out.println("<div class='t' style='background-image:url(resources/"+id+"/"+img+")'><div>"+n+"<div></div>");
					%></td>
				</tr>
				<tr>
					<td colspan="3" height="0.5px" style="background-color:#8aa9c2">
				<tr>
			<%}
		%></table><br><br><br><%
		}catch (Exception e) {
			System.out.println(e.toString());
		}
	}else{
		%><p>없는 여행입니다. URL주소가 잘못되진 않았는지 확인해주세요</p><br><br><br><%
	}
%>
</body>
</html>