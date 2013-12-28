<%@ include file='connect.jsp' %>
<%
	String productID = (String) request.getParameter("productID");
	
	String price,stock;
	price = (String) request.getParameter("price");
	stock = (String) request.getParameter("stock");
	int price2,stock2;
	
	if (price == null || price.equals("")){
		response.sendRedirect("updateproduct.jsp?&productid="+productID+"&err=noprice"); return;}
	
	try{
		price2 = Integer.parseInt(price);
	}
	catch(Exception e)
	{
		con.close();
		response.sendRedirect("updateproduct.jsp?&productid="+productID+"&err=pricealp"); return;}
	
	if (stock == null || stock.equals("")){
		response.sendRedirect("updateproduct.jsp?&productid="+productID+"&err=nostock"); return;}
		
	try{
		stock2 = Integer.parseInt(stock);
	}
	catch(Exception e)
	{
		con.close();
		response.sendRedirect("updateproduct.jsp?&productid="+productID+"&err=stockalp"); return;
	}
	
	try{
		String update = "UPDATE Product SET Price = "+price2+" WHERE ProductID = "+productID+" ";
		st.executeUpdate(update);
		update = "UPDATE Stock SET Stock = "+stock2+" WHERE ProductID = "+productID+"";
		st.executeUpdate(update);
	}
	catch(Exception e)
	{
		con.close();
		response.sendRedirect("updateproduct.jsp?&productid="+productID+"&err=unknownerror"); return;
	}
	
	con.close();
	response.sendRedirect("updateproduct.jsp?&productid="+productID+"&mess=success"); return;
	
%>