<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*"%>
        <%@ page import="java.text.*"%>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="utf-8">
                <title>Insert title here</title>
            </head>

            <body>
                <%
	Connection conn=null;
	Statement stmt = null;
	ResultSet rs = null;
	String sql = null;
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://18.222.142.248:3306/mls?useUnicode=true&characterEncoding=euc-kr";
		conn = DriverManager.getConnection(url,"root","0000");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
		sql = "select * from member where id='"+id+"'";			//아이디 이미 회원
		rs = stmt.executeQuery(sql);
	}
	catch(ClassNotFoundException ex){
		out.println("드라이버 검색 실패");
		ex.printStackTrace();
	}
	catch(SQLException e) {
		e.printStackTrace();
	}
	
	if(rs != null && rs.next())
	{
		%>
        이미 회원입니다.<br>
        <a href="login.html">로그인으로 이동</a>
        <%
	}
    
	else
	{
		try{
			sql = "insert into member(id,pw,name,email) values('"+id+"','"+pw+"','"+name+"','"+email+"')";
			stmt.executeUpdate(sql);
		}
		catch(Exception e)
		{
			out.println("DB연동 오류입니다.:"+e.getMessage());
		}
		%>
                        <%=name %>님 가입을 환영합니다.
                            <a href="login.html">로그인으로 이동</a>
                            <%
	}
	
%>
            </body>

            </html>