<html>
	<%@include file='template/templateMaster.jsp'%>
	<%if (session.getAttribute("name")==null) response.sendRedirect("home.jsp");%>
	<body>
		Updating Profile <br />
		Change Password Form <br />
		<form method='post' action='dochangepass.jsp'>
			<table>
				<tr>
					<td> Old Password </td>
					<td> <input type='password' name='old' />
				</tr>
				<tr>
					<td> New Password </td>
					<td> <input type='password' name='new' />
				</tr>
				<tr>
					<td> Confirm New Password </td>
					<td> <input type='password' name='connew' />
				</tr>
				<tr>
					<%
						String err=request.getParameter("err");
						if (err != null)
						{
							if (err.equals("Register Success"))
							{
								%>
								<td colspan='2'> <%=err%> </td>
								<%
							}
							else
							{
								%>
								<td colspan='2'> <%=err%> </td>
								<%		
							}
						}
					%>
				</tr>
				<tr>
					<td colspan='2'> <input type='submit' value='Change' />
				</tr>
			</table>
		</form>
	</body>
</html>