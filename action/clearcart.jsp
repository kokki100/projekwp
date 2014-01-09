<%@ page language="java" import="java.util.*"%>
<%
String userId = (String) session.getAttribute("UserID");
if (userId == null) {
	response.sendRedirect("../home.jsp?err=nosession"); return;
}
%>

<%@ include file = 'connect.jsp' %>

<%
String query = "";
ResultSet rs = null;

query = "SELECT CartID, ProductID, Quantity FROM Cart WHERE UserID = "+userId;
rs = st.executeQuery(query);

ArrayList<String[]> items = new ArrayList<String[]>();
int totalItem = 0;
while (rs.next()) {
	String cartId = rs.getString("CartID");
	String productId = rs.getString("ProductID");
	String quantity = rs.getString("Quantity");
	items.add(new String[] {cartId, productId, quantity});
	totalItem++;
}

for (int i = 0; i < totalItem; i++) {
	String cartId		= items.get(i)[0];
	String productId	= items.get(i)[1];
	String quantity		= items.get(i)[2];
	int qty = Integer.parseInt(quantity);

	query = "SELECT StockID, Stock FROM Stock WHERE ProductID = "+productId;
	rs = st.executeQuery(query);
	int stockId = -1;
	int stock = 0;
	if (rs.next()) {
		stockId = Integer.parseInt(rs.getString("StockID"));
		stock = Integer.parseInt(rs.getString("Stock"));
		stock += qty;
	}

	if (stockId > 0) {
		query = "UPDATE Stock SET Stock = "+stock+" WHERE StockID = "+stockId;
		st.executeUpdate(query);
	}

	query = "DELETE FROM Cart WHERE CartID = "+cartId;
	st.executeUpdate(query);
	
}

con.close();
response.sendRedirect("../cart.jsp");
%>