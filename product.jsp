<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page language="java" import="java.util.*"%>
<%@include file="connect-sample.jsp"%>
<t:templateHead>
	<jsp:attribute name="pageTitle">Bluelight Online Shop</jsp:attribute>
	<jsp:attribute name="header"></jsp:attribute>
	<jsp:attribute name="content"></jsp:attribute>
</t:templateHead>

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
	</div>
</div>
<t:templateFoot>
	<jsp:attribute name="footer"></jsp:attribute>
</t:templateFoot>