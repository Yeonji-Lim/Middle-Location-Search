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
	Connection conn=null;
	Statement stmt = null;
	ResultSet rs = null;
	String sql = null;
	Boolean flag = false;
	String name = null;
	String id = null;
	String num = null;
	try{
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/finalterm?serverTimezone=UTC";
		conn = DriverManager.getConnection(url,"root","0000");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		sql = "select * from member where user='"+request.getParameter("id")+ "' AND password='"+request.getParameter("pw")+"'";
		rs = stmt.executeQuery(sql);
	}
	catch(Exception e)
	{
		out.println("DB연동 오류입니다.:"+e.getMessage());
	}
	if(rs.next())
	{
		flag = true;
		num = rs.getString("id");
		id = rs.getString("user");
		name = rs.getString("name");
	}
	
	if(flag)
	{
		session.setAttribute("name", name);
		session.setAttribute("user", id);
		session.setAttribute("id",num);
		%>
		
		<%=name%>님 로그인을 환영합니다.
		
		<a href="loanbook.jsp">도서 대출로 가기</a>
		
		<%
	}
	else
	{
		%>
		<script>
			alert("회원이 아니거나 비밀번호가 다릅니다.");
			document.location.href ="login.html";
		</script>
		<%
	}
	

%>


</body>
</html>