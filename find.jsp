<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%> 
    
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    
    <title>Gallery</title>
    <link rel="stylesheet"  type="text/css" href="style.css">
	    
	<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.11.2.min.js"> </script>
	
	<script>
	
	$(function(){
	$("#gal").click(function (){
	    $('#navigation').load('gallery.jsp');
	});
	});
	
	$(function(){
		$("#art").click(function (){
		    $('#navigation').load('artist.jsp');
		});
		});	
	
	$(function(){
		$("#art").click(function (){
		    $('#navigation').load('artist.jsp');
		});
		});	
	</script>
	
  </head>
<body>

<div id="header"> 
  <div id="Name">
  		ChitraShale
  </div>

  	<div id="gal" name="Gallery">Gallery</div>

	<div id="art" name="Artist">Artist</div>
	
	<a id="art" href="find.jsp" style="text-decoration:none" name="Find">Find</a>
  
  </div>

<%
	String funcID =  request.getParameter("funcID");
	String imgType =  request.getParameter("imgType");	
	String imgid =  request.getParameter("imgid");
	String syear =  request.getParameter("syear");
	String eyear =  request.getParameter("eyear");
	String artName =  request.getParameter("artName");
	String locName =  request.getParameter("locName");
	String artCount =  request.getParameter("artCount");
	String artBY =  request.getParameter("artBY");
	String arid =  request.getParameter("arid");
	
	try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
	}
	catch(Exception e)
	{
		out.println("can't load mysql driver");
		out.println(e.toString());
	}
%>
<div id="navigation"><center>


<form class="findMe" method="post">
    		<input name="funcID" type="hidden" value="1">
    		<input class="fbutton" type="submit" value="Images by type"/>
</form>


<form class="findMe" method="post">
    		<input name="funcID" type="hidden" value="3">
    		<input class="fbutton" type="submit" value="Images by year"/>
</form>


<form class="findMe" method="post">
    		<input name="funcID" type="hidden" value="5">
    		<input class="fbutton" type="submit" value="Images by artist"/>
</form>


<form class="findMe" method="post">
    		<input name="funcID" type="hidden" value="7">
    		<input class="fbutton" type="submit" value="Images by location"/>
</form>


<form class="findMe" method="post">
    		<input name="funcID" type="hidden" value="9">
    		<input class="fbutton" type="submit" value="Artists by country"/>
</form>

<form class="findMe" method="post">
    		<input name="funcID" type="hidden" value="11">
    		<input class="fbutton" type="submit" value="Artists by birth year"/>
</form>

</center>
</div>

<div id=centerDoc>
<div id=Display><center>

<%

if(arid !=null){
	try {
		String url="jdbc:mysql://127.0.0.1:3306/gallery";
		String id="gallery";
		String pwd="eecs221";
		Connection con= DriverManager.getConnection(url,id,pwd); 
	
		Statement stmt;
		PreparedStatement pstmt;
		ResultSet rs;
		pstmt = con.prepareStatement("SELECT * FROM artist WHERE artist_id=?",Statement.RETURN_GENERATED_KEYS);
		// Use ? to represent the variables
		pstmt.clearParameters();
		// Parameters start with 1
		pstmt.setString(1, arid);
		rs = pstmt.executeQuery();
		out.println("<h1 class=\"textTitle\" style=\"text-align:center\"> Artist </h1>");
		while (rs.next()) {
			%>
			
			<p class="textName"> Artist Name: <%=rs.getString("artist.name") %><p>
			<p class="textName"> Country: <%=rs.getString("artist.country") %><p>
			<p class="textName"> Birth year: <%=rs.getString("artist.birth_year") %><p>
			<p class="textName"> Description: <%=rs.getString("artist.description") %><p>
		</center>
		</div>
		<%
		
	}
		
	rs.close();
	pstmt.close();	
	con.close();
}	

catch(Exception e)
{
		out.println(e.toString());
} 
}
%>




<% if(funcID!=null) {
	try {
		String url="jdbc:mysql://127.0.0.1:3306/gallery";
		String id="gallery";
		String pwd="eecs221";
		Connection con= DriverManager.getConnection(url,id,pwd); 
	
		int func=Integer.valueOf(funcID);
		Statement stmt;
		PreparedStatement pstmt;
		ResultSet rs;
		switch(func) {
			case 1:
				%>
				
					<form class="findMe" method="post">
    				<input name="funcID" type="hidden" value="2">
    				Image type : <input class="finput" name="imgType" type="text">
    				<input class="fbutton" type="submit" value="Find"/>
    				
					</form>
				<%
				
				break;
				
			case 2:
				
				// PreparedStatements can use variables and are more efficient
				pstmt = con.prepareStatement("SELECT * FROM image natural join detail WHERE type=?",Statement.RETURN_GENERATED_KEYS);
				// Use ? to represent the variables
				pstmt.clearParameters();
				// Parameters start with 1
				pstmt.setString(1, imgType);
				rs = pstmt.executeQuery();
				//rs=pstmt.getGeneratedKeys();
				%>
				<h1 class=testTitle > Images of type <%=imgType%></h1>
				<%
				while (rs.next()) {
					%>
					
					<a class="textName" href="find.jsp?imgid=<%=rs.getString("image_id")%> &funcID=<%=funcID%>"> <%=rs.getString("title")%> </a>
					
					<%				
				}
				%>
				<div id="display"><center>
				<%
				if(imgid !=null){
					pstmt = con.prepareStatement("SELECT * FROM image natural join detail WHERE image_id=?",Statement.RETURN_GENERATED_KEYS);
					// Use ? to represent the variables
					pstmt.clearParameters();
					// Parameters start with 1
					pstmt.setString(1, imgid);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						%>
							<img class="imgDis" src=<%=rs.getString("link")%>/>
							<p class="textDesc" > "<%=rs.getString("description")%>"</p>
							
						</center>
						</div>
						<%
						
					}
				}
				rs.close();
				pstmt.close();
				break;
				
			case 3:
				%>
				
					<form class="findMe" method="post">
    				<input name="funcID" type="hidden" value="4">
    				Images created between : <input class="finput" style="width: 100px" name="syear" type="text">
    				and  <input class="finput" name="eyear" style="width: 100px" type="text">
    				<input class="fbutton" type="submit" value="Find"/>
    				
					</form>
				<%
				
				break;
				
			case 4:
				
				// PreparedStatements can use variables and are more efficient
				pstmt = con.prepareStatement("SELECT * FROM image natural join detail WHERE year>? and year<? ",Statement.RETURN_GENERATED_KEYS);
				// Use ? to represent the variables
				pstmt.clearParameters();
				// Parameters start with 1
				pstmt.setString(1, syear);
				pstmt.setString(2, eyear);
				rs = pstmt.executeQuery();
				//rs=pstmt.getGeneratedKeys();
				%>
				<h1 class=testTitle > Images created between <%=syear%> and <%=eyear%></h1>
				<% 
				while (rs.next()) {
					%>
					<a class="textName" href="find.jsp?imgid=<%=rs.getString("image_id")%> &funcID=<%=funcID%>"> <%=rs.getString("title")%> </a>
					
					<%				
				}
				%>
				<div id="display"><center>
				<%
				if(imgid !=null){
					pstmt = con.prepareStatement("SELECT * FROM image natural join detail WHERE image_id=?",Statement.RETURN_GENERATED_KEYS);
					// Use ? to represent the variables
					pstmt.clearParameters();
					// Parameters start with 1
					pstmt.setString(1, imgid);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						%>
							<img class="imgDis" src=<%=rs.getString("link")%>/>
							<p class="textDesc" > "<%=rs.getString("description")%>"</p>
							
						</center>
						</div>
						<%
						
					}
				}
				rs.close();
				pstmt.close();
				break;
				
				
			case 5:
				%>
				
					<form class="findMe" method="post">
    				<input name="funcID" type="hidden" value="6">
    				Artist Name : <input class="finput" name="artName" type="text">
    				<input class="fbutton" type="submit" value="Find"/>
    				
					</form>
				<%
				
				break;
				
			case 6:
				
				// PreparedStatements can use variables and are more efficient
				pstmt = con.prepareStatement("SELECT * FROM image natural join artist WHERE name=?",Statement.RETURN_GENERATED_KEYS);
				// Use ? to represent the variables
				pstmt.clearParameters();
				// Parameters start with 1
				pstmt.setString(1, artName);
				rs = pstmt.executeQuery();
				//rs=pstmt.getGeneratedKeys();
				%>
				<h1 class=testTitle > Images created by <%=artName%></h1>
				<%
				while (rs.next()) {
					%>
					
					<a class="textName" href="find.jsp?imgid=<%=rs.getString("image_id")%> &funcID=<%=funcID%>"> <%=rs.getString("title")%> </a>
					
					<%				
				}
				%>
				<div id="display"><center>
				<%
				if(imgid !=null){
					pstmt = con.prepareStatement("SELECT * FROM image natural join detail WHERE image_id=?",Statement.RETURN_GENERATED_KEYS);
					// Use ? to represent the variables
					pstmt.clearParameters();
					// Parameters start with 1
					pstmt.setString(1, imgid);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						%>
							<img class="imgDis" src=<%=rs.getString("link")%>/>
							<p class="textDesc" > "<%=rs.getString("description")%>"</p>
							
						</center>
						</div>
						<%
						
					}
				}
				rs.close();
				pstmt.close();
				break;
				
				
			case 7:
				%>
				
					<form class="findMe" method="post">
    				<input name="funcID" type="hidden" value="8">
    				Name of the place : <input class="finput" name="locName" type="text">
    				<input class="fbutton" type="submit" value="Find"/>
    				
					</form>
				<%
				
				break;
				
			case 8:
				
				// PreparedStatements can use variables and are more efficient
				pstmt = con.prepareStatement("SELECT * FROM image natural join detail WHERE location=?",Statement.RETURN_GENERATED_KEYS);
				// Use ? to represent the variables
				pstmt.clearParameters();
				// Parameters start with 1
				pstmt.setString(1, locName);
				rs = pstmt.executeQuery();
				//rs=pstmt.getGeneratedKeys();
				%>
				<h1 class=testTitle > Images created in <%=locName%></h1>
				<%
				while (rs.next()) {
					%>
					
					<a class="textName" href="find.jsp?imgid=<%=rs.getString("image_id")%> &funcID=<%=funcID%>"> <%=rs.getString("title")%> </a>
					
					<%				
				}
				%>
				<div id="display"><center>
				<%
				if(imgid !=null){
					pstmt = con.prepareStatement("SELECT * FROM image natural join detail WHERE image_id=?",Statement.RETURN_GENERATED_KEYS);
					// Use ? to represent the variables
					pstmt.clearParameters();
					// Parameters start with 1
					pstmt.setString(1, imgid);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						%>
							<img class="imgDis" src=<%=rs.getString("link")%>/>
							<p class="textDesc" > "<%=rs.getString("description")%>"</p>
							
						</center>
						</div>
						<%
						
					}
				}
				rs.close();
				pstmt.close();
				break;
				
		
			case 9:
				%>
				
					<form class="findMe" method="post">
    				<input name="funcID" type="hidden" value="10">
    				Name of the Country : <input class="finput" name="artCount" type="text">
    				<input class="fbutton" type="submit" value="Find"/>
    				
					</form>
				<%
				
				break;
				
			case 10:
				
				// PreparedStatements can use variables and are more efficient
				pstmt = con.prepareStatement("SELECT * FROM artist WHERE country=?",Statement.RETURN_GENERATED_KEYS);
				// Use ? to represent the variables
				pstmt.clearParameters();
				// Parameters start with 1
				pstmt.setString(1, artCount);
				rs = pstmt.executeQuery();
				//rs=pstmt.getGeneratedKeys();
				%>
				<h1 class=testTitle > Artists from <%=artCount%></h1>
				<%
				while (rs.next()) {
					%>
					
					<a class="textName" href="find.jsp?arid=<%=rs.getString("artist_id")%>"> <%=rs.getString("name")%> </a>
					
					<%				
				}
				
				
				rs.close();
				pstmt.close();
				break;
				
			
			case 11:
				%>
				
					<form class="findMe" method="post">
    				<input name="funcID" type="hidden" value="12">
    				Birth year  : <input class="finput" name="artBY" type="text">
    				<input class="fbutton" type="submit" value="Find"/>
    				
					</form>
				<%
				
				break;
				
			case 12:
				
				// PreparedStatements can use variables and are more efficient
				pstmt = con.prepareStatement("SELECT * FROM artist WHERE birth_year=?",Statement.RETURN_GENERATED_KEYS);
				// Use ? to represent the variables
				pstmt.clearParameters();
				// Parameters start with 1
				pstmt.setString(1, artBY);
				rs = pstmt.executeQuery();
				//rs=pstmt.getGeneratedKeys();
				%>
				<h1 class=testTitle > Artists born in the year <%=artBY%></h1>
				<%
				while (rs.next()) {
					%>
					
					<a class="textName" href="find.jsp?arid=<%=rs.getString("artist_id")%>"> <%=rs.getString("name")%> </a>
					
					<%				
				}
				
				
				rs.close();
				pstmt.close();
				break;
		}
		
		con.close();
	}	
	
	catch(Exception e)
	{
			out.println(e.toString());
	} 
	
}
%>
</center>
</div>
<div id="display2"></div>	
</div>



</body>
</html>