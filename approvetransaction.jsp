<%@ page language="java" import="java.util.*"%>
<%
String userId = (String) session.getAttribute("UserID");
if (userId == null) {
	response.sendRedirect("home.jsp?nosession"); return;
}
if (!session.getAttribute("IsAdmin").equals("1")) {
	// only admin has access to this page
	response.sendRedirect("home.jsp"); return;
}
%>
<%@ include file = 'connect.jsp' %>
<%
String query = "";
ResultSet rs = null;

String transactionId = request.getParameter("transactionid");
if (transactionId == null || transactionId.equals("")) {
	con.close();
	response.sendRedirect("transactionhistory.jsp"); return;
}

query = "SELECT 1 FROM Transaction WHERE TransactionID = "+transactionId;
rs = st.executeQuery(query);
if (!rs.next()) {
	// no such transaction id found
	con.close();
	response.sendRedirect("transactionhistory.jsp"); return;
}

query = "UPDATE Transaction SET StatusApproved = 1 WHERE TransactionID = "+transactionId;
st.executeUpdate(query);

con.close();
response.sendRedirect("transactionhistory.jsp");
%>