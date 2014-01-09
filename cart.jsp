<%
String userId = (String) session.getAttribute("UserID");
if (userId == null) {
	response.sendRedirect("home.jsp?err=nosession");
}
%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page language="java" import="java.util.*"%>
<t:templateHead>
	<jsp:attribute name="pageTitle">Bluelight Online Shop</jsp:attribute>
	<jsp:attribute name="header"></jsp:attribute>
	<jsp:attribute name="content"></jsp:attribute>
</t:templateHead>
<%@ include file='connect.jsp' %>
<%
// String err;
// if (err == null || err.equals("")) err = "";
// else {
// 	if (err.equals("noqty")) {
// 		err = "Quantity must be filled and must be more than 1";
// 	}
// 	else if (err.equals("qtynotnumber")) {
// 		err = "Quantity must be filled with number";
// 	}
// 	else if (err.equals("insufficientstock")) {
// 		err = "Insufficient Stock";
// 	}
// 	else {
// 		err = "Unknown Error";
// 	}
// }

String query = "";
ResultSet rs = null;

query = "SELECT CartID, ProductName, Quantity, Price FROM Cart INNER JOIN Product ON Product.ProductID = Cart.ProductID WHERE UserID = "+userId;
rs = st.executeQuery(query);
ArrayList<String[]> cartItems = new ArrayList<String[]>();
int totalItem = 0;
while(rs.next()) {
	String cartId, productName, price, quantity;
	cartId		= rs.getString("CartID");
	productName	= rs.getString("ProductName");
	quantity	= rs.getString("Quantity");
	price		= rs.getString("Price");
	cartItems.add(new String[] {cartId, productName, quantity, price});
	totalItem++;
}

con.close();
%>
<div style="width: 100%;">
	<div style="text-align: center">
		<h1 style="color: #FFA300; font-weight: normal">My Cart</h1>

		<form method="post" action="action/maketransaction.jsp">
			<table style="margin: 0 auto; text-align: left" class="withborder">
				<thead>
					<tr>
						<th>Lamp Name</th>
						<th>Price</th>
						<th>Quantity</th>
						<th>SubTotal</th>
					</tr>
				</thead>
				<tbody>
<%
String cartId, productName;
int price, quantity, subTotal = 0, grandTotal = 0;
for (int i = 0; i < totalItem; i++) {
	cartId		= cartItems.get(i)[0];
	productName	= cartItems.get(i)[1];
	quantity	= Integer.parseInt(cartItems.get(i)[2]);
	price		= Integer.parseInt(cartItems.get(i)[3]);
	subTotal	= quantity * price;
	grandTotal += subTotal;
%>
					<tr>
						<td><%=productName%></td>
						<td><%=price%></td>
						<td><%=quantity%></td>
						<td style="text-align: right"><%=subTotal%></td>
					</tr>
<% } %>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="3" style="text-align: right; color: #FF0000;">Grand Total</td>
						<td style="text-align: right; color: #FF0000;"><%=grandTotal%></td>
					</tr>
<% if (totalItem > 0) { %>
					<tr>
						<td colspan="4" style="text-align: center">
							<button>Make Transaction/Buy</button>
							<a href="action/clearcart.jsp">Clear cart</a>
						</td>
					</tr>
<% } %>
				</tfoot>
			</table>
		</form>
	</div>
</div>
<t:templateFoot>
	<jsp:attribute name="footer"></jsp:attribute>
</t:templateFoot>