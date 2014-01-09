<%@ include file='connect.jsp' %>
<%
	String productID = request.getParameter("productid");
	
	try{
		String Delete = "DELETE FROM Stock WHERE ProductID = "+productID+" ";
		st.executeUpdate(Delete);
		Delete = "DELETE FROM Product WHERE ProductID = "+productID+" ";
		st.executeUpdate(Delete);
	}
	catch(Exception e)
	{
		con.close();
		response.sendRedirect("../product.jsp");
	}
	
	con.close();
	response.sendRedirect("../product.jsp");
	
%>