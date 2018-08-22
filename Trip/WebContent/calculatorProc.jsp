<%@page import="java.io.FileReader"%>
<%@page import="java.util.StringTokenizer"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
<title></title>
<style>
#cal{
	margin:auto;
	text-align:left;
	color:white;
}
.title{
	padding:10px 20px;
	background-color:#8aa9c2;
}
.title img{
	width:40px;
}
.title div{
	display:inline-block;
	margin:5px 10px;
	position:absolute;
}
.title button{
	display:inline-block;
	margin-left: 15%;
	margin-top:5px;
	position:absolute;
	background-color:white;
	color:#8aa9c2;
	font-weight:bold;
	border:0px;
	border-radius:10%;
}
.con input[type='number']{
	width:99%;
	height:50px;
	text-align:right;
	font-family:Nanum;
	font-size:1.5em;
}
</style>
</head>
<body>
	<%
		String nation[] = new String[4];
		int country=Integer.parseInt(request.getParameter("country"));

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
			for (int i = 0; i < country; i++) {
				parse.nextToken();
				parse.nextToken();
				parse.nextToken();
				parse.nextToken();
			}
			nation[0] = parse.nextToken(); //나라이름
			nation[1] = parse.nextToken(); //화폐
			nation[2] = parse.nextToken(); //환율
			nation[3] = parse.nextToken(); //이미지
		} catch (Exception e) {

		}
	%>
	<table id="cal" width="60%">
		<tr>
		<td width="45%" class="title"><img src="<%=nation[3]%>"><div><%=nation[0] %>(<%=nation[1] %>)</div><button onclick="changeKRW(<%= nation[2]%>)">KRW변환</button></td>
		<td rowspan="2" width="10%" style="text-align:center;"><font color="black" style="font-size:3em;font-weight:bold;">=</font>
		<td width="45%" class="title"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Flag_of_South_Korea.svg/900px-Flag_of_South_Korea.svg.png">
		<div>한국(KRW)</div><button onclick="changeOther(<%= nation[2]%>)"><%=nation[1] %>변환</button></td>
		</tr>
		<tr>
		<td class="con"><input type="number" id="tripworld"></td>
		<td class="con"><input type="number" id="korea"></td>
		</tr>
	</table><br><br><br>
</body>
<script>
 function changeKRW(percent){
	 document.getElementById("korea").value=(document.getElementById("tripworld").value*percent).toFixed(2);
 }
 function changeOther(percent){
	 document.getElementById("tripworld").value=(document.getElementById("korea").value/percent).toFixed(2);
 }
</script>
</html>