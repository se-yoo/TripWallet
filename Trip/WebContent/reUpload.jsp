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
	request.setCharacterEncoding("UTF-8");
	String id = (String) session.getAttribute("id");
	String tripId=request.getParameter("tId");
	String uploadPath = application.getRealPath("resources/"+id);
	
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
		
		String tripInfo[][]=new String[tripCnt][6];
		StringTokenizer parse2 = new StringTokenizer(csvStr2, "/");
		for (int i = 0; i < tripCnt; i++) {
			tripInfo[i][0]=parse2.nextToken();
			tripInfo[i][1]=parse2.nextToken();
			tripInfo[i][2]=parse2.nextToken();
			tripInfo[i][3]=parse2.nextToken();
			tripInfo[i][4]=parse2.nextToken();
			tripInfo[i][5]=parse2.nextToken();
		}
		
		String filePath = application.getRealPath("/WEB-INF/member/" + id + ".txt");
		PrintWriter wr = new PrintWriter(new FileWriter(filePath));
		BufferedWriter bw = new BufferedWriter(wr);

		for(int i=0;i<tripCnt;i++){
			bw.newLine();
			if(tripInfo[i][0].equals(tripId))bw.write(tripId + "/" + title + "/" + img + "/" + country + "/" + sDate + "/" + eDate);
			else bw.write(tripInfo[i][0] + "/" + tripInfo[i][1] + "/" + tripInfo[i][2] + "/" + tripInfo[i][3] + "/" + tripInfo[i][4] + "/" + tripInfo[i][5]);
		}
		bw.close();
		wr.flush();
	} catch (Exception e) {
		System.out.println(e.toString());
	}
%>
<body>
	<meta http-equiv='refresh' content='0; url=main.jsp'>
</body>