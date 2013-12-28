<%@ include file = "connect.jsp" %>
<%
	String TestimonyID=request.getParameter("TestimonyID");
	try{
		String Delete = "DELETE FROM Testimony WHERE TestimonyID = "+TestimonyID+"";
		st.executeUpdate(Delete);
	}
	catch (Exception e){
		//out.println(e.getMessage());
		con.close();
		response.sendRedirect("register.jsp?err=unknownerror"); return;
	}
	con.close();
	response.sendRedirect("testimonial.jsp?mess=dsuccess"); return;
%>