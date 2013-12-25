<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page language="java" import="java.util.*"%>
<t:templateHead>
	<jsp:attribute name="pageTitle">Bluelight Online Shop</jsp:attribute>
	<jsp:attribute name="header"></jsp:attribute>
	<jsp:attribute name="content"></jsp:attribute>
</t:templateHead>

<%
boolean isLogin = false;
if (session.getAttribute("UserID") != null) {
	isLogin = true;
}

// get product
int currentPage;
if (request.getParameter("page") == null) currentPage = 1;
else
	currentPage = (int) request.getParameter("page");

%>
<div style="width: 100%;">
	<div style="text-align: center">
		<h1 style="color: #FFA300; font-weight: normal">Product</h1>

<%=currentPage%>
		Search : 
		<select>
			<option>--Select Search Type--</option>
		</select>
		<input type="text" />
		<button>search</button>

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
<% // looping start
String productId, lampName, type, price, stock, image;
productId	= "1";
lampName	= "lamp 1";
type		= "type";
price		= "10000";
stock		= "12";
image		= "img.jpg";
%>
				<tr>
					<td><%=lampName%></td>
					<td><%=type%></td>
					<td><%=price%></td>
					<td><%=stock%></td>
					<td><img src="<%=image%>" style="width: 50px" /></td>
					<% if (isLogin) { %>
					<td><a href="addToCart?productId=<%=productId%>">Add</a></td>
					<% } %>
				</tr>
<% // looping end
%>
			</tbody>
			<tfoot>
				<tr>
					<% if (isLogin) { %>
					<td colspan="6">
					<% } else { %>
					<td colspan="5">
					<% } %>
					<a href="product.jsp?page=1">1</a>
					<a href="product.jsp?page=2">2</a>
					<a href="product.jsp?page=3">3</a>
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
</div>
<t:templateFoot>
	<jsp:attribute name="footer"></jsp:attribute>
</t:templateFoot>