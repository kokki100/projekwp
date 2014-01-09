<%@ include file = "connect.jsp" %>
<%
	String username = (String) request.getParameter("username");
	String password = (String) request.getParameter("password");
	String cpassword = (String) request.getParameter("cpassword");
	String address = (String) request.getParameter("address");
	String phone = (String) request.getParameter("telephone");
	String email = (String) request.getParameter("email");

	if (username.equals("")) {
		response.sendRedirect("../register.jsp?err=nousername"); return;
	}
	if (password.equals("")) {
		response.sendRedirect("../register.jsp?err=nopassword"); return;
	}
	if (cpassword.equals("")) {
		response.sendRedirect("../register.jsp?err=noconfirmpassword"); return;
	}
	if (!password.equals(cpassword)) {
		response.sendRedirect("../register.jsp?err=confirmpassword"); return;
	}
	if (address.equals("")) {
		response.sendRedirect("../register.jsp?err=noaddress"); return;
	}
	if (address.length() < 10) {
		response.sendRedirect("../register.jsp?err=shortaddress"); return;
	}
	// validate address format
	if (!address.contains("street")) {
		response.sendRedirect("../register.jsp?err=wrongaddressformat"); return;
	}
	if (phone.equals("")) {
		response.sendRedirect("../register.jsp?err=nophone"); return;
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
		response.sendRedirect("../register.jsp?err=wrongphoneformat"); return;
	}
	if (phone.length() < 12 || phone.length() > 15) {
		response.sendRedirect("../register.jsp?err=wrongphonelength"); return;
	}
	if (email.equals("")) {
		response.sendRedirect("../register.jsp?err=noemail"); return;
	}
	// validate email
	// String regexEmail = "[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})";
	// if (!email.matches(regexEmail)) {
	// 	response.sendRedirect("../register.jsp?err=wrongemailformat"); return;
	// }
	{
		// validate email
		int emailLength = email.lenth();
		if (!email.contains(".") || !email.contains("@")) {
			response.sendRedirect("../register.jsp?err=wrongemailformat"); return;
		}
		int idxAt = 0;
		int idxDot = 0;
		for (int i = 0; i < emailLength; i++) {
			if (email.charAt(i) == '.') {
				// get the last .
				idxDot = i;
			}
			if (email.charAt(i) == '@') {
				if (idxAt == 0) {
					idxAt = i;
				}
				else {
					// more than one '@' sign was found
					response.sendRedirect("../register.jsp?err=wrongemailformat"); return;
				}
			}
		}
		if (idxAt > idxDot) {
			// no '.' sign after '@' sign
			response.sendRedirect("../register.jsp?err=wrongemailformat"); return;
		}
		if (email.charAt(0) < 65 || email.charAt(0) > 90) && (email.charAt(0) < 97 || email.charAt(0) > 122)  {
			// first character should be A-Z or a-z
			response.sendRedirect("../register.jsp?err=wrongemailformat"); return;
		}
		if (idxDot - idxAt < 2) {
			// format must be x@y.z [1 digit between @ and .]
			response.sendRedirect("../register.jsp?err=wrongemailformat"); return;
		}
		for (int i = idxAt+1; i < idxDot; i++) {
			// check domain
			if (email.charAt(i) < 65 || email.charAt(i) > 90) && (email.charAt(i) < 97 || email.charAt(i) > 122)  {
				// domain name should be A-Z or a-z
				response.sendRedirect("../register.jsp?err=wrongemailformat"); return;
			}
		}
		for (int i = idxDot+1; i < emailLength; i++) {
			// check domain
			if (email.charAt(i) < 65 || email.charAt(i) > 90) && (email.charAt(i) < 97 || email.charAt(i) > 122)  {
				// domain name should be A-Z or a-z
				response.sendRedirect("../register.jsp?err=wrongemailformat"); return;
			}
		}
	}

	try {
		String query = "INSERT INTO User(UserName, Password, IsAdmin, Address, Phone, Email) VALUES ('"+username+"', '"+password+"', 0, '"+address+"', '"+phone+"', '"+email+"')";
		st.executeUpdate(query);
	}
	catch (Exception e){
		//out.println(e.getMessage());
		con.close();
		response.sendRedirect("../register.jsp?err=unknownerror"); return;
	}
	con.close();
	response.sendRedirect("../register.jsp?mess=success"); return;
%>