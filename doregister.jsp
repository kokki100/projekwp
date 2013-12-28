<%@ include file = "connect.jsp" %>
<%
	String username = (String) request.getParameter("username");
	String password = (String) request.getParameter("password");
	String cpassword = (String) request.getParameter("cpassword");
	String address = (String) request.getParameter("address");
	String phone = (String) request.getParameter("telephone");
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
	if (address.equals("")) {
		response.sendRedirect("register.jsp?err=noaddress"); return;
	}
	if (address.length() < 10) {
		response.sendRedirect("register.jsp?err=shortaddress"); return;
	}
	// validate address format
	if (!address.contains("street")) {
		response.sendRedirect("register.jsp?err=wrongaddressformat"); return;
	}
	if (phone.equals("")) {
		response.sendRedirect("register.jsp?err=nophone"); return;
	}
	boolean phoneIsNumber = false;
	try {
		long tmp = Long.parseLong(phone);
		phoneIsNumber = true;
	} catch(NumberFormatException e) {
		phoneIsNumber = false;
	}
	// validate number only for phone
	if (!phoneIsNumber) {
		response.sendRedirect("register.jsp?err=wrongphoneformat"); return;
	}
	if (phone.length() < 12 || phone.length() > 15) {
		response.sendRedirect("register.jsp?err=wrongphonelength"); return;
	}
	if (email.equals("")) {
		response.sendRedirect("register.jsp?err=noemail"); return;
	}
	// validate email
	String regexEmail = "[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})";
	if (!email.matches(regexEmail)) {
		response.sendRedirect("register.jsp?err=wrongemailformat"); return;
	}

	try {
		String query = "INSERT INTO User(UserName, Password, IsAdmin, Address, Phone, Email) VALUES ('"+username+"', '"+password+"', 0, '"+address+"', '"+phone+"', '"+email+"')";
		st.executeUpdate(query);
	}
	catch (Exception e){
		//out.println(e.getMessage());
		con.close();
		response.sendRedirect("register.jsp?err=unknownerror"); return;
	}
	con.close();
	response.sendRedirect("register.jsp?mess=success"); return;
%>