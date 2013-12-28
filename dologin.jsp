<%
	String username=request.getParameter("username");
	String password=request.getParameter("password");
	String remember=request.getParameter("remember");

	// validation start
	if (username == null || username.equals("")) {
		response.sendRedirect("home.jsp?err=nousername");
		return;
	}
	if (password == null || password.equals("")) {
		response.sendRedirect("home.jsp?err=nopassword");
		return;
	}
	// validation end
%>

<%@include file="connect-sample.jsp"%>
<%
	String query = "SELECT IsAdmin, Password, UserID, Address, Phone, Email, NOW() AS LoginTime FROM User WHERE UserName = '" + username + "' AND Password = '" + password + "'";

	ResultSet rs = st.executeQuery(query);
	String userId, email, phone, address, loginTime, isAdmin;
	if (rs.next()) {
		if (!password.equals(rs.getString("Password"))) {
			response.sendRedirect("home.jsp?err=invalidlogin"); return;
		}
		isAdmin		= rs.getString("IsAdmin");
		userId		= rs.getString("UserID");
		email		= rs.getString("Email");
		phone 		= rs.getString("Phone");
		address 	= rs.getString("Address");
		loginTime	= rs.getString("LoginTime");
	}
	else {
		response.sendRedirect("home.jsp?err=invalidlogin"); return;
	}
	con.close();
	// validation passed
	if (remember!=null)
	{
		Cookie cIsAdmin		= new Cookie("IsAdmin",		isAdmin);
		Cookie cUserId		= new Cookie("UserID",		userId);
		Cookie cUsername	= new Cookie("Username",	username);
		Cookie cEmail		= new Cookie("Email",		email);
		Cookie cPhone		= new Cookie("Phone",		phone);
		Cookie cAddress		= new Cookie("Address",		address);
		Cookie cLoginTime	= new Cookie("LoginTime",	loginTime);

		int cookieAge = 60 * 60 * 24;
		cIsAdmin.setMaxAge(cookieAge);
		cUserId.setMaxAge(cookieAge);
		cUsername.setMaxAge(cookieAge);
		cEmail.setMaxAge(cookieAge);
		cPhone.setMaxAge(cookieAge);
		cAddress.setMaxAge(cookieAge);
		cLoginTime.setMaxAge(cookieAge);

		response.addCookie(cIsAdmin);
		response.addCookie(cUserId);
		response.addCookie(cUsername);
		response.addCookie(cEmail);
		response.addCookie(cPhone);
		response.addCookie(cAddress);
		response.addCookie(cLoginTime);
	
		session.setAttribute("isRemember",	true);
	}
	else {
		session.setAttribute("isRemember",	false);
	}

	session.setAttribute("IsAdmin",		isAdmin);
	session.setAttribute("username",	username);
	session.setAttribute("UserID",		userId);
	session.setAttribute("Email",		email);
	session.setAttribute("Phone",		phone);
	session.setAttribute("Address",		address);
	session.setAttribute("LoginTime",	loginTime);
	response.sendRedirect("home.jsp");

	if (application.getAttribute("onlineMember") == null) {
		application.setAttribute("onlineMember", 1);
	}
	else {
		Integer onlineMember = (Integer) application.getAttribute("onlineMember");
		onlineMember++;
		application.setAttribute("onlineMember",onlineMember);
	}
%>
