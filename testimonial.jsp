<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page language="java" import="java.util.*"%>
<%@ include file = "connect-sample.jsp" %>
<t:templateHead>
	<jsp:attribute name="pageTitle">Bluelight Online Shop</jsp:attribute>
	<jsp:attribute name="header"></jsp:attribute>
	<jsp:attribute name="content"></jsp:attribute>
</t:templateHead>

<div style="width: 100%;">
	<div style="text-align: center">
		<h1 style="color: #FFA300; font-weight: normal">Testimonial Board</h1>
		
		<table style="margin: 0 auto; text-align: left">
			<%
				String query = "SELECT UserName, Testimony FROM Testimony INNER JOIN User ON User.UserID = Testimony.UserID";
				ResultSet rs = stmt.executeQuery(query);
				
				while(rs.next())
				{
					%>
					<tr>
					<td style="color: green" width="80">
					<%
					out.print(rs.getString("UserName"));
					%>
					</td>
					<td width="250">
					<%
					out.print(rs.getString("Testimony"));
					%>
					</td>
					</tr>
					<%
				}
			%>
		</table>
		
	</div>
</div>

<t:templateFoot>
	<jsp:attribute name="footer"></jsp:attribute>
</t:templateFoot>