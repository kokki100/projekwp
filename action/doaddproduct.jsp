<%@ include file = "connect.jsp" %>
<%
	if (session.getAttribute("UserID") == null) {
		response.sendRedirect("../home.jsp?err=nosession"); return;
	}
	if (!session.getAttribute("IsAdmin").equals("1")) {
		response.sendRedirect("../home.jsp"); return;
	}

	String lampName = (String) request.getParameter("lampName");
	String lampType = (String) request.getParameter("lampType");
	String price = (String) request.getParameter("price");
	String stock = (String) request.getParameter("stock");
	String image = (String) request.getParameter("image");

	if (lampName.equals("")) {
		response.sendRedirect("../addproduct.jsp?err=nolampname"); return;
	}
	if (lampName.length() > 25) {
		response.sendRedirect("../addproduct.jsp?err=lampnametoolong"); return;
	}
	if (lampType.equals("") || lampType.equals("-1")) {
		response.sendRedirect("../addproduct.jsp?err=nolamptype"); return;
	}
	if (price.equals("")) {
		response.sendRedirect("../addproduct.jsp?err=noprice"); return;
	}
	try {
		int tmp = Integer.parseInt(price);
	} catch(NumberFormatException e) {
		response.sendRedirect("../addproduct.jsp?err=pricenotnumber"); return;
	}
	if (stock.equals("")) {
		response.sendRedirect("../addproduct.jsp?err=nostock"); return;
	}
	try {
		int tmp = Integer.parseInt(stock);
	} catch(NumberFormatException e) {
		response.sendRedirect("../addproduct.jsp?err=stocknotnumber"); return;
	}
	if (image == null || image.equals("")) {
		response.sendRedirect("../addproduct.jsp?err=noimage"); return;
	}
	// validate address format
	if (!image.contains(".jpg") && !image.contains(".png")) {
		response.sendRedirect("../addproduct.jsp?err=wrongimage"); return;
	}

	try {
		String query = "SELECT ProductID FROM Product WHERE ProductName = '"+lampName+"'";
		ResultSet rs = st.executeQuery(query);
		if (rs.next()) {
			response.sendRedirect("../addproduct.jsp?err=lampnameexist"); return;
		}

		query = "INSERT INTO Product(ProductName, ProductTypeID, Price, Image) VALUES ('"+lampName+"', '"+lampType+"', "+price+", '"+image+"')";
		st.executeUpdate(query);

		query = "SELECT ProductID FROM Product WHERE ProductName = '"+lampName+"'";
		rs = st.executeQuery(query);

		if (rs.next()) {
			String productId = rs.getString("ProductID");

			query = "INSERT INTO Stock (ProductID, Stock) VALUES ('"+productId+"', "+stock+")";
			st.executeUpdate(query);
		}
		else {
			con.close();
			response.sendRedirect("../addproduct.jsp?err=unknownerror"); return;
		}
	}
	catch (Exception e){
		//out.println(e.getMessage());
		con.close();
		response.sendRedirect("../addproduct.jsp?err=unknownerror"); return;
	}
	con.close();
	response.sendRedirect("../addproduct.jsp?mess=success"); return;
%>