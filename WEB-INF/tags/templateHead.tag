<%@ tag language="java" description="opening template" pageEncoding="UTF-8" %>
<%@ attribute name="pageTitle" fragment="true" %>
<%@ attribute name="header" fragment="true" %>
<%@ attribute name="content" fragment="true" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>
	<title><jsp:invoke fragment="pageTitle"></jsp:invoke></title>
	<t:include></t:include>
</head>
<body>
	<div id="header">
		<div style="width: 1024px; height: 300px; background-color: #CCCCCC">
			<img src="res/images/header.png" style="width: 1024px; height: 300px;">
		</div>
<% if (session.getAttribute("UserID") == null) { %>
		<t:nav></t:nav>
<% } else { %>
		<t:usernav></t:usernav>
<% } %>
		<jsp:invoke fragment="header"></jsp:invoke>
	</div>
	<div id="content">
		<jsp:invoke fragment="content"></jsp:invoke>
	