<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<p>
	<% 
		List result = (List)request.getAttribute("result");
		Iterator it = result.iterator(); 
		while(it.hasNext()) {
			out.print("<br>" + it.next()); 
		}
	%>
	</p>
</body>
</html>