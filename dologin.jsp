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

<%@include file="connect.jsp"%>
<%
<<<<<<< HEAD
	String query = "SELECT Profile.UserID, Profile.FirstName, Profile.MiddleName, Profile.LastName, Profile.Email, Profile.Phone, Profile.Address, User.Privilege, NOW() AS LoginTime FROM User INNER JOIN Profile ON User.UserID = Profile.UserID WHERE User.UserName = '" + username + "' AND User.Password = '" + password + "'";
	ResultSet rs = stmt.executeQuery(query);
	String userId, firstName, middleName, lastName, email, phone, address, loginTime,privilege;
=======
	String query = "SELECT IsAdmin, Password, UserID, Address, Phone, Email, NOW() AS LoginTime FROM User WHERE UserName = '" + username + "' AND Password = '" + password + "'";

	ResultSet rs = st.executeQuery(query);
	String userId, email, phone, address, loginTime, isAdmin;
>>>>>>> aa6cc45ec8c7cbdcbe000e1a7aff4d1a9d4b519b
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
		privilege	= rs.getString("Privilege");
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
		Cookie cPrivilege	= new Cookie("Privilege",	privilege);
		
		int cookieAge = 60 * 60 * 24;
		cIsAdmin.setMaxAge(cookieAge);
		cUserId.setMaxAge(cookieAge);
		cUsername.setMaxAge(cookieAge);
		cEmail.setMaxAge(cookieAge);
		cPhone.setMaxAge(cookieAge);
		cAddress.setMaxAge(cookieAge);
		cLoginTime.setMaxAge(cookieAge);
		cPrivilege.setMaxAge(cookieAge);

		response.addCookie(cIsAdmin);
		response.addCookie(cUserId);
		response.addCookie(cUsername);
		response.addCookie(cEmail);
		response.addCookie(cPhone);
		response.addCookie(cAddress);
		response.addCookie(cLoginTime);
		response.addCookie(cPrivilege);
		
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
	session.setAttribute("Privilege",	privilege);
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
