<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
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
	String funcID = request.getParameter("funcID");
	String name = request.getParameter("name");
	String desc = request.getParameter("desc");
	String birth = request.getParameter("birth");
	String country = request.getParameter("country");
	//String city = request.getParameter("city");
	String imgTitle = request.getParameter("imgTitle");
	String imgLink = request.getParameter("imgLink");
	String imgGalId = request.getParameter("imgGalId");
	String imgArtId = request.getParameter("imgArtId");
	String imgDetId = request.getParameter("imgDetId");
	String imgYear = request.getParameter("imgYear");
	String imgType = request.getParameter("imgType");
	String imgWidth = request.getParameter("imgWidth");
	String imgHeight = request.getParameter("imgHeight");
	String imgLoc = request.getParameter("imgLoc");
	String imgDesc = request.getParameter("imgDesc");
	String galid = request.getParameter("galid");
	String imgid = request.getParameter("imgid");
	String addImg = request.getParameter("addImg");
	String imgID = request.getParameter("imgID");
	String detailID = request.getParameter("detailID");
	String detDesc = request.getParameter("detDesc");
	String imgTit = request.getParameter("imgTit");
	String arid = request.getParameter("arid");
 	String artID = request.getParameter("artID");
 	String artCount =request.getParameter("artCount");
 	String artDesc = request.getParameter("artDesc");
 	String artBY = request.getParameter("artBY"); 
 	String galName = request.getParameter("galName");
 	String galDesc = request.getParameter("galDesc");
 %>
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
<div id="navigation">`


</div>

<div id="centerDoc">

</div>

<%
	if(galid != null && addImg == null && funcID==null){
		%>
		<div id="centerDoc">
		<div id="display"><center>
		<% 
		try {
			String url="jdbc:mysql://127.0.0.1:3306/gallery";
			String id="gallery";
			String pwd="eecs221";
			Connection con= DriverManager.getConnection(url,id,pwd); 
			Statement stmt;
			stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
			PreparedStatement pstmt;
			ResultSet rs;
			String sql="SELECT * FROM image WHERE gallery_id="+galid;
			rs=stmt.executeQuery(sql); // Result set get the result of the SQL query
			
			out.println("<h1 class=\"textTitle\" style=\"text-align:center\"> Images </h1>");
			int cnt = 0;
			while (rs.next()) {
				cnt++;
				%>			
				<a class="textTitle" href="index.jsp?imgid=<%=rs.getString("image_id")%>&galid=<%=galid%>"> <%=rs.getString("title")%> </a>
				<%
				//out.println("<p class=\"textDesc\" style=\"margin-bottom:10px\" >"+"\""+rs.getString("link")+"\"</p>");
				//out.println("</tr>");
			}
			out.println("<h3 style=\"text-align:center\"> Number of Images : " + cnt + "</h3>");
			%>
			<form method="post">
    			<input name="addImg" type="hidden" value="5">
    			<input class="fbutton" style="font-size:15px" type="submit" value="Add Image"/>
			</form>
			<%
			
			String cntsql = "SELECT *  FROM gallery WHERE gallery_id="+galid;
			ResultSet cs;
			cs = stmt.executeQuery(cntsql);
			while(cs.next()){
			%>
			<form method="post">
    			<input name="funcID" type="hidden" value="10">
    			<input name="galid" type="hidden" value=<%=galid%>>
    			<input name="galName" type="hidden" value=<%=cs.getString("name") %>>
    			<input name="galDesc" type="hidden" value=<%=cs.getString("description") %>>
    			<input class="fbutton" style="font-size:15px" type="submit" value="Edit Gallery"/>
			</form>	
			<%
			}
			cs.close();
			rs.close();
			stmt.close();
			con.close();
		}
		catch(Exception e)
		{
				out.println(e.toString());
		} 	
		
		%>
		</center>
		</div>
		<div id="display2"><center>
		<%
		if(imgid != null){
		try {
			String url="jdbc:mysql://127.0.0.1:3306/gallery";
			String id="gallery";
			String pwd="eecs221";
			Connection con= DriverManager.getConnection(url,id,pwd); 
			Statement stmt;
			PreparedStatement pstmt;
			ResultSet rs;
			stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
			String sql="SELECT * FROM image as t, artist as u, detail as v where t.image_id=v.image_id and t.artist_id = u.artist_id and t.image_id="+imgid;
			rs=stmt.executeQuery(sql); // Result set get the result of the SQL query
			
				
			while (rs.next()) {	
				%>			
				<img class="imgDis" src=<%=rs.getString("link")%>/>
				<%
				out.println("<p class=\"textDesc\" >"+"\" "+rs.getString("v.description")+"\"" +"</p>");
				%>
				<a id="artDet" onclick="details()"> artist : <%=rs.getString("u.name")%> </a>
				<%
				out.println("<p class=\"textDesc\" >"+ rs.getString("v.location")+", "+rs.getString("v.year") +"</p>");
				out.println("<p class=\"textDesc\" >"+"size : \" "+rs.getString("v.width")+"X" + rs.getString("v.height")+", "+rs.getString("v.type") +"</p>");
				%>
				<form method="post">
    				<input name="funcID" type="hidden" value="1">
    				<input name="detailID" type="hidden" value=<%=rs.getString("v.detail_id") %>>
    				<input name="imgID" type="hidden" value=<%=rs.getString("t.image_id") %>>
    				<input class="fbutton" style="font-size:15px" type="submit" value="Delete Image"/>
				</form>	
				
				<form method="post">
    				<input name="funcID" type="hidden" value="4">
    				<input name="detDesc" type="hidden" value=<%=rs.getString("v.description") %>>
    				<input name="imgTit" type="hidden" value=<%=rs.getString("t.title") %>>
    				<input name="imgLink" type="hidden" value=<%=rs.getString("t.link") %>>
    				<input name="imgID" type="hidden" value=<%=rs.getString("t.image_id") %>>
    				<input name="detailID" type="hidden" value=<%=rs.getString("t.detail_id") %>>
    				<input class="fbutton" style="font-size:15px"  type="submit" value="Edit Image"/>
				</form>	
				
				<div id="artDetDiv" style="display:none;">
				<p class="textDesc"> Artist Name :   <%=rs.getString("u.name")%>  </p>
				<p class="textDesc"> Country :   <%=rs.getString("u.country")%>  </p>
				<p class="textDesc"> Birth Year :   <%=rs.getString("u.birth_year")%>  </p>
				<p class="textDesc"> Description :   <%=rs.getString("u.description")%>  </p>
				</div>
				<%
				//out.println("</tr>");
			}
			
			
			rs.close();
			stmt.close();
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
		</div>
		<%
	}		

	if(arid != null &&  addImg == null && funcID == null ){
		%>
		<div id="centerDoc">
		<div id="display"><center>
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
			String sql="SELECT * FROM artist WHERE artist_id="+arid;
			rs=stmt.executeQuery(sql); // Result set get the result of the SQL query
			
			out.println("<h1 class=\"textTitle\" style=\"text-align:center\"> Artist </h1>");
			while (rs.next()) {
				%>
				<p class="textName"> Artist Name: <%=rs.getString("artist.name") %><p>
				<p class="textName"> Country: <%=rs.getString("artist.country") %><p>
				<p class="textName"> Birth year: <%=rs.getString("artist.birth_year") %><p>
				<p class="textName"> Description: <%=rs.getString("artist.description") %><p>
				
				
				<form method="post">
    			<input name="funcID" type="hidden" value="8">
    			<input name="artID" type="hidden" value="<%=rs.getString("artist.artist_id") %>">
    			<input name="artCount" type="hidden" value="<%=rs.getString("artist.country") %>">
    			<input name="artBY" type="hidden" value="<%=rs.getString("artist.birth_year") %>">
    			<input name="artDesc" type="hidden" value="<%=rs.getString("artist.description") %>">
    			<input class="fbutton" style="font-size:15px"  type="submit" value="Edit Details"/>
				</form>
				<% 
			}
			rs.close();
			stmt.close();
			con.close();
			
		%>
		
		
				
				
		</center>
		</div>
		</div>
		<% 	
		}
		catch(Exception e)
		{
				out.println(e.toString());
		} 
	}

	if(addImg != null){
		%>
		<div id="centerDoc">
		<div id="display"><center> 
		<form class="findMe" style="font-size:20px" method="post">
		<input name="funcID" type="hidden" value="6">
		Image title: <input class="finput" name="imgTitle" type="text"><br>
		Image link: <input class="finput" name="imgLink" type="text"><br>
		Gallery ID: <input class="finput" name="imgGalId" value=<%=galid %> type="text"><br>
		Artist ID: <input class="finput"  name="imgArtId" type="text"><br>
		Detail ID: <input class="finput"  name="imgDetId" type="text"><br>
		<b> Image details </b> <br>
		year: <input class="finput" name="imgYear" type="text"><br>
		type: <input class="finput" name="imgType" type="text"><br>
		width: <input class="finput" name="imgWidth" type="text"><br>
		height: <input class="finput"  name="imgHeight" type="text"><br>
		location: <input class="finput" name="imgLoc" type="text"><br>
		description: <input class="finput"   name="imgDesc" type="text"><br>	
		<input class="fbutton" style="font-size:15px"  type="submit" value="Add"/>
		</form>
	
		</div>
		</div>		
	<%
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
				stmt = con.createStatement(); // Statements allow to issue SQL queries to the database
				String sql="DELETE FROM detail where detail.detail_id="+detailID;
				int rst=stmt.executeUpdate(sql); // Result set get the result of the SQL query
				
				%>
				<div id=centerDoc>
				<div id=display><center>
				<%
				
				//while (rs.next()) {
					out.println("<p class=\"textCom\">Successfully Deleted Details of Image</p>");
				//}
				
				String isql="DELETE FROM image where image.image_id="+imgID;
				int rst2=stmt.executeUpdate(isql); // Result set get the result of the SQL query
				//while (rs.next()) {
					out.println("<p class=\"textCom\">Successfully Deleted the Image</p>");
				//}
				//rs.close();
				stmt.close();
				%>
				</center>
				</div>
				</div>
				
				<%
				break;
			case 2:
				// PreparedStatements can use variables and are more efficient
				pstmt = con.prepareStatement("insert into gallery values (default,?,?)",Statement.RETURN_GENERATED_KEYS);
				// Use ? to represent the variables
				pstmt.clearParameters();
				// Parameters start with 1
				pstmt.setString(1, name);
				pstmt.setString(2, desc);
				//pstmt.setString(3, city);
				pstmt.executeUpdate();
				rs=pstmt.getGeneratedKeys();
				%>
				<div id=centerDoc>
				<div id=display>
				<%
				while (rs.next()) {
					out.println("<p class=\"textCom\">"+ "Successfully added the new gallery"+"</p>");
				}
				%>
				</div>
				</div>
				<% 
				rs.close();
				pstmt.close();
				break;
				
			case 3:
				// PreparedStatements can use variables and are more efficient
				pstmt = con.prepareStatement("insert into artist values (default,?,?,?,?)",Statement.RETURN_GENERATED_KEYS);
				// Use ? to represent the variables
				pstmt.clearParameters();
				// Parameters start with 1
				pstmt.setString(1, name);
				pstmt.setString(2, birth);
				pstmt.setString(3, country);
				pstmt.setString(4, desc);
				pstmt.executeUpdate();
				rs=pstmt.getGeneratedKeys();
				%>
				<div id=centerDoc>
				<div id=display>
				<%
				while (rs.next()) {
					out.println("<p class=\"textCom\">Successfully added the new artist</p>");
				}
				%>
				</div>
				</div>
				<% 
				rs.close();
				pstmt.close();
				break;
				
				
			case 4:
				
				%>
				<div id=centerDoc>
				<div id=display><center>
				<form class="findMe" style="font-size:20px" method="post">
	    			<input name="funcID" type="hidden" value="7">
	    			<input name="imgID" type="hidden" value=<%=imgID %>>
	    			<input name="detailID" type="hidden" value=<%=detailID %>>
					Image title: <input class="finput" name="imgTitle" value=<%=imgTit %> type="text"><br>
					Image link: <input class="finput" name="imgLink" value=<%=imgLink %> type="text"><br>
					Image description: <input class="finput" name="imgDesc" value=<%=detDesc %> type="text"><br>				
	    			<input class="fbutton" style="font-size:15px"  type="submit" value="Submit"/>
				</form>
				
				</center>
				</div>
				</div>
				<%
				
				break;
				
			case 5:
				%>
				<div id=centerDoc>
				<div id=display>
				<form class="findMe" style="font-size:20px" method="post">
	    			<input name="funcID" type="hidden" value="6">
					Image title: <input class="finput" name="imgTitle" type="text"><br>
					Image link: <input class="finput" name="imgLink" type="text"><br>
					Artist ID: <input class="finput" name="imgArtId" type="text"><br>
					<b> Image details </b>
					Year: <input class="finput"  name="imgYear" type="text"><br>
					type: <input class="finput" name="imgType" type="text"><br>
					width: <input class="finput" name="imgWidth" type="text"><br>
					height: <input class="finput"  name="imgHeight" type="text"><br>
					description: <input class="finput" name="imgDesc" type="text"><br>				
	    			<input class="fbutton" style="font-size:15px"  type="submit" value="Add"/>
				</form>
				
				
				</div>
				</div>
				<%
				break;
				
				
			case 6:
				// PreparedStatements can use variables and are more efficient
				pstmt = con.prepareStatement("insert into image values (default,?,?,?,?,?)",Statement.RETURN_GENERATED_KEYS);
				// Use ? to represent the variables
				pstmt.clearParameters();
				// Parameters start with 1
				pstmt.setString(1, imgTitle);
				pstmt.setString(2, imgLink);
				pstmt.setString(3, imgGalId);
				pstmt.setString(4, imgArtId);
				pstmt.setString(5, imgDetId);
				pstmt.executeUpdate();
				rs=pstmt.getGeneratedKeys();
				String imgt = "";
				%>
				<div id=centerDoc>
				<div id=display><center>
				<%
				while (rs.next()) {
					imgt = ""+rs.getInt(1);
					out.println("<p class=\"textCom\">Successfully added the new Image</p>");
				}
				 
				pstmt = con.prepareStatement("insert into detail values (?,?,?,?,?,?,?,?)",Statement.RETURN_GENERATED_KEYS);
				// Use ? to represent the variables
				pstmt.clearParameters();
				// Parameters start with 1
				pstmt.setString(1, imgDetId);
				pstmt.setString(2, imgt);
				pstmt.setString(3, imgYear);
				pstmt.setString(4, imgType);
				pstmt.setString(5, imgWidth);
				pstmt.setString(6, imgHeight);
				pstmt.setString(7, imgLoc);
				pstmt.setString(8, imgDesc);
				pstmt.executeUpdate();
				rs=pstmt.getGeneratedKeys();
				
				while (rs.next()) {
					out.println("<p class=\"textCom\">Successfully added the new Image detals</p>");
				}
				%>
				</center>
				</div>
				</div>
				<% 
				rs.close();
				pstmt.close();
				break;
				
			case 7:
				// PreparedStatements can use variables and are more efficient
				pstmt = con.prepareStatement("UPDATE image SET title=?, link=? WHERE image_id=?",Statement.RETURN_GENERATED_KEYS);
				// Use ? to represent the variables
				pstmt.clearParameters();
				// Parameters start with 1
				pstmt.setString(1, imgTitle);
				pstmt.setString(2, imgLink);
				pstmt.setString(3, imgID);
				pstmt.executeUpdate();
				rs=pstmt.getGeneratedKeys();
				%>
				<div id=centerDoc>
				<div id=display><center>
				<%
				out.println("<p class=\"textCom\">Successfully updated the Image</p>");
				
				
				pstmt = con.prepareStatement("UPDATE detail SET description=? WHERE detail_id=?",Statement.RETURN_GENERATED_KEYS);
				// Use ? to represent the variables
				pstmt.clearParameters();
				// Parameters start with 1
				pstmt.setString(1, imgDesc);
				pstmt.setString(2, detailID);
				pstmt.executeUpdate();
				rs=pstmt.getGeneratedKeys();
				
				out.println("<p class=\"textCom\">Successfully updated the Image details</p>");
				
				%>
				</center>
				</div>
				</div>
				<%
				
			case 8:
				%>
				<div id=centerDoc>
				<div id=display><center>
				<form class="findMe" style="font-size:20px" method="post">
	    			<input name="funcID" type="hidden" value="9">
	    			<input name="artID" type="hidden" value=<%=artID%>>
					Country: <input class="finput" name="artCount" value=<%=artCount%> type="text"><br>
					Birth Year: <input class="finput" name="artBY" value=<%=artBY%> type="text"><br>
					Description: <input class="finput" name="artDesc" value=<%=artDesc%> type="text"><br>			
	    			<input class="fbutton" style="font-size:15px"  type="submit" value="Submit"/>
				</form>
				
				</center>
				</div>
				</div>
				<%
				break;
				
			case 9:
				// PreparedStatements can use variables and are more efficient
				pstmt = con.prepareStatement("UPDATE artist SET birth_year=?, country=?, description=? WHERE artist_id=?",Statement.RETURN_GENERATED_KEYS);
				// Use ? to represent the variables
				pstmt.clearParameters();
				// Parameters start with 1
				pstmt.setString(1, artBY);
				pstmt.setString(2, artCount);
				pstmt.setString(3, artDesc);
				pstmt.setString(4, artID);
				pstmt.executeUpdate();
				rs=pstmt.getGeneratedKeys();
				%>
				<div id=centerDoc>
				<div id=display><center>
				<%
				out.println("<p class=\"textCom\">Successfully updated the Artist</p>");
				%>
				</center>
				</div>
				</div>
				<%
				
			case 10:
				%>
				<div id=centerDoc>
				<div id=display><center>
				<form class="findMe" style="font-size:20px" method="post">
	    			<input name="funcID" type="hidden" value="11">
	    			<input name="galid" type="hidden" value=<%=galid%>>
					Name: <input class="finput" name="galName" value=<%=galName%> type="text"><br>
					Description: <input class="finput" 	name="galDesc" value=<%=galDesc%> type="text"><br>			
	    			<input class="fbutton" style="font-size:15px" type="submit" value="Submit"/>
				</form>
				
				</center>
				</div>
				</div>
				<%
				break;
				
			case 11:
				// PreparedStatements can use variables and are more efficient
				pstmt = con.prepareStatement("UPDATE gallery SET Name=?, description=? WHERE gallery_id=?",Statement.RETURN_GENERATED_KEYS);
				// Use ? to represent the variables
				pstmt.clearParameters();
				// Parameters start with 1
				pstmt.setString(1, galName);
				pstmt.setString(2, galDesc);
				pstmt.setString(3, galid);
				pstmt.executeUpdate();
				rs=pstmt.getGeneratedKeys();
				%>
				<div id=centerDoc>
				<div id=display><center>
				<%
				out.println("<p class=\"textCom\">Successfully updated the gallery</p>");
				%>
				</center>
				</div>
				</div>
				<%
		}
		con.close();
	}
	catch(Exception e)
	{
			out.println(e.toString());
	} 	
	
} %>


  <script>
  function details(){
	  document.getElementById('artDetDiv').style.display="block";
  }
  </script>
  </body>
</html>
