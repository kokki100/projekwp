<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page language="java" import="java.util.*"%>
<t:templateHead>
	<jsp:attribute name="pageTitle">Bluelight Online Shop</jsp:attribute>
	<jsp:attribute name="header"></jsp:attribute>
	<jsp:attribute name="content"></jsp:attribute>
</t:templateHead>

<div style="width: 100%;">

<%
String userId = "", username = "", email = "", phone = "", address = "", loginTime = "";

if (session.getAttribute("UserID") == null)
{
	// not logged in
	String err;
	err = request.getParameter("err");

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
		else if (err.equals("invalidlogin")) {
			err = "Wrong combination of Username and Password";
		}
		else if (err.equals("nosession")) {
			err = "You need to login first";
		}
		else {
			err = "unknown error";
		}
	}
%>
	<div style="text-align: center">
		<h1 style="color: #FFA300; font-weight: normal">Welcome to Bluelight</h1>

		<span style="color: #FF00FF">Login Form</span>

		<form method='post' action='action/dologin.jsp'>
			<table style="margin: 0 auto;">
				<tr>
					<td>Username</td>
					<td>:</td>
					<td><input type='text' name='username'/></td>
				</tr>
				<tr>
					<td>Password</td>
					<td>:</td>
					<td><input type='password' name='password'/></td>
				</tr>
				<tr>
					<td colspan='3' style="text-align: center">
						<input type='checkbox' name='remember'/>
						Remember Me?
					</td>
				</tr>
			</table>
<% if (err != null) { %>
			<div><span class="error"><%=err%></span></div>
<% } %>
			<input type='submit' value='login'/>
		</form>
	</div>
<% } else {
	// logged in
	userId		= (String)session.getAttribute("UserID");
	username	= (String)session.getAttribute("username");
	email		= (String)session.getAttribute("Email");
	phone		= (String)session.getAttribute("Phone");
	address		= (String)session.getAttribute("Address");
	loginTime	= (String)session.getAttribute("LoginTime");
%>
	<div style="text-align: center">
		<h1 style="color: #FFA300; font-weight: normal">Welcome to Bluelight</h1>

		<div><span>Login Time</span></div>
		<div><span style="color: #00FFFF"><%=loginTime%></span></div>

		<div style="margin-top: 50px;"><a href="action/logout.jsp">logout</a></div>
	</div>
<% } %>



</div>
<t:templateFoot>
	<jsp:attribute name="footer"></jsp:attribute>
</t:templateFoot>