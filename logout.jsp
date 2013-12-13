<%
	session.invalidate();
	Cookie cookie = new Cookie("name", null);
    cookie.setMaxAge(0);
	response.addCookie(cookie);
	
	response.sendRedirect("home.jsp");
%>