<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	String sql_update = null;
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String id, pw, name, email;
	int cnt;
	id = request.getParameter("id");
	pw = request.getParameter("pw");
	name = request.getParameter("name");
	email = request.getParameter("email");
	
	
	
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/mls?serverTimezone=UTC";
		conn = DriverManager.getConnection(url,"root","0000");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		sql_update = "insert into user values ('"+id+"','"+pw+"','"+name+"','"+email+"')";
		stmt.executeUpdate(sql_update);
	}
	catch(Exception e)
	{
		out.println("DB연동 오류입니다.:"+e.getMessage());
	}

%>
</body>
</html>