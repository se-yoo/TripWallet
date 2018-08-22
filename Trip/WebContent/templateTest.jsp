<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trip Wallet</title>
<style>
	@font-face{
		font-family:Nanum;
		src:url('NanumBarunGothicLight.ttf') format('truetype');
	}
	@font-face{
		font-family:tvn;
		src:url('tvN Enjoystories Medium.ttf') format('truetype');
	}
	body{
		color:gray;
		text-align:center;
		font-family:Nanum;
	}
	table{
		text-align:center;
	}
</style>
</head>
<body>
<%
	String contentpage=request.getParameter("CONTENTPAGE");
%>
<table id="table" border="0px" cellpadding="2" cellspacing="0">
<tr height="15%">
	<td style="text-align:center;margin:auto;">
		<a href="main.jsp"><img src="resources/logo.png" width="50%"></a>
	</td>
</tr>
<tr height="75%" style="vertical-align:top; ">
	<td>
		<jsp:include page="<%= contentpage %>"></jsp:include>
	</td>
</tr>
<tr height="10%" style="bottom:10px">
	<td colspan="2" style="text-align:center;">
		<jsp:include page="bottom.jsp" flush="false"/>
	</td>
</tr>
</table>
</body>
</html>