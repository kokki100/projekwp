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
		if(cookies[i].getName().equals("IsAdmin")) {
			session.setAttribute("IsAdmin", cookies[i].getValue());
			continue;
		}
		else if(cookies[i].getName().equals("Username")) {
			session.setAttribute("username", cookies[i].getValue());
			continue;
		}
		else if(cookies[i].getName().equals("UserID")) {
			session.setAttribute("UserID", cookies[i].getValue());
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
	response.sendRedirect("home.jsp?err=nosession");
}
%>
<div id="main-nav">
	<ul>
		<li>
			<a href="home.jsp">
				Home
			</a>
		</li>
		<li>
			<a href="logout.jsp">
				Logout
			</a>
		</li>
		<li>
			<a href="changepassword.jsp">
				Change Password
			</a>
		</li>
		<li>
			<a href="product.jsp">
				Product
			</a>
		</li>
		<li>
			<a href="testimonial.jsp">
				Testimonial
			</a>
		</li>
		<li>
			<a href="services.jsp">
				Services
			</a>
		</li>
	</ul>
</div>

<%
String userId = "", username = "", email = "", phone = "", address = "", loginTime = "";
userId		= (String)session.getAttribute("UserID");
username	= (String)session.getAttribute("username");
email		= (String)session.getAttribute("Email");
phone		= (String)session.getAttribute("Phone");
address		= (String)session.getAttribute("Address");
loginTime	= (String)session.getAttribute("LoginTime");

int onlineMember;
if (application.getAttribute("onlineMember") == null) {
	onlineMember = 1;
	application.setAttribute("onlineMember",onlineMember);
}
else {
	try {
		onlineMember = (Integer) application.getAttribute("onlineMember");
	}
	catch (Exception e) {
		onlineMember = 1;
		application.setAttribute("onlineMember",onlineMember);
	}
}
%>

<div class="greeting">
	<div><span style="color: #00FFFF">Welcome, <%=username%></span></div>
	<div><span style="color: #FF00FF">Online Member: <%=onlineMember%></span></div>
</div>