<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page language="java" import="java.util.*"%>
<%@ include file = "connect.jsp" %>

<t:templateHead>
	<jsp:attribute name="pageTitle">Bluelight Online Shop</jsp:attribute>
	<jsp:attribute name="header"></jsp:attribute>
	<jsp:attribute name="content"></jsp:attribute>
</t:templateHead>
<%
	String err,mess;
	err = request.getParameter("err");
	mess = request.getParameter("mess");
	
	if (err == null || err.equals("")) {
		err = "";
	}
	else {
		if (err.equals("empty")) {
			err = "testimony must be filled";
		}
		else
		if (err.equals("toofew")) {
			err = "testimony must contain at least 15 characters";
		}
	}
	if (mess == null || mess.equals("")) {
		mess = "";
	}
	else {
		if (mess.equals("success")) {
			mess = "Register success";
		}
	}
%>

<div style="width: 100%;">
	<div style="text-align: center">
		<h1 style="color: #FFA300; font-weight: normal">Testimonial Board</h1>

		<table style="margin: 0 auto; text-align: left">
			<%
				String query = "SELECT User.UserName, Testimony.Testimony FROM Testimony INNER JOIN User ON User.UserID = Testimony.UserID ORDER BY TestimonyID";
				ResultSet rs = stmt.executeQuery(query);
	
				String username= (String)session.getAttribute("username");
				String isAdmin = (String) session.getAttribute("IsAdmin");
				
				while(rs.next())
				{
					%>
					<tr>
					<td style="color: green" width="80">
					<%
					String name=rs.getString("UserName");
					out.print(name);
					%>
					</td>
					<td width="250">
					<%
					out.print(rs.getString("Testimony"));
					%>
					</td>
					<%
					
					if (isAdmin != null)
					{
						if (isAdmin.equals("1"))
						{
							//admin
							%>
							<td>
							<a href=#>X</a>
							</td>
							<%
						}
						else
						{
							//member
							if (name.equals(username))
							{
							%>
							<td>
							<a href=#>EDIT</a>
							</td>
							<td>
							<a href=#>X</a>
							</td>
							<%
							}
						}
					}
					%>
					</tr>
					<%
				}
			%>
		</table>
		
		<%
			if (isAdmin!=null)
			{
				//logged in
				%>
					<h5 style="color: aqua">Testimonial Editor</h5>
					<% if (err != null && !err.equals("")) { %>
								<div><span class="error"><%=err%></span></div>
					<% } else if (mess != null && !mess.equals("")) { %>
								<div><span class="message"><%=mess%></span></div>
					<% } %>
					<form method="post" action="addtestimonial.jsp">
						<textarea rows="4" cols="40" name="testimony"></textarea>
						</br>
						<input type="submit" value="Submit"/>
					</form>
				<%
			}
		%>
	</div>
</div>

<t:templateFoot>
	<jsp:attribute name="footer"></jsp:attribute>
</t:templateFoot>