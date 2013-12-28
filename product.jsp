<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page language="java" import="java.util.*"%>
<<<<<<< HEAD
<%@include file="connect-sample.jsp"%>
=======
>>>>>>> aa6cc45ec8c7cbdcbe000e1a7aff4d1a9d4b519b
<t:templateHead>
	<jsp:attribute name="pageTitle">Bluelight Online Shop</jsp:attribute>
	<jsp:attribute name="header"></jsp:attribute>
	<jsp:attribute name="content"></jsp:attribute>
</t:templateHead>
<<<<<<< HEAD

<div style="width: 100%;">
	<div style="text-align: center">
		<h1 style="color: #FFA300; font-weight: normal">Product</h1>
		
		<span style="color: #FF00FF">
			<form method='post' action='product.jsp'>
			search : 
			<select name="stype">
				<option>-Select Search Type-</option>
				<option>Name</option>
				<option>Type</option>
			</select>
			<input type="text"/ name="product">
			<input type="submit" value="search"/>
			</form>
		</span>
		
		<%
			if (session.getAttribute("Privilege").equals("1"))
			{
				out.print("<a href=#>Add Product</a>");
			}
		%>
		
		<table style="margin: 0 auto;" border="5">
			<tr>
				<td>LampName</td>
				<td>Type</td>
				<td>Price</td>
				<td>Stock</td>
				<td>Image</td>
				<% 
					if (session.getAttribute("UserID")!=null)
					{
						out.print("<td>Action</td>");
					}
				%>
			</tr>
			<%
				String product,stype;
				product=request.getParameter("product");
				stype=request.getParameter("stype");
				
				String query;
				if (stype==null)
					query = "SELECT Product.ProductID AS ProductID, Product.ProductName AS LampName, ProductType.ProductType AS Type, Product.Price, Stock.Stock AS Stock, Image FROM (Product INNER JOIN ProductType ON Product.ProductTypeID=ProductType.ProductTypeID) INNER JOIN Stock ON Product.ProductID = Stock.ProductID";
				else if (stype.equals("Name"))
					query = "SELECT Product.ProductID AS ProductID, Product.ProductName AS LampName, ProductType.ProductType AS Type, Product.Price, Stock.Stock AS Stock, Image FROM (Product INNER JOIN ProductType ON Product.ProductTypeID=ProductType.ProductTypeID) INNER JOIN Stock ON Product.ProductID = Stock.ProductID WHERE Product.ProductName = '"+product+"'";
				else if (stype.equals("Type"))
					query = "SELECT Product.ProductID AS ProductID, Product.ProductName AS LampName, ProductType.ProductType AS Type, Product.Price, Stock.Stock AS Stock, Image FROM (Product INNER JOIN ProductType ON Product.ProductTypeID=ProductType.ProductTypeID) INNER JOIN Stock ON Product.ProductID = Stock.ProductID WHERE ProductType.ProductType = '"+product+"'";
				else
					query = "SELECT Product.ProductID AS ProductID, Product.ProductName AS LampName, ProductType.ProductType AS Type, Product.Price, Stock.Stock AS Stock, Image FROM (Product INNER JOIN ProductType ON Product.ProductTypeID=ProductType.ProductTypeID) INNER JOIN Stock ON Product.ProductID = Stock.ProductID";
				
				ResultSet rs = stmt.executeQuery(query);
				
				while(rs.next())
				{
					out.print("<tr>");
					
					int pid=Integer.parseInt(rs.getString("ProductID"));
					
					out.print("<td>");
					out.print(rs.getString("LampName") + " <br />");
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("Type") + " <br />");
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("Price") + " <br />");
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("Stock") + " <br />");
					out.print("</td>");
					
					out.print("<td>");
					out.print(rs.getString("Image") + " <br />");
					out.print("</td>");
					
					if (session.getAttribute("UserID")!=null)
					{
						String pri = (String)session.getAttribute("Privilege");
						int privilege = Integer.parseInt(pri);
						
						if (privilege == 1)
							out.print("<td><a href=#>remove</a> <a href=#>update</a> </td>");
						else
							out.print("<td><a href=mancart.jsp?productid="+pid+">add</a></td>");
					}
					
					out.print("</tr>");
				}
			%>
		</table>
=======
<%@ include file='connect.jsp' %>
<%
boolean isLogin = false, isAdmin = false;
if (session.getAttribute("UserID") != null) {
	isLogin = true;
	if (session.getAttribute("IsAdmin") != null && session.getAttribute("IsAdmin").equals("1")) {
		isAdmin = true;
	}
}

// get product type for drop down list
String query = "SELECT ProductTypeID, ProductType FROM ProductType";
ResultSet rs = st.executeQuery(query);
ArrayList<String[]> productTypes = new ArrayList<String[]>();
int totalProductType = 0;
while (rs.next()) {
	totalProductType++;
	productTypes.add(new String[] {rs.getString("ProductTypeID"), rs.getString("ProductType")});
}

String searchType = request.getParameter("type");
String searchField = request.getParameter("searchField");

// get product
int itemPerPage = 4;
int currentPage, totalItem = 0, totalPage = 0;
if (request.getParameter("page") == null) currentPage = 1;
else {
	try {
		currentPage = Integer.parseInt(request.getParameter("page"));
	}
	catch(Exception e) {
		currentPage = 1;
	}
}

query = "SELECT Product.ProductID, ProductName, ProductType.ProductType, Price, Stock, Image ";
query += "FROM ((Product INNER JOIN ProductType ON Product.ProductTypeID = ProductType.ProductTypeID) ";
query += "INNER JOIN Stock ON Product.ProductID = Stock.ProductID) ";

if (searchType != null && !searchType.equals("-1")) {
	query += "WHERE Product.ProductTypeID = " + searchType;
	if (searchField != null && !searchField.equals("")) {
		query += " AND ProductName LIKE '%"+searchField+"%'";
	}
}

rs = st.executeQuery(query);
ArrayList<String[]> products = new ArrayList<String[]>();
String productId, productName, productType, price, stock, image;
while (rs.next()) {
	if (totalItem % itemPerPage == 0) totalPage++;
	totalItem++;

	if (totalPage == currentPage) {
		productId	= rs.getString("ProductID");
		productName	= rs.getString("ProductName");
		productType	= rs.getString("ProductType");
		price		= rs.getString("Price");
		stock		= rs.getString("Stock");
		image		= rs.getString("Image");
		products.add(new String[]{productId, productName, productType, price, stock, image});
	}
}
if (totalPage > 0 && currentPage > totalPage) {response.sendRedirect("product.jsp"); return;}
// out.print("Total Item: "+totalItem+"<br />");
// out.print("Total Page: "+totalPage+"<br />");
con.close();
%>
<div style="width: 100%;">
	<div style="text-align: center">
		<h1 style="color: #FFA300; font-weight: normal">Product</h1>

		<form method="get">
			Search : 
			<select name="type">
				<option value="-1">--Select Search Type--</option>
<% for(int i = 0; i < totalProductType; i++) { %>
				<option value="<%=productTypes.get(i)[0]%>" <% if (searchType != null && searchType.equals(productTypes.get(i)[0])) { %>selected<% } %>><%=productTypes.get(i)[1]%></option>
<% } %>
			</select>
			<input type="text" name="searchField" <% if (searchField != null) { %>value="<%=searchField%>"<% } %> />
			<button>search</button>
		</form>

<% if (isLogin && isAdmin) { %>
		<div>
			<a href="addproduct.jsp">Add Product</a>
		</div>
<% } %>
		<div style="margin-top: 20px;">
<% if (totalItem > 0) { %>
			<table class="withborder" style="text-align: center; margin-top: 20px; margin-left: auto; margin-right: auto">
				<thead>
					<tr>
						<th>Lamp Name</th>
						<th>Type</th>
						<th>Price</th>
						<th>Stock</th>
						<th>Image</th>
						<% if (isLogin) { %>
						<th>Action</th>
						<% } %>
					</tr>
				</thead>
				<tbody>
<% int totalProducts = products.size(); for (int i = 0; i < totalProducts; i++) { %>
					<tr>
						<td><%=products.get(i)[1]%></td>
						<td><%=products.get(i)[2]%></td>
						<td><%=products.get(i)[3]%></td>
						<td><%=products.get(i)[4]%></td>
						<td><img src="res/images/<%=products.get(i)[5]%>" style="width: 50px" /></td>
						<% if (isLogin) { %>
						<td>
						<% if (isAdmin) { %>
							<a href="removeproduct.jsp?productid=<%=products.get(i)[0]%>">Remove</a> | 
							<a href="updateproduct.jsp?productid=<%=products.get(i)[0]%>">Update</a>
						<% } else { %>
							<a href="managecart.jsp?productid=<%=products.get(i)[0]%>">Add</a>
						<% } %>
						</td>
						<% } %>
					</tr>
<% } %>
				</tbody>
				<tfoot>
					<tr>
						<% if (isLogin) { %>
						<td colspan="6">
						<% } else { %>
						<td colspan="5">
						<% } %>
						<% for (int i = 1; i <= totalPage; i++) {
							String param = "?page="+i;
							if (searchType != null && !searchType.equals("-1")) param+="&type="+searchType;
							if (searchField != null && !searchField.equals("")) param += "&searchField="+searchField;
						%>
							<a href="product.jsp<%=param%>"><%=i%></a>
						<% } %>
						</td>
					</tr>
				</tfoot>
			</table>
<% } else { %>
			<span class="error">There are currently no products</span>
<% } %>
		</div>
>>>>>>> aa6cc45ec8c7cbdcbe000e1a7aff4d1a9d4b519b
	</div>
</div>
<t:templateFoot>
	<jsp:attribute name="footer"></jsp:attribute>
</t:templateFoot>