<%@ include file = "connect.jsp" %>
<%
	String UserID = (String) session.getAttribute("UserID");
	String username = (String) session.getAttribute("username");
	String testimony = request.getParameter("testimony");
	
	if (testimony==null || testimony.equals("")){
		response.sendRedirect("testimonial.jsp?err=empty"); return;}
	if (testimony.length()<15){
		response.sendRedirect("testimonial.jsp?err=toofew"); return;}
	if (testimony.contains("'")) {
		response.sendRedirect("testimonial.jsp?err=invalidcharacter"); return;}
	try {
		String query = "INSERT INTO Testimony(UserID,Testimony) VALUES ('"+UserID+"', '"+testimony+"')";
		st.executeUpdate(query);
	}
	catch (Exception e){
		con.close();
		response.sendRedirect("testimonial.jsp?err=unknownerror"); return;
	}
	
	con.close();
	response.sendRedirect("testimonial.jsp?mess=success"); return;
%>