<html>
	<%@include file='template/templateMaster.jsp'%>
	
	<body>
		Register <br />
		Register Form <br />
		<%
			String err=request.getParameter("err");
		%>
		<form method='post' action='doregister.jsp'>
			<table>
				<tr>
					<td> Username </td>
					<td> <input type='text' name='user' /> </td>
				</tr>
				<tr>
					<td> Password </td>
					<td> <input type='password' name='pass' /> </td>
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
				<tr>
					<%
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
					<td colspan='2'> <input type='submit' value='Register' </td>
				</tr>
			</table>
		</form>
	</body>
</html>