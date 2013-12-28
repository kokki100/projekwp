<%@include file="connect-sample.jsp"%>
<%
	String username=(String) session.getAttribute("username");;
	String oldpass=request.getParameter("oldpass");
	String newpass=request.getParameter("newpass");
	String connew=request.getParameter("connew");
	String password=null;
	
	if (oldpass == null || oldpass.equals("")){
		response.sendRedirect("changepass.jsp?err=old password must be filled");
		return;
	}
	
	String query = "SELECT Password from User where UserName like '"+ username +"'";
	ResultSet rs = stmt.executeQuery(query);
	
	if(rs.next()){
		password = rs.getString("Password");
	}
	
	if (!password.equals(oldpass)){
		response.sendRedirect("changepass.jsp?err=old password must equals to password");
		return;
	}
	
	if (newpass == null || newpass.equals("")){
		response.sendRedirect("changepass.jsp?err=new password must be filled");
		return;
	}
	
	if (connew == null || connew.equals("")){
		response.sendRedirect("changepass.jsp?err=confirm password must be filled");
		return;
	}
	
	if (!connew.equals(newpass)){
		response.sendRedirect("changepass.jsp?err=confirm password must equals to new password");
		return;
	}
	
	String update = "UPDATE User SET Password = '"+newpass+"' WHERE UserName = '"+username+"'";
	stmt.executeUpdate(update);
	
	response.sendRedirect("changepass.jsp?err=password changed");
%>