<%
if (session.getAttribute("UserID") == null) {
	response.sendRedirect("home.jsp?nosession");
}

String userId = (String)session.getAttribute("UserID");
%>
<%@ include file='connect.jsp' %>
<%
String query = "";
ResultSet rs = null;

String transactionId = request.getParameter("transactionid");
String transactionDate = "";

query = "SELECT TransactionID, TransactionDate FROM Transaction WHERE TransactionId = "+transactionId;
if (!session.getAttribute("IsAdmin").equals("1")) query += " AND UserID = "+userId;
rs = st.executeQuery(query);
if (rs.next()) {
	transactionId = rs.getString("TransactionID");
	transactionDate = rs.getString("TransactionDate");
}
else {
	// no transaction id found
	con.close();
	response.sendRedirect("transactionhistory.jsp"); return;
}

query = "SELECT ProductName, Quantity, DetailTransaction.Price FROM DetailTransaction INNER JOIN Product ON Product.ProductID = DetailTransaction.ProductID WHERE TransactionID = "+transactionId;
rs = st.executeQuery(query);
ArrayList<String[]> items = new ArrayList<String[]>();
int totalItems = 0;
while (rs.next()) {
	String productName = rs.getString("ProductName");
	String quantity = rs.getString("Quantity");
	String price = rs.getString("Price");
	items.add(new String[] {productName, quantity, price});
	totalItems++;
}
if (totalItems < 1) {
	con.close();
	response.sendRedirect("transactionhistory.jsp"); return;
}

con.close();
%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page language="java" import="java.util.*"%>
<t:templateHead>
	<jsp:attribute name="pageTitle">Bluelight Online Shop</jsp:attribute>
	<jsp:attribute name="header"></jsp:attribute>
	<jsp:attribute name="content"></jsp:attribute>
</t:templateHead>

<div style="width: 100%;">
	<div style="text-align: center">
		<h1 style="color: #FFA300; font-weight: normal">Detail Transaction</h1>

		<div style="color: #FF00FF">
			Transaction ID : <%=transactionId%> | Transaction Date : <%=transactionDate%>
		</div>

		<table class="withborder center">
			<thead>
				<tr>
					<th>Product Name</th>
					<th>Price</th>
					<th>Quantity</th>
				</tr>
			</thead>
			<tbody>
<% for (int i = 0; i < totalItems; i++) {
	String productName	= items.get(i)[0];
	String quantity		= items.get(i)[1];
	String price		= items.get(i)[2];
%>
				<tr>
					<td><%=productName%></td>
					<td><%=price%></td>
					<td><%=quantity%></td>
				</tr>
<% } %>
			</tbody>
		</table>
	</div>
</div>
<t:templateFoot>
	<jsp:attribute name="footer"></jsp:attribute>
</t:templateFoot>