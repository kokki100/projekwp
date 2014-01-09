<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page language="java" import="java.util.*"%>
<%@ include file='connect.jsp' %>
<t:templateHead>
	<jsp:attribute name="pageTitle">Bluelight Online Shop</jsp:attribute>
	<jsp:attribute name="header"></jsp:attribute>
	<jsp:attribute name="content"></jsp:attribute>
</t:templateHead>

<%
	String isAdmin = (String) session.getAttribute("IsAdmin");
	String productID = (String) request.getParameter("productid");
	if (isAdmin == null || isAdmin.equals("2"))
		response.sendRedirect("home.jsp");

	String err, mess;
	err = request.getParameter("err");
	mess = request.getParameter("mess");

	if (err == null || err.equals("")) {
		err = "";
	}
	else {
		if (err.equals("noprice")) {
			err = "Price must be filled";
		}
		else if (err.equals("nostock")) {
			err = "Stock must be filled";
		}
		else if (err.equals("nostock")) {
			err = "Price must numeric";
		}
		else if (err.equals("nostock")) {
			err = "Stock must numeric";
		}
	}
	if (mess == null || mess.equals("")) {
		mess = "";
	}
	else {
		if (mess.equals("success")) {
			mess = "Update success";
		}
	}
%>

<div style="width: 100%;">
	<div style="text-align: center">
		<h1 style="color: #FFA300; font-weight: normal">Manage Product</h1>
		<span style="color: #FF00FF">Update Lamp Form</span>
		
		<form method='post' action='action/doupdateproduct.jsp?productID=<%=productID%>'>
			<table style="margin: 0 auto; text-align: left">
				<%
					String query = "SELECT ProductName, ProductType.ProductType, Price, Image, Stock.Stock FROM (Product INNER JOIN ProductType ON Product.ProductTypeID = ProductType.ProductTypeID) INNER JOIN Stock ON Stock.ProductID = Product.ProductID WHERE Product.ProductID = "+productID+"";
					ResultSet rs = st.executeQuery(query);
					
					String productname, producttype, price, image, stock;
					while(rs.next())
					{
						productname = rs.getString("ProductName");
						producttype = rs.getString("ProductType");
						price = rs.getString("Price");
						image = rs.getString("Image");
						stock = rs.getString("Stock");
				%>
				<tr>
					<td>Lamp Name</td>
					<td>:</td>
					<td><input type='text' value="<%=productname%>" disabled="disabled"/></td>
				</tr>
				<tr>
					<td>Lamp Type</td>
					<td>:</td>
					<td><input type='text' value="<%=producttype%>" disabled="disabled"/></td>
				</tr>
				<tr>
					<td>Price</td>
					<td>:</td>
					<td><input type='text' name='price' value="<%=price%>"/></td>
				</tr>
				<tr>
					<td>Stock</td>
					<td>:</td>
					<td><input type='text' name='stock' value="<%=stock%>"/></td>
				</tr>
				<tr>
					<td>Image</td>
					<td>:</td>
					<td><img src="res/images/<%=image%>" style="width: 50px" /></td>
				</tr>
				<%
					}
				%>
			</table>
			<% if (err != null && !err.equals("")) { %>
				<div><span class="error"><%=err%></span></div>
			<% } else if (mess != null && !mess.equals("")) { %>
				<div><span class="message"><%=mess%></span></div>
			<% } %>
			<input type='submit' value='Change' />

		</form>
	</div>
</div>