<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page language="java" import="java.util.*"%>
<t:templateHead>
	<jsp:attribute name="pageTitle">Bluelight Online Shop</jsp:attribute>
	<jsp:attribute name="header"></jsp:attribute>
	<jsp:attribute name="content"></jsp:attribute>
</t:templateHead>

<%
	if (session.getAttribute("UserID")==null) response.sendRedirect("home.jsp");
	String err=request.getParameter("err");
%>

<div style="width: 100%;">
	<div style="text-align: center">
		<h1 style="color: #FFA300; font-weight: normal">Updating Profile</h1>

		<span style="color: #FF00FF">Change Password Form</span>

		<form method='post' action='dochangepass.jsp'>
			<table style="margin: 0 auto;">
				<tr>
					<td> Old Password </td>
					<td> <input type='password' name='oldpass' />
				</tr>
				<tr>
					<td> New Password </td>
					<td> <input type='password' name='newpass' />
				</tr>
				<tr>
					<td> Confirm New Password </td>
					<td> <input type='password' name='connew' />
				</tr>
				<% if (err != null) { %>
				<tr>
					<td colspan='2'><span class="error"><%=err%></span></td>
				</tr>
				<% } %>
				<tr>
					<td colspan='2'> <input type='submit' value='Change' />
				</tr>
			</table>
		</form>
	</div>
</div>