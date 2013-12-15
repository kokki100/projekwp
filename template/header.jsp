<div style="width: 100%; height: 300px; background-color: #CCCCCC">

</div>

<% if (session.getAttribute("name") == null) { %>
<%@include file='nav.jsp'%>
<% } else { %>
<%@include file='usernav.jsp'%>
<% } %>