<%@include file='template/templateStart.jsp'%>
<div style="width: 100%;">

<%
String err;
String name=null;
Cookie[] cookies = request.getCookies();
err = request.getParameter("err");

if (cookies!=null) {
	for (int i=0; i<cookies.length;i++) {
		if(cookies[i].getName().equals("name"))
			name=cookies[i].getValue();
	}
}

if (name!=null) session.setAttribute("name",name);

if (session.getAttribute("name") == null && false)
{
%>
	<div style="text-align: center">
		<h1 style="color: #FFA300; font-weight: normal">Welcome to Bluelight</h1>

		<span style="color: #FF00FF">Login Form</span>

		<form method='post' action='dologin.jsp'>
			<table style="margin: 0 auto;">
				<tr>
					<td> Username </td>
					<td> <input type='text' name='user'/> </td>
				</tr>
				<tr>
					<td> Password </td>
					<td> <input type='password' name='pass'/> </td>
				</tr>
				<tr>
					<td colspan='2' style="text-align: center">
						<input type='checkbox' name='remember'/>
						Remember Me?
					</td>
				</tr>
<% if (err != null) { %>
				<tr>
					<td colspan='2' color='red'> <%=err%> </td>
				</tr>
<% } %>
				<tr>
					<td colspan='2' style="text-align: center"> <input type='submit' value='login'/> </td>
				</tr>
			</table>
		</form>
	</div>
<% } else {
	name = (String)session.getAttribute("name");
	String onlineMember = "2";
	String loginTime = "2013-08-24 14:33:55";
%>
	<div><span style="color: #00FFFF">Welcome, <%=name%></span></div>
	<div><span style="color: #FF00FF">Online Member: <%=onlineMember%></span></div>

	<div style="text-align: center">
		<h1 style="color: #FFA300; font-weight: normal">Welcome to Bluelight</h1>

		<div><span>Login Time</span></div>
		<div><span style="color: #00FFFF"><%=loginTime%></span></div>

		<div style="margin-top: 50px;"><a href="logout.jsp">logout</a></div>
	</div>
<% } %>



</div>
<%@include file='template/templateEnd.jsp'%>