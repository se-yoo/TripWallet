<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page
	import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy,java.util.*,java.io.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8">
<title></title>
</head>
<%
	String id = (String) session.getAttribute("id");
	String uploadPath = application.getRealPath("resources/"+id);
	request.setCharacterEncoding("UTF-8");
	
	File findDir=new File(uploadPath);
	
	if(!findDir.exists())findDir.mkdirs();

	int size = 10 * 1024 * 1024;
	int country=0;
	String title = "";
	String img = "";
	String sDate = "";
	String eDate = "";

	try {
		MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8",new DefaultFileRenamePolicy());

		country = Integer.parseInt(multi.getParameter("country"));
		title = multi.getParameter("name");
		sDate = multi.getParameter("sDate");
		eDate = multi.getParameter("eDate");

		Enumeration files = multi.getFileNames();
		String file1 = (String) files.nextElement();
		img = multi.getFilesystemName(file1);
		
		String filePath = application.getRealPath("/WEB-INF/member/" + id + ".txt");
		PrintWriter wr = new PrintWriter(new FileWriter(filePath, true));
		BufferedWriter bw = new BufferedWriter(wr);

		long now = System.currentTimeMillis();

		bw.newLine();
		bw.write(now + "/" + title + "/" + img + "/" + country + "/" + sDate + "/" + eDate);
		bw.close();
		wr.flush();
		
		String filePath2 = application.getRealPath("/WEB-INF/member/" + id + "_"+now+".txt");
		PrintWriter wr2 = new PrintWriter(new FileWriter(filePath2));
		BufferedWriter bw2 = new BufferedWriter(wr2);
		bw2.write("0`0");
		bw2.close();
		wr2.flush();
	} catch (Exception e) {
		System.out.println(e.toString());
	}
%>
<body>
	<meta http-equiv='refresh' content='0; url=main.jsp'>
</body>