<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page language="java" import="java.util.*"%>
<t:templateHead>
	<jsp:attribute name="pageTitle">Bluelight Online Shop</jsp:attribute>
	<jsp:attribute name="header"></jsp:attribute>
	<jsp:attribute name="content"></jsp:attribute>
</t:templateHead>
<%@ include file='connect.jsp' %>
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

String query = "";
ResultSet rs = null;

String userId = (String) session.getAttribute("UserID");
query = "SELECT * FROM Cart WHERE UserID = "+userId;
rs = st.executeQuery(query);

while(rs.next()) {
	String cartId, productId, price;
	rs.getString("CartID");
	rs.getString("");
}

con.close();
%>
<div style="width: 100%;">
	<div style="text-align: center">
		<h1 style="color: #FFA300; font-weight: normal">My Cart</h1>

		<form action="maketransaction.jsp">
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
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="3" style="text-align: right; color: #FF0000; border: 1px solid #FF0000">Grand Total</td>
						<td style="text-align: right; color: #FF0000; border: 1px solid #FF0000"></td>
					</tr>
					<tr>
						<td colspan="4" style="text-align: center">
							<button>Make Transaction</button>
							<a href="doclearcart.jsp">Clear cart</a>
						</td>
					</tr>
				</tfoot>
			</table>
		</form>
	</div>
</div>
<t:templateFoot>
	<jsp:attribute name="footer"></jsp:attribute>
</t:templateFoot>