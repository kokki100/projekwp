<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page language="java" import="java.util.*"%>
<t:templateHead>
	<jsp:attribute name="pageTitle">Bluelight Online Shop</jsp:attribute>
	<jsp:attribute name="header"></jsp:attribute>
	<jsp:attribute name="content"></jsp:attribute>
</t:templateHead>

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
	Updating Profile <br />
	Change Password Form <br />
	<form method='post' action='dochangepass.jsp'>
		<table>
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
		<input type='submit' value='Change Password' />
	</form>
<% if (err != null) { %>
	<span class="error"><%=err%></span>
<% } else if (mess != null) { %>
	<span class="message"><%=mess%></span>
<% } %>
</div>

<t:templateFoot>
	<jsp:attribute name="footer"></jsp:attribute>
</t:templateFoot>