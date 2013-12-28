<%@include file="connect-sample.jsp"%>
<%
	String username=request.getParameter("username");
	String password=request.getParameter("password");
	String conpass=request.getParameter("conpass");
	String address=request.getParameter("address");
	String telephone=request.getParameter("telephone");
	String email=request.getParameter("email");
	
	if (username == null || username.equals("")){
		response.sendRedirect("register.jsp?err=username must be filled");
		return;
	}
	
	String query = "SELECT UserID from User where UserName like '"+ username +"'";
	ResultSet rs = stmt.executeQuery(query);
	
	if (rs.next())
	{
		response.sendRedirect("register.jsp?err=username has been used");
		return;
	}
	
	if (password == null || password.equals("")){
		response.sendRedirect("register.jsp?err=pasword must be filled");
		return;
	}
	
	if (conpass == null || conpass.equals("")){
		response.sendRedirect("register.jsp?err=confirm password must be filed");
		return;
	}
	
	if (!conpass.equals(password)){
		response.sendRedirect("register.jsp?err=confirm password must equal to password");
		return;
	}
	
	if (address == null || address.equals("")){
		response.sendRedirect("register.jsp?err=address must be filed");
		return;
	}
	
	if (address.length() < 10){
		response.sendRedirect("register.jsp?err=address minimum 10 characters");
		return;
	}
	
	int i,j=0;
	for (i=0;i<address.length()-5;i++)
		if (address.substring(i,i+6).equals("street"))
			j=1;

	if (j==0){
		response.sendRedirect("register.jsp?err=address must contain street");
		return;
	}
	
	if (telephone == null || telephone.equals("")){
		response.sendRedirect("register.jsp?err=telephone must be filed");
		return;
	}
	
	j=-1;
	try{
		j=Integer.parseInt(telephone);
	}catch(Exception e){
		j=-1;
	}
	
	if (j==-1){
		response.sendRedirect("register.jsp?err=telehpne must numeric");
		return;
	}
		
	if (email == null || email.equals("")){
		response.sendRedirect("register.jsp?err=email must be filed");
		return;
	}
	
	int at=-1,dot=-1;
	for (i=0;i<email.length();i++)
		if (email.substring(i,i+1).equals("."))
			dot=i;
		else if (email.substring(i,i+1).equals("@"))
			at=i;
			
	if (at==-1){
		response.sendRedirect("register.jsp?err=email must contain @");
		return;
	}
	
	if (dot==-1){
		response.sendRedirect("register.jsp?err=email must contain dot");
		return;
	}
	
	if (dot<at){
		response.sendRedirect("register.jsp?err=email must contain dot after @");
		return;
	}
	
	if (dot==email.length()-1){
		response.sendRedirect("register.jsp?err=email must contain domain");
		return;
	}
	
	//String update = "";
	//stmt.executeUpdate(update);
		
%>