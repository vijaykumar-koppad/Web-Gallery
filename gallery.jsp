<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Gallery</title>
<link rel="stylesheet"  type="text/css" href="style.css">

</head>
  

<body>

<%
	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
	}
	catch(Exception e)
	{
		out.println("can't load mysql driver");
		out.println(e.toString());
	}
%>

<div><center>

<%
        String url="jdbc:mysql://127.0.0.1:3306/gallery";
		String id="gallery";
		String pwd="eecs221";
		Connection con= DriverManager.getConnection(url,id,pwd); 
	
		//int func=Integer.valueOf(funcID);
		Statement stmt;
		PreparedStatement pstmt;
		ResultSet rs;
		
				stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
				String sql="SELECT * FROM gallery";
				rs=stmt.executeQuery(sql); // Result set get the result of the SQL query
				
				//out.println("<table border=\"1\" width=\"400\">");
				out.println("<h1 > Galleries </h1>");
				/*out.println("<tr>");
				out.println("<th>ID</th>");
				out.println("<th>Name</th>");
				out.println("<th>Description</th>");
//				out.println("<th>City</th>");
				out.println("</tr>");*/
				while (rs.next()) {
					/*out.println("<tr>");
					out.println("<td>"+rs.getString("gallery_id")+"</td>");
					out.println("<td>"+rs.getString("name")+"</td>");
					out.println("<td>"+rs.getString("description")+"</td>");*/
					//out.println("<td>"+rs.getString("customer_city")+"</td>");
					%>
					<a class="textName" href="index.jsp?galid=<%=rs.getString("gallery_id")%>"> <%=rs.getString("name")%> </a>
					<%
					out.println("<p class=\"textDesc\" style=\"margin-bottom:10px\" >"+"\""+rs.getString("description")+"\"</p>");
					//out.println("</tr>");
				}
				
				
				rs.close();
				stmt.close();
				out.println("</table>");
				con.close();
				
%>
</center>
</div>

<div style="margin-top:20px">

<p class="textName">Add a new Gallery:</p>

<form class="textName" style="font-size:12px" method="post">
    		<input name="funcID" type="hidden" value="2">
		Gallery Name: <input class="finput" name="name" type="text"><br>
		Description: <input class="finput" name="desc" type="text"><br>		
    		<input class="fbutton" style="font-size:15px" type="submit" value="Add"/>
</form>


</div>

</body>

</html>