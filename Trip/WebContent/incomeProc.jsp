<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.util.StringTokenizer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
<title></title>
<style>
#formBox {
	display: inline-block;
	width: 35%;
	text-align: left;
	margin-bottom: 150px;
}

input, select option {
	font-family: Nanum;
}

input[type='submit'] {
	border: 0px;
	color: white;
	background-color: #b8adca;
	width: 100%;
	height: 30px;
}
#exRateBox{
	width:90%;
	background-color:#b8adca;
	height:100px;
	color:white;
	padding:20px;
	border-radius:5px;
}
#exRateBox #nation{
	font-size:2em;
	font-weight:bold;
}
#exRateBox div{
	text-align:right;
	margin-right:20px;
	display:inline-block;
	width:80%;
}
#exRateBox input[type='number']{
	font-size:1.5em;
	margin-left:10px;
	width:80%;
	height:50px;
	text-align:right;
	font-family:Nanum;
	border:0px;
	background-color:#b8adca;
	color:white;
}
</style>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		String id = (String) session.getAttribute("id");
		String tripId=request.getParameter("tId");
		int country=Integer.parseInt(request.getParameter("c"));
		String sD=request.getParameter("sD");
		String eD=request.getParameter("eD");
		String nation[] = new String[4];

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
	<form action="addList.jsp?tId=<%=tripId %>&type=1&category=x" method="post" enctype="multipart/form-data">
		<div id="formBox">
			이름 및 간략한 설명 >> <input type="text" name="name" placeholder="(2~4글자 작성)" size="35" maxlength="4" required><br>
			<br><div id="exRateBox"><span id="nation"><%=nation[1] %></span>
			<input type="number" name="amount" id="input" placeholder="금액을 입력하세요" onchange="changeKRW(<%=nation[2]%>)">
			<br><img src="<%=nation[3]%>" width="60px"><div><b>KRW&nbsp;&nbsp;</b> <span id="korea">0.00</span>원</div></div><br>
			<br> 이미지(없으면 색상으로 대체) >> <input type="file" name="img" size="25"><br>
			<br> 날짜 >> <input type="date" name="sDate" value="<%=sD %>" min="<%=sD %>" max="<%=eD %>" required><br>
			<br> <input type="submit" value="수입추가">
		</div>
	</form>
</body>
<script>
 function changeKRW(percent){
	 document.getElementById("korea").innerHTML=(document.getElementById("input").value*percent).toFixed(2);
 }
</script>
</html>
