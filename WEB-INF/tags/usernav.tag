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
String userId = "", username = "", firstName = "", middleName = "", lastName = "", email = "", phone = "", address = "", loginTime = "";
userId		= (String)session.getAttribute("UserID");
username	= (String)session.getAttribute("username");
firstName	= (String)session.getAttribute("FirstName");
middleName	= (String)session.getAttribute("MiddleName");
lastName	= (String)session.getAttribute("LastName");
email		= (String)session.getAttribute("Email");
phone		= (String)session.getAttribute("Phone");
address		= (String)session.getAttribute("Address");
loginTime	= (String)session.getAttribute("LoginTime");

String fullName = firstName;
if (middleName != null && !middleName.equals("")) fullName += " " + middleName;
if (!lastName.equals("")) fullName += " " + lastName;

Integer onlineMember = (Integer) application.getAttribute("onlineMember");
%>

<div><span style="color: #00FFFF">Welcome, <%=fullName%></span></div>
<div><span style="color: #FF00FF">Online Member: <%=onlineMember%></span></div>