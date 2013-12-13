<html>
	<%@include file='template/templateMaster.jsp'%>
	
	<body>
		Welcome to Bluelight <br/>
		Login Form <br />
		<%
			String err;
			String name=null;
			Cookie[] cookies = request.getCookies();
			err = request.getParameter("err");
			
			if (cookies!=null)
				for (int i=0; i<cookies.length;i++)
				{
					if(cookies[i].getName().equals("name"))
						name=cookies[i].getValue();
				}
			
			if (name!=null)
				session.setAttribute("name",name);
			
			if (session.getAttribute("name") == null)
			{
				//login
				%>
					<form method='post' action='dologin.jsp'>
						<table>
							<tr>
								<td> Username </td>
								<td> <input type='text' name='user'/> </td>
							</tr>
							<tr>
								<td> Password </td>
								<td> <input type='password' name='pass'/> </td>
							</tr>
							<tr>
								<td> <input type='checkbox' name='remember'/> </td>
								<td> Remember Me? </td>
							</tr>
							<tr>
								<%
									if (err != null)
									{
										%>
										<td colspan='2' color='red'> <%=err%> </td>
										<%			
									}
								%>
							</tr>
							<tr>
								<td colspan='2'> <input type='submit' value='login'/> </td>
							</tr>
						</table>
					</form>
				<%
			}
			else
			{
				//welcome
				name=(String) session.getAttribute("name");
				out.print("Welcome "+name+"<br />");
				%>
					<a href='logout.jsp'>Logout</a>
				<%
			}
			
		%>
	</body>
</html>