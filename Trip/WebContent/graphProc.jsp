<%@page import="java.util.StringTokenizer"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
<title></title>
<style>
	.color{
		display:inline-block;
		width:15px;
		height:15px;
		margin-left:15px;
	}
</style>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String id = (String) session.getAttribute("id");
		String tripId=request.getParameter("tId");
		
		int totalMoney=0;
		int spendingMoney=0;
		
		int food=0;
		int shopping=0;
		int tour=0;
		int traffic=0;
		int stay=0;
		int etc=0;
		
		String color[]={"#eaadad","#eacfad","#eeeba2","#c4eea2","#bdddee","#ddbdee"};
	
		try{
			String filePath = application.getRealPath("/WEB-INF/member/" + id + "_" + tripId + ".txt");
			BufferedReader reader = new BufferedReader(new FileReader(filePath));
			String csvStr = "";
			String tmpStr = "";
			int cnt = -1;

			do {
				tmpStr = reader.readLine();
				if (tmpStr != null) {
					csvStr += tmpStr + "`";
					cnt++;
				}
			} while (tmpStr != null);

			StringTokenizer parse = new StringTokenizer(csvStr, "`");
			totalMoney = Integer.parseInt(parse.nextToken());
			spendingMoney = Integer.parseInt(parse.nextToken());
			
			for(int i=0;i<cnt;i++){
				String type=parse.nextToken();
				String name=parse.nextToken();
				int amount=Integer.parseInt(parse.nextToken());
				String img=parse.nextToken();
				String date=parse.nextToken();
				String category=parse.nextToken();
				
				if(type.equals("지출")){
					switch(category){
					case "식비":
						food+=amount;
						break;
					case "쇼핑":
						shopping+=amount;
						break;
					case "관광":
						tour+=amount;
						break;
					case "교통":
						traffic+=amount;
						break;
					case "숙박":
						stay+=amount;
						break;
					case "기타":
						etc+=amount;
						break;
					}
				}
			}
			
			out.println("<input type='hidden' id='amount' value='"+spendingMoney+"'>");
			out.println("<input type='hidden' id='food' value='"+food+"'>");
			out.println("<input type='hidden' id='shopping' value='"+shopping+"'>");
			out.println("<input type='hidden' id='tour' value='"+tour+"'>");
			out.println("<input type='hidden' id='traffic' value='"+traffic+"'>");
			out.println("<input type='hidden' id='stay' value='"+stay+"'>");
			out.println("<input type='hidden' id='etc' value='"+etc+"'>");
			
		}catch(Exception e){
			System.out.println(e.toString());
		}
		
	%>
	<div class="color" style="background-color:<%=color[0]%>"></div> 식비<span style="color:<%=color[0]%>;font-weight:bold;">
	<%= (Math.round(10000*food/(double)spendingMoney)/100.0) %>%</span>
	<div class="color" style="background-color:<%=color[1]%>"></div> 쇼핑<span style="color:<%=color[1]%>;font-weight:bold;">
	<%= (Math.round(10000*shopping/(double)spendingMoney)/100.0) %>%</span>
	<div class="color" style="background-color:<%=color[2]%>"></div> 관광<span style="color:<%=color[2]%>;font-weight:bold;">
	<%= (Math.round(10000*tour/(double)spendingMoney)/100.0) %>%</span>
	<div class="color" style="background-color:<%=color[3]%>"></div> 교통<span style="color:<%=color[3]%>;font-weight:bold;">
	<%= (Math.round(10000*traffic/(double)spendingMoney)/100.0) %>%</span>
	<div class="color" style="background-color:<%=color[4]%>"></div> 숙박<span style="color:<%=color[4]%>;font-weight:bold;">
	<%= (Math.round(10000*stay/(double)spendingMoney)/100.0) %>%</span>
	<div class="color" style="background-color:<%=color[5]%>"></div> 기타<span style="color:<%=color[5]%>;font-weight:bold;">
	<%= (Math.round(10000*etc/(double)spendingMoney)/100.0) %>%</span><br>
	<canvas id="graph" width="500px" height="400px"></canvas>
<script>
	var c = document.getElementById("graph");
	var ctx = c.getContext("2d");
	
	var color=["#eaadad","#eacfad","#eeeba2","#c4eea2","#bdddee","#ddbdee"];
	
	var totalMoney=Number(document.getElementById("amount").value);
	var food=Number(document.getElementById("food").value);
	var shopping=Number(document.getElementById("shopping").value);
	var tour=Number(document.getElementById("tour").value);
	var traffic=Number(document.getElementById("traffic").value);
	var stay=Number(document.getElementById("stay").value);
	var etc=Number(document.getElementById("etc").value);
	
	ctx.beginPath();
	ctx.moveTo(250,200);
	ctx.arc(250, 200, 150, 1.5*Math.PI, 1.5*Math.PI + food/totalMoney*2*Math.PI);
	ctx.closePath();
	ctx.fillStyle=color[0];
	ctx.fill();
	
	ctx.beginPath();
	ctx.moveTo(250,200);
	ctx.arc(250, 200, 150, 1.5*Math.PI + food/totalMoney*2*Math.PI, 1.5*Math.PI+(food+shopping)/totalMoney*2*Math.PI);
	ctx.closePath();
	ctx.fillStyle=color[1];
	ctx.fill();
	
	ctx.beginPath();
	ctx.moveTo(250,200);
	ctx.arc(250, 200, 150, 1.5*Math.PI+(food+shopping)/totalMoney*2*Math.PI, 1.5*Math.PI+(food+shopping+tour)/totalMoney*2*Math.PI);
	ctx.closePath();
	ctx.fillStyle=color[2];
	ctx.fill();
	
	ctx.beginPath();
	ctx.moveTo(250,200);
	ctx.arc(250, 200, 150,1.5*Math.PI+(food+shopping+tour)/totalMoney*2*Math.PI, 1.5*Math.PI+(food+shopping+tour+traffic)/totalMoney*2*Math.PI);
	ctx.closePath();
	ctx.fillStyle=color[3];
	ctx.fill();
	
	ctx.beginPath();
	ctx.moveTo(250,200);
	ctx.arc(250, 200, 150, 1.5*Math.PI+(food+shopping+tour+traffic)/totalMoney*2*Math.PI, 1.5*Math.PI+(food+shopping+tour+traffic+stay)/totalMoney*2*Math.PI);
	ctx.closePath();
	ctx.fillStyle=color[4];
	ctx.fill();
	
	ctx.beginPath();
	ctx.moveTo(250,200);
	ctx.arc(250, 200, 150, 1.5*Math.PI+(food+shopping+tour+traffic+stay)/totalMoney*2*Math.PI, 1.5*Math.PI+(food+shopping+tour+traffic+stay+etc)/totalMoney*2*Math.PI);
	ctx.closePath();
	ctx.fillStyle=color[5];
	ctx.fill();
</script>
</body>
</html>