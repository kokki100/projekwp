<%@ tag language="java" description="navigation bar for logged in users" pageEncoding="UTF-8" %>
<%
// check cookies; if cookies exists, renew session. if no cookies, check session
Cookie[] cookies = request.getCookies();
if (cookies!=null) {
	int len = cookies.length;
	// renew session
	for (int i = 0; i < len; i++) {
		int cookieAge = 60 * 60 * 24;
		cookies[i].setMaxAge(cookieAge);
		if(cookies[i].getName().equals("Username")) {
			session.setAttribute("username", cookies[i].getValue());
			continue;
		}
		else if(cookies[i].getName().equals("UserID")) {
			session.setAttribute("UserID", cookies[i].getValue());
			continue;
		}
		else if(cookies[i].getName().equals("FirstName")) {
			session.setAttribute("FirstName", cookies[i].getValue());
			continue;
		}
		else if(cookies[i].getName().equals("MiddleName")) {
			session.setAttribute("MiddleName", cookies[i].getValue());
			continue;
		}
		else if(cookies[i].getName().equals("LastName")) {
			session.setAttribute("LastName", cookies[i].getValue());
			continue;
		}
		else if(cookies[i].getName().equals("Email")) {
			session.setAttribute("Email", cookies[i].getValue());
			continue;
		}
		else if(cookies[i].getName().equals("Phone")) {
			session.setAttribute("Phone", cookies[i].getValue());
			continue;
		}
		else if(cookies[i].getName().equals("Address")) {
			session.setAttribute("Address", cookies[i].getValue());
			continue;
		}
		else if(cookies[i].getName().equals("LoginTime")) {
			session.setAttribute("LoginTime", cookies[i].getValue());
			continue;
		}
	}
	session.setAttribute("isRemember", true);
}

// check session
if (session.getAttribute("UserID") != null) {
	// session exists
}
else {
	// no session exists
	response.sendRedirect("home.jsp");
}
%>
<div id="main-nav">
	<ul>
		<li>
			<a href="#">
				Home
			</a>
		</li>
		<li>
			<a href="#">
				Change Password
			</a>
		</li>
		<li>
			<a href="#">
				Product
			</a>
		</li>
		<li>
			<a href="#">
				Testimonial
			</a>
		</li>
		<li>
			<a href="#">
				Services
			</a>
		</li>
	</ul>
</div>