<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page language="java" import="java.util.*"%>
<t:templateHead>
	<jsp:attribute name="pageTitle">Bluelight Online Shop</jsp:attribute>
	<jsp:attribute name="header"></jsp:attribute>
	<jsp:attribute name="content"></jsp:attribute>
</t:templateHead>

<div style="width: 100%;">

<%
	if (session.getAttribute("UserID") != null) response.sendRedirect("home.jsp");
	String err=request.getParameter("err");
%>

	<div style="text-align: center">
		<h1 style="color: #FFA300; font-weight: normal">REGISTER</h1>

		<span style="color: #FF00FF">Register Form</span>


		<form method='post' action='doregister.jsp'>
			<table style="margin: 0 auto;">
				<tr>
					<td> Username </td>
					<td> <input type='text' name='username' /> </td>
				</tr>
				<tr>
					<td> Password </td>
					<td> <input type='password' name='password' /> </td>
				</tr>
				<tr>
					<td> Confirm Password </td>
					<td> <input type='password' name='conpass' /> </td>
				</tr>
				<tr>
					<td> Address </td>
					<td> <input type='text' name='address' /> </td>
				</tr>
				<tr>
					<td> Telephone </td>
					<td> <input type='text' name='telephone' /> </td>
				</tr>
				<tr>
					<td> Email </td>
					<td> <input type='text' name='email' /> </td>
				</tr>
				<% if (err != null) { %>
				<tr>
					<td colspan='2'><span class="error"><%=err%></span></td>
				</tr>
				<% } %>
				<tr>
					<td colspan='2'> <input type='submit' value='Register' </td>
				</tr>
			</table>
		</form>
	</div>
</div>