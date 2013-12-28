<%@ include file = "connect-sample.jsp" %>
<%
	String password = (String) request.getParameter("old");
	String newPassword = (String) request.getParameter("new");
	String cNewPassword = (String) request.getParameter("connew");

	String userId = (String) session.getAttribute("UserID");
	if (userId == null) { response.sendRedirect("home.jsp?err=nosession"); return; }

	if (password==null || password.equals("")){
		response.sendRedirect("changepassword.jsp?err=oldempty"); return;}
		
	if (newPassword==null || newPassword.equals("")){
		response.sendRedirect("changepassword.jsp?err=newempty"); return;}
		
	if (cNewPassword==null || cNewPassword.equals("")){
		response.sendRedirect("changepassword.jsp?err=conempty"); return;}
	
	String query = "SELECT 1 FROM User WHERE UserID = "+userId+" AND Password = '"+password+"'";
	ResultSet rs = st.executeQuery(query);
	if (rs.next()) {
		// true
		if (newPassword.equals(cNewPassword)) {
			query = "UPDATE User SET Password = '"+newPassword+"' WHERE UserID = "+userId;
			st.executeUpdate(query);
			con.close();
			response.sendRedirect("changepassword.jsp?mess=success"); return;
		}
		else {
			con.close();
			response.sendRedirect("changepassword.jsp?err=confirmpassword"); return;
		}
	}
	else {
		// wrong password
		con.close();
		response.sendRedirect("changepassword.jsp?err=wrongpassword"); return;
	}
%>