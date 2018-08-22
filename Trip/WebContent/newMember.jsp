<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.PrintWriter"%>
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
	String pw2=request.getParameter("password2");
	String memberAll="";
	
	if(pw.equals(pw2)){
		BufferedReader reader=null;

		try{
			String filePath = application.getRealPath("/WEB-INF/member.txt");
			reader=new BufferedReader(new FileReader(filePath));
			String csvStr = "";
			String tmpStr = "";
			int memberCnt=0;

			do {
				tmpStr = reader.readLine();
				if (tmpStr != null) {
					csvStr += tmpStr + "/";
					memberCnt++;
				}
			} while (tmpStr != null);
			StringTokenizer parse = new StringTokenizer(csvStr, "/");
			for (int i = 0; i < memberCnt; i++) {
				memberAll += parse.nextToken()+" @ ";
				parse.nextToken();
			}
		}catch(Exception e){
			out.println("파일을 읽을 수 없습니다.");
		}
		if(memberAll.contains(id)){
			out.println("<script>alert('이미 존재하는 계정입니다')</script>");
			%><meta http-equiv='refresh' content='0; url=signUp.jsp'><%
		}else{
			try {
				String filePath = application.getRealPath("/WEB-INF/member.txt");
				PrintWriter wr = new PrintWriter(new FileWriter(filePath, true));
				BufferedWriter bw = new BufferedWriter(wr);

				bw.newLine();
				bw.write(id+"/"+pw);
				bw.close();
				wr.flush();
			} catch (Exception e) {
			}
			out.println("<script>alert('계정을 생성했습니다')</script>");
			%><meta http-equiv='refresh' content='0; url=login.jsp'><%
		}
	}else{
		out.println("<script>alert('입력한 비밀번호와 비밀번호 확인이 일치하지 않습니다')</script>");
		%><meta http-equiv='refresh' content='0; url=signUp.jsp'><%
	}
	%>
</body>
</html>