<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page language="java" import="java.util.*"%>
<t:templateHead>
	<jsp:attribute name="pageTitle">Bluelight Online Shop</jsp:attribute>
	<jsp:attribute name="header"></jsp:attribute>
	<jsp:attribute name="content"></jsp:attribute>
</t:templateHead>

<div style="width: 100%;">

<%
String err, mess;
err = request.getParameter("err");
mess = request.getParameter("mess");

if (err == null || err.equals("")) {
	err = "";
}
else {
	if (err.equals("nousername")) {
		err = "Username must be filled";
	}
	else if (err.equals("nopassword")) {
		err = "Password must be filled";
	}
	else if (err.equals("noconfirmpassword")) {
		err = "Confirm Password must be filled";
	}
	else if (err.equals("confirmpassword")) {
		err = "Password and Confirm password must be exactly the same.";
	}
	else if (err.equals("nofirstname")) {
		err = "First Name must be filled";
	}
	else if (err.equals("noaddress")) {
		err = "Address must be filled";
	}
	else if (err.equals("nophone")) {
		err = "Phone number must be filled";
	}
	else if (err.equals("noemail")) {
		err = "Email must be filled";
	}
	else if (err.equals("wrongemail")) {
		err = "Please enter the right Email format xxx@yyy.zzz";
	}
	else {
		err = "unknown error";
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
	<div style="text-align: center">
		<h1 style="color: #FFA300; font-weight: normal">Register</h1>

		<span style="color: #FF00FF">Register Form</span>

		<form method='post' action='doregister.jsp'>
			<table style="margin: 0 auto; text-align: left">
				<tr>
					<td>Username</td>
					<td>:</td>
					<td><input type='text' name='username' /></td>
				</tr>
				<tr>
					<td>Password</td>
					<td>:</td>
					<td><input type='password' name='password' /></td>
				</tr>
				<tr>
					<td>Confirm Password</td>
					<td>:</td>
					<td><input type='password' name='cpassword' /></td>
				</tr>
				<tr>
					<td>First Name</td>
					<td>:</td>
					<td><input type='text' name='firstName' /></td>
				</tr>
				<tr>
					<td>Middle Name</td>
					<td>:</td>
					<td><input type='text' name='middleName' /></td>
				</tr>
				<tr>
					<td>Last Name</td>
					<td>:</td>
					<td><input type='text' name='lastName' /></td>
				</tr>
				<tr>
					<td>Address</td>
					<td>:</td>
					<td><input type='text' name='address' /></td>
				</tr>
				<tr>
					<td>Telephone</td>
					<td>:</td>
					<td><input type='text' name='telephone' /></td>
				</tr>
				<tr>
					<td>Email</td>
					<td>:</td>
					<td><input type='text' name='email' /></td>
				</tr>
			</table>
<% if (err != null) { %>
			<div><span class="error"><%=err%></span></div>
<% } else if (mess != null) { %>
			<div><span class="message"><%=mess%></span></div>
<% } %>
			<input type='submit' value='Register' />

		</form>
	</div>



</div>
<t:templateFoot>
	<jsp:attribute name="footer"></jsp:attribute>
</t:templateFoot>