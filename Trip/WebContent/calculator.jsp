<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String) session.getAttribute("id");
	String country=request.getParameter("country");
	
	if (id == null) {
		response.sendRedirect("login.jsp");
	} else {
%><jsp:forward page="templateTest.jsp">
<jsp:param name="CONTENTPAGE" value="calculatorProc.jsp?country=<%=country%>" />
</jsp:forward>
<%
	}
%>