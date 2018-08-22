<%@page import="java.util.StringTokenizer"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
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
<body>
<%
		request.setCharacterEncoding("UTF-8");
		String id = (String) session.getAttribute("id");
		String tripId=request.getParameter("tId");
		String nation[][] = new String[45][2];
		
		String name="";
		String backImg="";
		int country=0;
		String startDate="";
		String endDate="";

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
			
			String filePath2 = application.getRealPath("/WEB-INF/member/"+id+".txt");
			BufferedReader reader2 = new BufferedReader(new FileReader(filePath2));
			String csvStr2 = "";
			String tmpStr2 = "";
			int tripCnt=-1;

			do {
				tmpStr2 = reader2.readLine();
				if (tmpStr2 != null) {
					csvStr2 += tmpStr2 + "/";
					tripCnt++;
				}
			} while (tmpStr2 != null);
			StringTokenizer parse2 = new StringTokenizer(csvStr2, "/");
			for (int i = 0; i < tripCnt; i++) {
				String t=parse2.nextToken();
				name=parse2.nextToken();
				backImg=parse2.nextToken();
				country=Integer.parseInt(parse2.nextToken());
				startDate=parse2.nextToken();
				endDate=parse2.nextToken();
				if(t.equals(tripId))break;
			}
		} catch (Exception e) {

		}
	%>
	<form action="reUpload.jsp?tId=<%=tripId %>" method="post" enctype="multipart/form-data">
	<div id="formBox">국가명 >> <select name="country">
	<%
		for(int i=0;i<nation.length;i++){
			if(i==country){%>
			 <option value="<%=i %>" selected><%=nation[i][0] %></option>
		<%}else{%>
		 <option value="<%=i %>"><%=nation[i][0] %></option>
			<%}
		}
	%>
	</select><br><br>
	<input type="text" name="name" value="<%=name %>" size="35" required><br><br>
	<input type="file" name="img" size="35" required><br><br>
	출발일 >> <input type="date" name="sDate" id="sDate" value="<%=startDate %>" required><br><br>
	도착일 >> <input type="date" name="eDate" id="sDate" value="<%=endDate %>" required><br><br>
	<input type="submit" value="수정">
	</div>
	</form>	
</body>
</html>