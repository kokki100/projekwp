<%@ page language="java" import="java.util.*"%>
<%
String userId = (String) session.getAttribute("UserID");
if (userId == null) {
	response.sendRedirect("../home.jsp?nosession"); return;
}
%>
<%@ include file = 'connect.jsp' %>
<%
String query = "";
ResultSet rs = null;

String transactionId = request.getParameter("transactionid");

query = "SELECT 1 FROM Transaction WHERE TransactionId = "+transactionId;
if (!session.getAttribute("IsAdmin").equals("1")) query += " AND UserID = "+userId;
rs = st.executeQuery(query);
if (!rs.next()) {
	// no transaction id found
	response.sendRedirect("../transactionhistory.jsp"); return;
}

query = "SELECT DetailTransactionID, ProductID, Quantity FROM Transaction INNER JOIN DetailTransaction ON Transaction.TransactionID = DetailTransaction.TransactionID WHERE Transaction.TransactionID = "+transactionId;
rs = st.executeQuery(query);
ArrayList<String[]> products = new ArrayList<String[]>();
int totalProducts = 0;
while (rs.next()) {
	products.add(new String[] {rs.getString("DetailTransactionID"), rs.getString("ProductID"), rs.getString("Quantity")});
	totalProducts++;
}
for (int i = 0; i < totalProducts; i++) {
	// for each item, update stock, then delete detail transaction
	int detailId 	= Integer.parseInt(products.get(i)[0]);
	int productId	= Integer.parseInt(products.get(i)[1]);
	int quantity	= Integer.parseInt(products.get(i)[2]);

	query = "SELECT StockID, Stock FROM Stock WHERE ProductID = "+productId;
	rs = st.executeQuery(query);

	int stockId = -1;
	int stock = 0;

	if (rs.next()) {
		stockId	= Integer.parseInt(rs.getString("StockID"));
		stock	= Integer.parseInt(rs.getString("Stock"));
	}
	else {
		// no product found. anything wrong?
	}

	stock += quantity;

	if (stockId > 0) {
		query = "UPDATE Stock SET Stock = "+stock+" WHERE ProductID = "+productId;
		st.executeUpdate(query);
	}
	else {
		// no product found. anything wrong?
	}

	query = "DELETE FROM DetailTransaction WHERE DetailTransactionID = "+detailId;
	st.executeUpdate(query);
}

query = "DELETE FROM Transaction WHERE TransactionID = " + transactionId;
st.executeUpdate(query);

con.close();
response.sendRedirect("../transactionhistory.jsp");
%>