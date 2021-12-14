<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="utf-8">
        <title>Insert title here</title>
    </head>
	<script>
		function send(_name,_user_num,_id){
			alert("asdfaa");
			opener.document.getElementById('name').textContent = _name;
			opener.document.getElementById('opener_user_id').value = _user_num;
			opener.document.getElementById('opener_id').value = _id;
			alert("asdf");
		}

	</script>
    <body>
        <%
	Connection conn=null;
	Statement stmt = null;
	ResultSet rs = null;
	String sql = null;
	Boolean flag = false;
	String id = null;
	String name = null;
	String user_num = null;
	try{
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/mls?serverTimezone=UTC";
		conn = DriverManager.getConnection(url,"root","0000");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		sql = "select * from member where id='"+request.getParameter("id")+ "' AND pw='"+request.getParameter("pw")+"'";
		rs = stmt.executeQuery(sql);
	}
	catch(Exception e)
	{
		out.println("DB연동 오류입니다.:"+e.getMessage());
	}

	if(rs != null && rs.next())
	{
		flag = true;
		id = rs.getString("id");
		name = rs.getString("name");
		user_num = rs.getString("num");
	}
	
	if(flag)
	{
		session.setAttribute("id", id);
		session.setAttribute("name", name);
		session.setAttribute("user_num", user_num);
		%>
        <%=name%>님 로그인을 환영합니다.
		<script>
        	
			opener.document.getElementById('name').textContent = name;
			opener.document.getElementById('opener_user_id').value = user_num;
			opener.document.getElementById('opener_id').value = id;
			send(name,user_num,id);
			sessionStorage.setItem('id',id);
			sessionStorage.setItem('user_num',user_num);
			
			
		</script>
        <input type="button" value="로그인적용" onclick="opener.testalert('<%=name%>','<%=user_num%>','<%=id%>');">
        <%
	}
	else
	{
		%>
        <script>
            alert("회원이 아니거나 비밀번호가 다릅니다.");
            document.location.href = "login.html";
        </script>
        <%
	}

%>
</body>
</html>