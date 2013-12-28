<%@ include file = "connect.jsp" %>
<%
	String UserID = (String) session.getAttribute("UserID");
	String username = (String) session.getAttribute("username");
	String testimony = request.getParameter("testimony");
	String TestimonyID = request.getParameter("TestimonyID");
	
	if (testimony==null || testimony.equals("")){
		response.sendRedirect("edittestimonial.jsp?TestimonyID="+TestimonyID+"&err=empty"); return;}
	if (testimony.length()<15){
		response.sendRedirect("edittestimonial.jsp?TestimonyID="+TestimonyID+"&err=toofew"); return;}
		
	out.print(testimony);
	out.print(TestimonyID);
	try {
		String query = "UPDATE Testimony SET Testimony = '"+testimony+"' WHERE TestimonyID = "+TestimonyID+"";
		st.executeUpdate(query);
	}
	catch (Exception e){
		con.close();
		response.sendRedirect("edittestimonial.jsp?TestimonyID="+TestimonyID+"&err=unknownerror"); return;
	}
	
	con.close();
	response.sendRedirect("edittestimonial.jsp?TestimonyID="+TestimonyID+"&mess=success"); return;
%>