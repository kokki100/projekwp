<%
	String name=request.getParameter("user");
	String pass=request.getParameter("pass");
	String remember=request.getParameter("remember");
	
	if (name==null || name.equals(""))
	{
		response.sendRedirect("home.jsp?err=name must be filled");
	}
	else
	{
		if (pass==null || pass.equals(""))
		{
			response.sendRedirect("home.jsp?err=pass must be filled");
		}
		else
		{
			if (remember!=null)
			{
				Cookie cookie = new Cookie ("name",name);
				cookie.setMaxAge(60*60*24); 
				response.addCookie(cookie);
			}
			session.setAttribute("name",name);
			response.sendRedirect("home.jsp");
		}
	}
%>
