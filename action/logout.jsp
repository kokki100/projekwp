<%
	session.invalidate();
	Integer onlineMember = (Integer) application.getAttribute("onlineMember");
	if (onlineMember == null) onlineMember = 1;
	onlineMember--;
	application.setAttribute("onlineMember", onlineMember);

	Cookie[] cookies = request.getCookies();
	if (cookies!=null) {
		int len = cookies.length;
		for (int i = 0; i < len; i++) {
			cookies[i].setMaxAge(0);
			response.addCookie(cookies[i]);
		}
	}
	
	response.sendRedirect("../home.jsp");
%>