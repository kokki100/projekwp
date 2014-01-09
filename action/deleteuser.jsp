<%@ include file = "connect.jsp" %>
<%
	String userID = (String) request.getParameter("UserID");

	try{
		String Delete = "DELETE FROM User WHERE UserID = "+userID+"";
		st.executeUpdate(Delete);
	}
	catch (Exception e){
		con.close();
		response.sendRedirect("../userlist.jsp?&err=unknownerror"); return;
	}
	
	con.close();
	response.sendRedirect("../userlist.jsp?&mess=success"); return;
%>