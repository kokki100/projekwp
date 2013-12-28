<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page language="java" import="java.util.*"%>
<t:templateHead>
	<jsp:attribute name="pageTitle">Bluelight Online Shop</jsp:attribute>
	<jsp:attribute name="header"></jsp:attribute>
	<jsp:attribute name="content"></jsp:attribute>
</t:templateHead>

<div style="width: 100%;">

<%
String userId = "", username = "", firstName = "", middleName = "", lastName = "", email = "", phone = "", address = "", loginTime = "";

if (session.getAttribute("UserID") == null)
{
	// not logged in
%>
	<div style="text-align: center">
		You haven't logged in yet
	</div>
<% } else {
	// logged in
	userId		= (String)session.getAttribute("UserID");
	username	= (String)session.getAttribute("username");
	email		= (String)session.getAttribute("Email");
	phone		= (String)session.getAttribute("Phone");
	address		= (String)session.getAttribute("Address");
	loginTime	= (String)session.getAttribute("LoginTime");
%>
	<div style="text-align: center">
		Halo, Mr <%=firstName%>
	</div>
<% } %>



</div>
<t:templateFoot>
	<jsp:attribute name="footer"></jsp:attribute>
</t:templateFoot>