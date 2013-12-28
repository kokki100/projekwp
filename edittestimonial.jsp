<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page language="java" import="java.util.*"%>
<%@ include file = "connect.jsp" %>

<t:templateHead>
	<jsp:attribute name="pageTitle">Bluelight Online Shop</jsp:attribute>
	<jsp:attribute name="header"></jsp:attribute>
	<jsp:attribute name="content"></jsp:attribute>
</t:templateHead>
<%
	String err,mess;
	err = request.getParameter("err");
	mess = request.getParameter("mess");
	
	if (err == null || err.equals("")) {
		err = "";
	}
	else {
		if (err.equals("empty")) {
			err = "testimony must be filled";
		}
		else
		if (err.equals("toofew")) {
			err = "testimony must contain at least 15 characters";
		}
	}
	if (mess == null || mess.equals("")) {
		mess = "";
	}
	else {
		if (mess.equals("success")) {
			mess = "Edit success";
		}
	}
	String isAdmin = (String) session.getAttribute("IsAdmin");
	String testimonyId = request.getParameter("TestimonyID");
	String testimony;

	String query = "SELECT Testimony FROM Testimony WHERE TestimonyID = "+testimonyId;
	ResultSet rs = st.executeQuery(query);
	if (rs.next()) {
		testimony = rs.getString("Testimony");
	}
	else {
		con.close();
		response.sendRedirect("testimonial.jsp"); return;
	}

	con.close();
%>

<div style="width: 100%;">
	<div style="text-align: center">
		<h1 style="color: #FFA300; font-weight: normal">Testimonial Updater</h1>
		<%
			if (isAdmin!=null)
			{
				//logged in
				%>
					<h5 style="color: aqua">Testimonial Editor</h5>
					
					<form method="post" action="doedittesti.jsp?TestimonyID=<%=testimonyId%>"\>
						<textarea rows="4" cols="40" name="testimony"><%=testimony%></textarea>
						</br>
						<% if (err != null && !err.equals("")) { %>
								<div><span class="error"><%=err%></span></div>
						<% } else if (mess != null && !mess.equals("")) { %>
									<div><span class="message"><%=mess%></span></div>
						<% } %>
						<input type="submit" value="Submit"/>
					</form>
				<%
			}
			else
				response.sendRedirect("home.jsp");
		%>
	</div>
</div>

<t:templateFoot>
	<jsp:attribute name="footer"></jsp:attribute>
</t:templateFoot>