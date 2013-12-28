<%@ page language="java" import="java.util.*"%>
<%
String userId = (String) session.getAttribute("UserID");
if (userId == null) {
	response.sendRedirect("home.jsp?nosession"); return;
}
if (session.getAttribute("IsAdmin").equals("1")) {
	// admin has no access to this page
	response.sendRedirect("home.jsp"); return;
}
%>
<%@ include file = 'connect.jsp' %>
<%
String query = "";
ResultSet rs = null;

ArrayList<String[]> cartItems = new ArrayList<String[]>();

query = "SELECT CartID, Cart.ProductID, Quantity, Price FROM Cart INNER JOIN Product ON Product.ProductID = Cart.ProductID WHERE UserID = "+userId;
rs = st.executeQuery(query);
int totalItem = 0;
while (rs.next()) {
	String cartId		= rs.getString("CartID");
	String productId	= rs.getString("ProductID");
	String quantity		= rs.getString("Quantity");
	String price		= rs.getString("Price");

	cartItems.add(new String[] {cartId, productId, quantity, price});
	totalItem++;
}

if (totalItem > 0) {
	query = "INSERT INTO Transaction (UserID, TransactionDate, StatusApproved) VALUES ("+userId+", NOW(), 0)";
	st.executeUpdate(query);

	int transactionId;

	query = "SELECT TOP 1 TransactionID FROM Transaction WHERE UserID = "+userId+" ORDER BY TransactionDate DESC";
	rs = st.executeQuery(query);
	if (rs.next()) {
		transactionId = Integer.parseInt(rs.getString("TransactionID"));
	}
	else {
		// error inserting to table Transaction
		out.println("error while inserting transaction data"); con.close(); return;
	}

	for (int i = 0; i < totalItem; i++) {
		String cartId		= cartItems.get(i)[0];
		String productId	= cartItems.get(i)[1];
		String quantity		= cartItems.get(i)[2];
		String price		= cartItems.get(i)[3];

		query = "INSERT INTO DetailTransaction (TransactionID, ProductID, Quantity, Price) VALUES ("+transactionId+", "+productId+", "+quantity+", "+price+")";
		st.executeUpdate(query);

		query = "DELETE FROM Cart WHERE CartID = "+cartId;
		st.executeUpdate(query);
	}
}
else {
	// no data
	out.println("no data on your cart"); con.close(); return;
}

con.close();
response.sendRedirect("transactionhistory.jsp");
%>