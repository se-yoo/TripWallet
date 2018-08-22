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
</head>
<body>
	<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("user");
	String pw=request.getParameter("password");
	
	try{
		String filePath = application.getRealPath("/WEB-INF/member.txt");
		BufferedReader reader=new BufferedReader(new FileReader(filePath));
		String csvStr = "";
		String tmpStr = "";
		int memberCnt=-1;

		do {
			tmpStr = reader.readLine();
			if (tmpStr != null) {
				csvStr += tmpStr + "/";
				memberCnt++;
			}
		} while (tmpStr != null);
		String[][] member=new String[memberCnt][2];
		StringTokenizer parse = new StringTokenizer(csvStr, "/");
		for (int i = 0; i < memberCnt; i++) {
			member[i][0]=parse.nextToken();
			member[i][1]=parse.nextToken();
			if(id.equals(member[i][0])&&pw.equals(member[i][1])){
				session.setAttribute("id", id);
				%><meta http-equiv='refresh' content='0; url=main.jsp'><%
				break;
			}else if(id.equals(member[i][0])){
				out.println("<script>alert('아이디 혹은 비밀번호가 일치하지 않습니다')</script>");
				%><meta http-equiv='refresh' content='0; url=login.jsp'><%
				break;
			}else if(i==memberCnt-1){
				out.println("<script>alert('없는 계정입니다')</script>");
				%><meta http-equiv='refresh' content='0; url=login.jsp'><%
				break;
			}
		}
	}catch(Exception e){
		out.println(e.toString());
	}
	%>
</body>
</html>