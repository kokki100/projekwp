<%@ include file = "connect.jsp" %>
<%
	String username = (String) request.getParameter("username");
	String password = (String) request.getParameter("password");
	String cpassword = (String) request.getParameter("cpassword");
	String firstName = (String) request.getParameter("firstName");
	String middleName = (String) request.getParameter("middleName");
	String lastName = (String) request.getParameter("lastName");
	String address = (String) request.getParameter("address");
	String telephone = (String) request.getParameter("telephone");
	String email = (String) request.getParameter("email");

	if (username.equals("")) {
		response.sendRedirect("register.jsp?err=nousername"); return;
	}
	if (password.equals("")) {
		response.sendRedirect("register.jsp?err=nopassword"); return;
	}
	if (cpassword.equals("")) {
		response.sendRedirect("register.jsp?err=noconfirmpassword"); return;
	}
	if (!password.equals(cpassword)) {
		response.sendRedirect("register.jsp?err=confirmpassword"); return;
	}
	if (firstName.equals("")) {
		response.sendRedirect("register.jsp?err=nofirstname"); return;
	}
	if (address.equals("")) {
		response.sendRedirect("register.jsp?err=noaddress"); return;
	}
	if (telephone.equals("")) {
		response.sendRedirect("register.jsp?err=nophone"); return;
	}
	if (email.equals("")) {
		response.sendRedirect("register.jsp?err=noemail"); return;
	}
	// validate email
	if (false) {
		response.sendRedirect("register.jsp?err=wrongemail"); return;
	}

	String query = "INSERT INTO User(UserName, Password, IsAdmin) VALUES ('"+username+"', '"+password+"', 0)";
	st.executeUpdate(query);

	query = "SELECT UserID FROM User WHERE username = '"+username+"'";
	ResultSet rs = st.executeQuery(query);

	String UserID = "";
	if (rs.next()) {
		UserID = rs.getString("UserID");
		query = "INSERT INTO Profile (UserID, FirstName, MiddleName, LastName, Email, Phone, Address) VALUES('"+UserID+"', '"+firstName+"', '"+middleName+"', '"+lastName+"', '"+email+"', '"+telephone+"', '"+address+"')";
		st.executeUpdate(query);
		response.sendRedirect("register.jsp?mess=success"); return;
	}
	else {
		response.sendRedirect("register.jsp?err=unknownerror"); return;
	}

	

%>