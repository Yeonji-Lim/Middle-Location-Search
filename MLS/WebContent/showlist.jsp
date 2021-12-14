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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9519a3a3b045964f59f79d575c08a44f&libraries=services"></script>
<script>

</script>
<div id ="text"></div>

<script type="text/javascript">
	var list = "<h1>중간장소리스트</h1>";
    var callback = function(result, status) {
        if (status == kakao.maps.services.Status.OK) {
        	list += "<h3>"+result[0].address.address_name +"</h3>";
        }
    };
	function displayMLlist(_x,_y){
	    var geocoder = new kakao.maps.services.Geocoder();
		
	    var coord = new kakao.maps.LatLng(_x,_y);

	    geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
	}
</script>
<%
	Connection conn=null;
	Statement stmt = null;
	ResultSet rs = null;
	String sql = null;
	double x = 0;
	double y = 0;
	String name= request.getParameter("name");
	try{
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost:3306/mls?serverTimezone=UTC";
		conn = DriverManager.getConnection(url,"root","0000");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		sql = "select * from midloc where user_id="+request.getParameter("user_id");
		rs = stmt.executeQuery(sql);
	}
	catch(Exception e)
	{
		out.println("DB연동 오류입니다.:"+e.getMessage());
	}
	while(rs.next())
	{
		x = rs.getDouble("lat");
		y = rs.getDouble("lng");
		%>
		<script type="text/javascript">
			displayMLlist(<%=x %>,<%=y %>);
		</script>

		<%
		
	}
	%>
	<script>
	function a()
	{
		console.log(list);
		console.log(typeof(list));
		var text = document.getElementById("text");
		list +="<a href='index.jsp'>지도로 돌아가기</a>";
		text.innerHTML = list; 
	}
		setTimeout(a, 1000);
	</script>
	
	
	<%
%>



</body>
</html>