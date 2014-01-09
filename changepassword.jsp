<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page language="java" import="java.util.*"%>
<t:templateHead>
	<jsp:attribute name="pageTitle">Bluelight Online Shop</jsp:attribute>
	<jsp:attribute name="header"></jsp:attribute>
	<jsp:attribute name="content"></jsp:attribute>
</t:templateHead>
<%
if (session.getAttribute("UserID") == null)
{
	// not logged in
	response.sendRedirect("home.jsp?err=nosession"); return;
}
%>
<%
String err = request.getParameter("err");
String mess = request.getParameter("mess");
if (err != null)
{
	if (err.equals("wrongpassword")) {
		err = "Wrong Password";
	}
	else if (err.equals("confirmpassword")) {
		err = "New Password and Confirm New Password must be the same";
	}
	else if (err.equals("oldempty")) {
		err = "Old Password must be filled";
	}
	else if (err.equals("newempty")) {
		err = "New Password must be filled";
	}
	else if (err.equals("conempty")) {
		err = "Confirm New Password must be filled";
	}
	else {
		err = "unknown error";
	}
}
else if (mess != null) {
	if (mess.equals("success")) {
		mess = "Password changed";
	}
}
%>
<div style="width: 100%;">
	<div style="text-align: center">
		<h1 style="color: #FFA300; font-weight: normal">Updating Profile</h1>

		<span style="color: #FF00FF">Change Password Form</span>
		<form method='post' action='action/dochangepass.jsp'>
			<table style="margin: 0 auto; text-align: left;">
				<tr>
					<td>Old Password</td>
					<td>:</td>
					<td><input type='password' name='old' /></td>
				</tr>
				<tr>
					<td>New Password</td>
					<td>:</td>
					<td><input type='password' name='new' /></td>
				</tr>
				<tr>
					<td>Confirm New Password</td>
					<td>:</td>
					<td><input type='password' name='connew' /></td>
				</tr>
			</table>
<% if (err != null) { %>
			<div><span class="error"><%=err%></span></div>
<% } else if (mess != null) { %>
			<div><span class="message"><%=mess%></span></div>
<% } %>
			<input type='submit' value='Change Password' />
		</form>

	</div>

</div>

<t:templateFoot>
	<jsp:attribute name="footer"></jsp:attribute>
</t:templateFoot>