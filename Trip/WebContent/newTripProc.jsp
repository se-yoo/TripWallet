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
#formBox{
	display:inline-block;
	width:20%;
	text-align:left;
	margin-bottom:150px;
}
input, select option{
	font-family:Nanum;
}
input[type='submit']{
	border:0px;
	color:white;
	background-color:#8aa9c2;
	width:100%;
	height:30px;
}
</style>
</head>
<body>
<%
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
	<form action="upload.jsp" method="post" enctype="multipart/form-data">
	<div id="formBox">국가명 >> <select name="country">
	<%
		for(int i=0;i<nation.length;i++){%>
			 <option value="<%=i %>"><%=nation[i][0] %></option>
		<%}
	%>
	</select><br><br>
	<input type="text" name="name" placeholder="여행명" size="35" required><br><br>
	<input type="file" name="img" size="35" required><br><br>
	출발일 >> <input type="date" name="sDate" required><br><br>
	도착일 >> <input type="date" name="eDate" required><br><br>
	<input type="submit" value="추가">
	</div>
	</form>
</body>
</html>
