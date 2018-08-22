<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
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
#title {
	font-family: tvn;
	font-size: 2em;
	margin-bottom: 30px;
}

#title b {
	color: #dabc88;
}

#tripList {
	margin: 20px 50px 50px 50px;
}
.tripBox{
	display:inline-block;
	width:250px;
	height:250px;
	margin:30px 40px;
	color:white;
	font-family:tvn;
	font-size:1.4em;
	position:relative;
	text-shadow: -2px 1px 0 #424f59,-1px 1px 0 #424f59, -2px -1px 0 #424f59,-1px -1px 0 #424f59 ,0px 0px 0 #424f59, 1px 1px 0 #424f59 , 2px 1px 0 #424f59, 1px -1px 0 #424f59 , 2px -1px 0 #424f59;
}
.tripBox div{
	margin:30px 75px 7px 75px;
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
	width:250px;
	height:250px;
	border-radius:50%;
	position:absolute;
	left:0px;
	opacity:0.5;
}
.tripBox div img{
	position:absolute;
	height:100px;
	left:-25%;
}
font{
	text-shadow: -2px 1px 0 white,-1px 1px 0 white, -2px -1px 0 white,-1px -1px 0 white ,0px 0px 0 white, 1px 1px 0 white , 2px 1px 0 white, 1px -1px 0 white , 2px -1px 0 white;
}
</style>
</head>
<body>
	<%
		String id = (String) session.getAttribute("id");

		String nation[][] = new String[45][2];

		try {
			String filePath = application.getRealPath("/WEB-INF/country.txt");
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
			}
		} catch (Exception e) {

		}
	%>
	<div id="title">
		<b><%=id%></b>님의 여행목록
	</div>

	<div id="tripList">
	<%
		File file = new	File(application.getRealPath("/WEB-INF/member/" + id + ".txt")); 
		boolean	isExists = file.exists(); 
		int tripCnt=-1;
		
		if (isExists){
			try {
				String filePath = application.getRealPath("/WEB-INF/member/"+id+".txt");
				BufferedReader reader = new BufferedReader(new FileReader(filePath));
				String csvStr = "";
				String tmpStr = "";

				do {
					tmpStr = reader.readLine();
					if (tmpStr != null) {
						csvStr += tmpStr + "/";
						tripCnt++;
					}
				} while (tmpStr != null);
				StringTokenizer parse = new StringTokenizer(csvStr, "/");
				for (int i = 0; i < tripCnt; i++) {
					String tripId=parse.nextToken();
					String name=parse.nextToken();
					String backImg=parse.nextToken();
					int country=Integer.parseInt(parse.nextToken());
					String startDate=parse.nextToken();
					String endDate=parse.nextToken();
				%>
					<a href="tripWallet.jsp?tId=<%=tripId%>"><div class="tripBox">
						<img class="back" src="resources/<%= id+"/"+backImg %>">
						<div><img src="<%=nation[country][1]%>"></div>
						<%=startDate %> ~ <%=endDate %><br>
					    <font color="#424f59" style="font-size:1.7em;font-weight:bold;"><%= name %></font>
					</div></a>
				<%}
			} catch (Exception e) {

			}
		}
	%>
	<a href="newTrip.jsp"><img src="resources/plus.png" width="120px" style="margin: auto 40px;"></img></a>
	</div>
</body>
</html>