<%@ include file='connect.jsp' %>
<%
if (session.getAttribute("UserID") == null) {
	response.sendRedirect("home.jsp?err=nosession"); return;
}
%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page language="java" import="java.util.*"%>
<t:templateHead>
	<jsp:attribute name="pageTitle">Bluelight Online Shop</jsp:attribute>
	<jsp:attribute name="header"></jsp:attribute>
	<jsp:attribute name="content"></jsp:attribute>
</t:templateHead>

<div style="width: 100%;">
<%
if (session.getAttribute("IsAdmin").equals("1")) {
	String query = "SELECT ProductTypeID, ProductType FROM ProductType";
	ResultSet rs = st.executeQuery(query);
	ArrayList<String[]> productTypes = new ArrayList<String[]>();
	int totalProductType = 0;
	while (rs.next()) {
		totalProductType++;
		productTypes.add(new String[] {rs.getString("ProductTypeID"), rs.getString("ProductType")});
	}
	%>

	<%
	String err, mess;
	err = request.getParameter("err");
	mess = request.getParameter("mess");

	if (err == null || err.equals("")) {
		err = "";
	}
	else {
		if (err.equals("nolampname")) {
			err = "Lamp Name must be filled";
		}
		else if (err.equals("lampnametoolong")) {
			err = "Lamp Name must be not more than 25 characters";
		}
		else if (err.equals("nolamptype")) {
			err = "Lamp Type must be picked";
		}
		else if (err.equals("noprice")) {
			err = "Price must be filled";
		}
		else if (err.equals("pricenotnumber")) {
			err = "Price must be filled only with numbers";
		}
		else if (err.equals("nostock")) {
			err = "Stock must be filled";
		}
		else if (err.equals("stocknotnumber")) {
			err = "Stock must be filled only with numbers";
		}
		else if (err.equals("noimage")) {
			err = "Image must be chosen";
		}
		else if (err.equals("wrongimage")) {
			err = "Please upload *.jpg and *.png only";
		}
		else if (err.equals("lampnameexist")) {
			err = "Lamp name already exist, please use another name, or choose update product";
		}
		else {
			err = "unknown error";
		}
	}
	if (mess == null || mess.equals("")) {
		mess = "";
	}
	else {
		if (mess.equals("success")) {
			mess = "Add Product success";
		}
	}
	%>
	<div style="text-align: center">
		<h1 style="color: #FFA300; font-weight: normal">Manage Product</h1>

		<span style="color: #FF00FF">Add Lamp Form</span>

		<form method='post' action='doaddproduct.jsp'>
			<table style="margin: 0 auto; text-align: left">
				<tr>
					<td>Lamp Name</td>
					<td>:</td>
					<td><input type='text' name='lampName' maxlength="25" /></td>
				</tr>
				<tr>
					<td>Lamp Type</td>
					<td>:</td>
					<td>
						<select name="lampType">
							<option value="-1">--Pick Lamp Type--</option>
<% for(int i = 0; i < totalProductType; i++) { %>
							<option value="<%=productTypes.get(i)[0]%>"><%=productTypes.get(i)[1]%></option>
<% } %>
						</select>
					</td>
				</tr>
				<tr>
					<td>Price</td>
					<td>:</td>
					<td><input type='number' name='price' min='0' step="1000" /></td>
				</tr>
				<tr>
					<td>Stock</td>
					<td>:</td>
					<td><input type='number' name='stock' min='0' /></td>
				</tr>
				<tr>
					<td>Image</td>
					<td>:</td>
					<td><input type='file' name='image' /></td>
				</tr>
			</table>
<% if (err != null && !err.equals("")) { %>
			<div><span class="error"><%=err%></span></div>
<% } else if (mess != null && !mess.equals("")) { %>
			<div><span class="message"><%=mess%></span></div>
<% } %>
			<input type='submit' value='Add' />

		</form>
	</div>
<%
} else {
	out.println("<span class=\"error\">You need to login as Admin to view this page</span>");
}
%>
</div>
<t:templateFoot>
	<jsp:attribute name="footer"></jsp:attribute>
</t:templateFoot>
