<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page language="java" import="java.util.*"%>
<%@ include file = "connect.jsp" %>

<t:templateHead>
	<jsp:attribute name="pageTitle">Bluelight Online Shop</jsp:attribute>
	<jsp:attribute name="header"></jsp:attribute>
	<jsp:attribute name="content"></jsp:attribute>
</t:templateHead>

<%
	String isAdmin = (String) session.getAttribute("IsAdmin");
	
	if (isAdmin == null || isAdmin.equals("0"))
		response.sendRedirect("home.jsp");
	String name = (String) request.getParameter("name");
	
	String err,mess;
	err = request.getParameter("err");
	mess = request.getParameter("mess");
	
	if (err == null || err.equals("")) {
		err = "";
	}
	if (mess == null || mess.equals("")) {
		mess = "";
	}
	else {
		if (mess.equals("success")) {
			mess = "Delete success";
		}
	}
%>

<div style="width: 100%;">
	<div style="text-align: center">
		<h1 style="color: #FFA300; font-weight: normal">User List</h1>
		
		<form method="post" action="userlist.jsp">
			<span style="color: magenta">Search : </span>
			<input type="text" name="name"/>
			<input type="submit" value="search"/>
		</form>
		
		<table class="withborder" style="text-align: center; margin-top: 20px; margin-left: auto; margin-right: auto">
		<%
			String query;
			String userID;
			
			if (name==null || name.equals(""))
				query = "SELECT UserName, Address, Phone, Email, UserID FROM User WHERE IsAdmin = 0";
			else
				query = "SELECT UserName, Address, Phone, Email, UserID FROM User WHERE IsAdmin = 0 AND UserName LIKE '"+name+"'";
			
			ResultSet rs = st.executeQuery(query);
			%>
			<tr>
				<td>Username</td>
				<td>Address</td>
				<td>Telephone</td>
				<td>Email</td>
				<td>Action</td>
			</tr>
			<%
			
			while(rs.next())
			{
				userID=  rs.getString("UserID");
				%>
				<tr>
				<%
					out.print("<td>"+rs.getString("UserName")+"</td>");
					out.print("<td>"+rs.getString("Address")+"</td>");
					out.print("<td>"+rs.getString("Phone")+"</td>");
					out.print("<td>"+rs.getString("Email")+"</td>");
					out.print("<td><a href=deleteuser.jsp?UserID="+userID+">X</a></td>");
				%>
				</tr>
				<%
			}
		%>
		</table>
		
		<% if (err != null && !err.equals("")) { %>
				<div><span class="error"><%=err%></span></div>
		<% } else if (mess != null && !mess.equals("")) { %>
				<div><span class="message"><%=mess%></span></div>
		<% } %>
	</div>
</div>

<t:templateFoot>
	<jsp:attribute name="footer"></jsp:attribute>
</t:templateFoot>