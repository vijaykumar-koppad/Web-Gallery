<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%>

 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Artist</title>
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
try {
		String url="jdbc:mysql://127.0.0.1:3306/gallery";
		String id="gallery";
		String pwd="eecs221";
		Connection con= DriverManager.getConnection(url,id,pwd); 
	
		Statement stmt;
		PreparedStatement pstmt;
		ResultSet rs;
				stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
				String artsql="SELECT * FROM artist";
				rs=stmt.executeQuery(artsql); // Result set get the result of the SQL query
				//out.println("<table border=\"1\" width=\"400\">");
				out.println("<h1> <u>Artist List</u> </h1>");
				/*out.println("<tr>");
				out.println("<th>ID</th>");
				out.println("<th>Name</th>");
				out.println("<th>Birth year</th>");
				out.println("<th>Country</th>");
				out.println("<th>Description</th>");
				out.println("</tr>");*/
				while (rs.next()) {
					/*out.println("<tr>");
					out.println("<td>"+rs.getString("artist_id")+"</td>");
					out.println("<td>"+rs.getString("name")+"</td>");
					out.println("<td>"+rs.getString("birth_year")+"</td>");
					out.println("<td>"+rs.getString("country")+"</td>");
					out.println("<td>"+rs.getString("description")+"</td>");
					out.println("</tr>");*/
					%>
					<a class="textName" href="index.jsp?arid=<%=rs.getString("artist_id")%>"> <%=rs.getString("name")%> </a>
					<%
					//out.println("<p class=\"textDesc\">"+rs.getString("country")+", DoB-"+rs.getString("birth_year")+"</p>");
					out.println("<p class=\"textDesc\" style=\"margin-bottom:10px\">"+"\""+rs.getString("description")+"\"</p>");
				}
		
				rs.close();
				stmt.close();
				out.println("</table>");
				
		
				
					con.close();
	}
	catch(Exception e)
	{
			out.println(e.toString());
	}
%>
</center>
</div>
<div style="margin-top:20px" >

<p class="textName"> Add a new Artist:</p>
<form class="textName" style="font-size:12px" method="post">
    		<input name="funcID" type="hidden" value="3">
		Artist Name: <input  class="finput" name="name" type="text"><br>
		Birth_year: <input  class="finput" name="birth" type="text"><br>
		Country: <input  class="finput" name="country" type="text"><br>
		Description: <input  class="finput" name="desc" type="text"><br>		
    		<input class="fbutton" style="font-size:15px" type="submit" value="Add"/>
</form>

</div>



</body>
</html>