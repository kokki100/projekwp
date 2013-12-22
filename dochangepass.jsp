<%@ include file = "connect.jsp" %>
<%
	String password = (String) request.getParameter("old");
	String newPassword = (String) request.getParameter("new");
	String cNewPassword = (String) request.getParameter("connew");

	String userId = (String) session.getAttribute("UserID");
	if (userId == null) { response.sendRedirect("home.jsp?err=nosession"); return; }

	String query = "SELECT 1 FROM User WHERE UserID = "+userId+" AND Password = '"+password+"'";
	ResultSet rs = st.executeQuery(query);
	if (rs.next()) {
		// true
		if (newPassword.equals(cNewPassword)) {
			query = "UPDATE User SET Password = '"+newPassword+"' WHERE UserID = "+userId;
			st.executeUpdate(query);
			response.sendRedirect("changepassword.jsp?mess=success"); return;
		}
		else {
			response.sendRedirect("changepassword.jsp?err=confirmpassword"); return;
		}
	}
	else {
		// wrong password
		response.sendRedirect("changepassword.jsp?err=wrongpassword"); return;
	}
%>