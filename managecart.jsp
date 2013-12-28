<%@ include file='connect.jsp' %>
<%
String query = "";
ResultSet rs = null;
boolean isLogin = false, isAdmin = false;
if (session.getAttribute("UserID") != null) {
	isLogin = true;
	if (session.getAttribute("IsAdmin") != null && session.getAttribute("IsAdmin").equals("1")) {
		isAdmin = true;
		response.sendRedirect("home.jsp"); return;
	}
}
else {
	response.sendRedirect("home.jsp?err=nosession"); return;
}
String productId = (String) request.getParameter("productid");
String qty = request.getParameter("qty");
String err = "";
String mess = "";

if (productId == null || productId.equals("")) {
	response.sendRedirect("product.jsp"); return;
}

query = "SELECT ProductName, ProductType.ProductType, Price, Stock, Image ";
query += "FROM ((Product INNER JOIN ProductType ON Product.ProductTypeID = ProductType.ProductTypeID) ";
query += "INNER JOIN Stock ON Product.ProductID = Stock.ProductID) ";
query += "WHERE Product.ProductID = "+productId;
rs = st.executeQuery(query);

String productName = "", productType = "", price = "", stock = "", image = "";
if (rs.next()) {
	productName	= rs.getString("ProductName");
	productType	= rs.getString("ProductType");
	price		= rs.getString("Price");
	stock		= rs.getString("Stock");
	image		= rs.getString("Image");
}
else {
	response.sendRedirect("home.jsp"); return;
}

if (request.getParameter("addcart") != null && request.getParameter("addcart").equals("Add Cart")) {
	// save data then redirect
	boolean validation = true;
	if (qty == null || qty.equals("")) {
		err = "noqty";
		validation = false;
	}
	if (validation) {
		try {
			int tmp = Integer.parseInt(qty);
		}
		catch (Exception e) {
			err = "qtynonumber";
			validation = false;
		}
	}
	if (validation) {
		int q = Integer.parseInt(qty);
		int s = Integer.parseInt(stock);
		if (q < 1) {
			err = "nostock";
			validation = false;
		}
		else if (q > s) {
			err = "insufficientstock";
			validation = false;
		}
	}

	if (validation) {
		String userId = (String) session.getAttribute("UserID");
		int q = Integer.parseInt(qty);
		int s = Integer.parseInt(stock);
		s -= q;
		query = "UPDATE Stock SET Stock = "+s+" WHERE ProductID = "+productId;
		st.executeUpdate(query);

		query = "SELECT CartID, Quantity FROM Cart WHERE UserID = "+userId+" AND ProductID = "+productId;
		rs = st.executeQuery(query);
		int newq = q;
		String cartId;
		if (rs.next()) {
			newq += Integer.parseInt(rs.getString("Quantity"));
			cartId = rs.getString("CartID");
			query = "UPDATE Cart SET Quantity = "+newq+" WHERE CartID = "+cartId;
		}
		else {
			query = "INSERT INTO Cart (UserID, ProductID, Quantity) VALUES ("+userId+", "+productId+", "+q+")";
		}
		st.executeUpdate(query);


		con.close();
		response.sendRedirect("cart.jsp"); return;
	}
	con.close();
}
%>

<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page language="java" import="java.util.*"%>
<t:templateHead>
	<jsp:attribute name="pageTitle">Bluelight Online Shop</jsp:attribute>
	<jsp:attribute name="header"></jsp:attribute>
	<jsp:attribute name="content"></jsp:attribute>
</t:templateHead>
<%
if (err == null || err.equals("")) err = "";
else {
	if (err.equals("noqty")) {
		err = "Quantity must be filled and must be more than 1";
	}
	else if (err.equals("qtynotnumber")) {
		err = "Quantity must be filled with number";
	}
	else if (err.equals("insufficientstock")) {
		err = "Insufficient Stock";
	}
	else {
		err = "Unknown Error";
	}
}

%>
<div style="width: 100%;">
	<div style="text-align: center">
		<h1 style="color: #FFA300; font-weight: normal">Manage Cart</h1>

		<span style="color: #FF00FF">Cart Form</span>

		<form method='post' action='managecart.jsp'>
			<table style="margin: 0 auto; text-align: left">
				<tr>
					<td>Lamp Name</td>
					<td>:</td>
					<td><input type='text' readonly disabled value="<%=productName%>" /></td>
				</tr>
				<tr>
					<td>Lamp Type</td>
					<td>:</td>
					<td>
						<input type="text" readonly disabled value="<%=productType%>" />
					</td>
				</tr>
				<tr>
					<td>Price</td>
					<td>:</td>
					<td><input type='text' readonly disabled value="<%=price%>" /></td>
				</tr>
				<tr>
					<td>Stock</td>
					<td>:</td>
					<td><input type='text' readonly disabled value="<%=stock%>" /></td>
				</tr>
				<tr>
					<td>Image</td>
					<td>:</td>
					<td><img src="res/images/<%=image%>" style="width: 100px" /></td>
				</tr>
				<tr>
					<td>Quantity</td>
					<td>:</td>
					<td><input type="number" min="1" max="<%=stock%>" name="qty" /></td>
				</tr>
			</table>
<% if (err != null && !err.equals("")) { %>
			<div><span class="error"><%=err%></span></div>
<% } %>
			<input type="hidden" name="productid" value="<%=productId%>" />
			<input type='submit' name="addcart" value='Add Cart' />

		</form>
	</div>
</div>
<t:templateFoot>
	<jsp:attribute name="footer"></jsp:attribute>
</t:templateFoot>