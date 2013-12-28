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
	String query = "SELECT Profile.UserID, Profile.FirstName, Profile.MiddleName, Profile.LastName, Profile.Email, Profile.Phone, Profile.Address, NOW() AS LoginTime FROM User INNER JOIN Profile ON User.UserID = Profile.UserID WHERE User.UserName = '" + username + "' AND User.Password = '" + password + "'";
	ResultSet rs = stmt.executeQuery(query);
	String userId, firstName, middleName, lastName, email, phone, address, loginTime;
	if (rs.next()) {
		userId		= rs.getString("UserID");
		firstName	= rs.getString("FirstName");
		middleName	= rs.getString("MiddleName");
		lastName	= rs.getString("LastName");
		email		= rs.getString("Email");
		phone 		= rs.getString("Phone");
		address 	= rs.getString("Address");
		loginTime	= rs.getString("LoginTime");
	}
	else {
		response.sendRedirect("home.jsp?err=invalidlogin");return;
	}

	// validation passed
	if (remember!=null)
	{
		Cookie cUserId		= new Cookie("UserID",		userId);
		Cookie cUsername	= new Cookie("Username",	username);
		Cookie cFirstName	= new Cookie("FirstName",	firstName);
		Cookie cMiddleName	= new Cookie("MiddleName",	middleName);
		Cookie cLastName	= new Cookie("LastName",	lastName);
		Cookie cEmail		= new Cookie("Email",		email);
		Cookie cPhone		= new Cookie("Phone",		phone);
		Cookie cAddress		= new Cookie("Address",		address);
		Cookie cLoginTime	= new Cookie("LoginTime",	loginTime);

		int cookieAge = 60 * 60 * 24;
		cUserId.setMaxAge(cookieAge);
		cUsername.setMaxAge(cookieAge);
		cFirstName.setMaxAge(cookieAge);
		cMiddleName.setMaxAge(cookieAge);
		cLastName.setMaxAge(cookieAge);
		cEmail.setMaxAge(cookieAge);
		cPhone.setMaxAge(cookieAge);
		cAddress.setMaxAge(cookieAge);
		cLoginTime.setMaxAge(cookieAge);

		response.addCookie(cUserId);
		response.addCookie(cUsername);
		response.addCookie(cFirstName);
		response.addCookie(cMiddleName);
		response.addCookie(cLastName);
		response.addCookie(cEmail);
		response.addCookie(cPhone);
		response.addCookie(cAddress);
		response.addCookie(cLoginTime);
	
		session.setAttribute("isRemember",	true);
	}
	else {
		session.setAttribute("isRemember",	false);
	}

	session.setAttribute("username",	username);
	session.setAttribute("UserID",		userId);
	session.setAttribute("FirstName",	firstName);
	session.setAttribute("MiddleName",	middleName);
	session.setAttribute("LastName",	lastName);
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
