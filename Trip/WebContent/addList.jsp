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
	
	int type=Integer.parseInt(request.getParameter("type"));
	
	String tp="";
	String title = "";
	int amount = 0;
	String img = "";
	String date = "";
	String category="없음";
	
	int addMoney=0;
	int spendingMoney=0;

	try {
		MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "UTF-8",new DefaultFileRenamePolicy());

		title = multi.getParameter("name");
		amount = Integer.parseInt(multi.getParameter("amount"));
		date = multi.getParameter("sDate");
		category=multi.getParameter("category");

		Enumeration files = multi.getFileNames();
		String file1 = (String) files.nextElement();
		img = multi.getFilesystemName(file1);
		
		String filePath = application.getRealPath("/WEB-INF/member/"+id+"_"+tripId+".txt");
		BufferedReader reader = new BufferedReader(new FileReader(filePath));
		String csvStr = "";
		String tmpStr = "";
		int cnt=-1;

		do {
			tmpStr = reader.readLine();
			if (tmpStr != null) {
				csvStr += tmpStr + "`";
				cnt++;
			}
		} while (tmpStr != null);

		StringTokenizer parse = new StringTokenizer(csvStr, "`");
		addMoney=Integer.parseInt(parse.nextToken());
		spendingMoney=Integer.parseInt(parse.nextToken());
		
  	    if(type==1){
			tp="수입";
			addMoney+=amount;
		}
		else{
			tp="지출";
			spendingMoney+=amount;
		}
		
		if(cnt>0){
			String info[][]=new String[cnt][6];
		
			for (int i = 0; i < cnt; i++) {
				info[i][0]=parse.nextToken();
				info[i][1]=parse.nextToken();
				info[i][2]=parse.nextToken();
				info[i][3]=parse.nextToken();
				info[i][4]=parse.nextToken();
				info[i][5]=parse.nextToken();
			}

			filePath = application.getRealPath("/WEB-INF/member/" + id + "_"+tripId+".txt");
			PrintWriter wr = new PrintWriter(new FileWriter(filePath));
			BufferedWriter bw = new BufferedWriter(wr);

			bw.write(addMoney + "`" + spendingMoney);
			bw.newLine();
			bw.write(tp + "`" + title + "`" + amount + "`" + img + "`" + date + "`" + category);
			for(int j=0;j<cnt;j++){
				bw.newLine();
				bw.write(info[j][0] + "`" + info[j][1] + "`" + info[j][2] + "`" + info[j][3] + "`" + info[j][4] + "`" + info[j][5]);
			}
			bw.close();
			wr.flush();
		}else{
			filePath = application.getRealPath("/WEB-INF/member/" + id + "_"+tripId+".txt");
			PrintWriter wr = new PrintWriter(new FileWriter(filePath));
			BufferedWriter bw = new BufferedWriter(wr);

			bw.write(addMoney + "`" + spendingMoney);
			bw.newLine();
			bw.write(tp + "`" + title + "`" + amount + "`" + img + "`" + date + "`" + category);
			bw.newLine();
			bw.close();
			wr.flush();
		}
	} catch (Exception e) {
		System.out.println(e.toString());
	}
%>
<body>
	<meta http-equiv='refresh' content='0; url=tripWallet.jsp?tId=<%=tripId%>'>
</body>