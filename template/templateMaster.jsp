<%@include file='templateHeader.jsp'%>
<%
	if (session.getAttribute("name") == null)
	{
%>
<%@include file='templateNavigation.jsp'%>
<%
	}
	else
	{
%>
<%@include file='templateNavigationLogin.jsp'%>
<%
	}
%>