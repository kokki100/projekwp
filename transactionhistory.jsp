<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ page language="java" import="java.util.*"%>
<t:templateHead>
	<jsp:attribute name="pageTitle">Bluelight Online Shop</jsp:attribute>
	<jsp:attribute name="header"></jsp:attribute>
	<jsp:attribute name="content"></jsp:attribute>
</t:templateHead>

<div style="width: 100%;">
<%@ include file='connect.jsp' %>
<%
String userId = "", username = "";

if (session.getAttribute("UserID") == null) {
	response.sendRedirect("home.jsp?nosession");
}

userId		= (String)session.getAttribute("UserID");
username	= (String)session.getAttribute("username");
boolean isAdmin = false;
if (session.getAttribute("IsAdmin").equals("1")) isAdmin = true;

String query = "";
ResultSet rs = null;

if (isAdmin) { %>
	<div style="text-align: center">
		<h1 style="color: #FFA300; font-weight: normal">Waiting Transaction</h1>

		<% query = "SELECT TransactionID, TransactionDate FROM Transaction WHERE StatusApproved = 0";
		rs = st.executeQuery(query);
		int totalWaitingTransaction = 0;

		ArrayList<String[]> waitingTransactions = new ArrayList<String[]>();
		while (rs.next()) {
			String transactionId = rs.getString("TransactionID");
			String transactionDate = rs.getString("TransactionDate");
			waitingTransactions.add(new String[] {transactionId, transactionDate});
			totalWaitingTransaction++;
		}

		if (totalWaitingTransaction > 0) {
		%>
		<table class="withborder center">
			<thead>
				<tr>
					<th>TransactionId</th>
					<th>Username</th>
					<th>Transaction Date</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
			<% for (int i = 0; i < totalWaitingTransaction; i++) { 
				String transactionId	= waitingTransactions.get(i)[0];
				String transactionDate	= waitingTransactions.get(i)[1];
			%>
				<tr>
					<td><%=transactionId%></td>
					<td><%=username%></td>
					<td><%=transactionDate%></td>
					<td>
						<a href="action/removetransaction.jsp?transactionid=<%=transactionId%>">remove</a> |
						<a href="action/approvetransaction.jsp?transactionid=<%=transactionId%>">approve</a> |
						<a href="detailtransaction.jsp?transactionid=<%=transactionId%>">details</a>
					</td>
				</tr>
			<% } %>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="4" style="color: #FF00FF">Total Waiting Transaction: <%=totalWaitingTransaction%></td>
				</tr>
			</tfoot>
		</table>
		<% } else { %>
		<span class="error">There are no waiting transaction at this moment.</span>
		<% } %>
	</div>



	<div style="text-align: center">
		<h1 style="color: #FFA300; font-weight: normal">Approved Transaction</h1>

		<% query = "SELECT TransactionID, TransactionDate FROM Transaction WHERE StatusApproved = 1";
		rs = st.executeQuery(query);
		int totalApprovedTransaction = 0;

		ArrayList<String[]> approvedTransactions = new ArrayList<String[]>();
		while (rs.next()) {
			String transactionId = rs.getString("TransactionID");
			String transactionDate = rs.getString("TransactionDate");
			approvedTransactions.add(new String[] {transactionId, transactionDate});
			totalApprovedTransaction++;
		}

		if (totalApprovedTransaction > 0) {
		%>
		<table class="withborder center">
			<thead>
				<tr>
					<th>TransactionId</th>
					<th>Username</th>
					<th>Transaction Date</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
			<% for (int i = 0; i < totalApprovedTransaction; i++) { 
				String transactionId	= approvedTransactions.get(i)[0];
				String transactionDate	= approvedTransactions.get(i)[1];
			%>
				<tr>
					<td><%=transactionId%></td>
					<td><%=username%></td>
					<td><%=transactionDate%></td>
					<td>
						<a href="detailtransaction.jsp?transactionid=<%=transactionId%>">details</a>
					</td>
				</tr>
			<% } %>
			</tbody>
		</table>
		<% } else { %>
		<span class="error">There are no waiting transaction at this moment.</span>
		<% } %>
	</div>
<% } else { %>
	<div style="text-align: center">
		<h1 style="color: #FFA300; font-weight: normal">Waiting Transaction</h1>

		<% query = "SELECT TransactionID, TransactionDate FROM Transaction WHERE Transaction.UserID = "+userId+" AND StatusApproved = 0";
		rs = st.executeQuery(query);
		int totalWaitingTransaction = 0;

		ArrayList<String[]> waitingTransactions = new ArrayList<String[]>();
		while (rs.next()) {
			String transactionId = rs.getString("TransactionID");
			String transactionDate = rs.getString("TransactionDate");
			waitingTransactions.add(new String[] {transactionId, transactionDate});
			totalWaitingTransaction++;
		}

		if (totalWaitingTransaction > 0) {
		%>
		<table class="withborder center">
			<thead>
				<tr>
					<th>TransactionId</th>
					<th>Username</th>
					<th>Transaction Date</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
			<% for (int i = 0; i < totalWaitingTransaction; i++) { 
				String transactionId	= waitingTransactions.get(i)[0];
				String transactionDate	= waitingTransactions.get(i)[1];
			%>
				<tr>
					<td><%=transactionId%></td>
					<td><%=username%></td>
					<td><%=transactionDate%></td>
					<td>
						<a href="action/removetransaction.jsp?transactionid=<%=transactionId%>">remove</a> |
						<a href="detailtransaction.jsp?transactionid=<%=transactionId%>">details</a>
					</td>
				</tr>
			<% } %>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="4" style="color: #FF00FF">Total Waiting Transaction: <%=totalWaitingTransaction%></td>
				</tr>
			</tfoot>
		</table>
		<% } else { %>
		<span class="error">There are no waiting transaction at this moment.</span>
		<% } %>
	</div>

	<div style="text-align: center">
		<h1 style="color: #FFA300; font-weight: normal">Approved Transaction</h1>

		<% query = "SELECT TransactionID, TransactionDate FROM Transaction WHERE Transaction.UserID = "+userId+" AND StatusApproved = 1";
		rs = st.executeQuery(query);
		int totalApprovedTransaction = 0;

		ArrayList<String[]> approvedTransactions = new ArrayList<String[]>();
		while (rs.next()) {
			String transactionId = rs.getString("TransactionID");
			String transactionDate = rs.getString("TransactionDate");
			approvedTransactions.add(new String[] {transactionId, transactionDate});
			totalApprovedTransaction++;
		}

		if (totalApprovedTransaction > 0) {
		%>
		<table class="withborder center">
			<thead>
				<tr>
					<th>TransactionId</th>
					<th>Username</th>
					<th>Transaction Date</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
			<% for (int i = 0; i < totalApprovedTransaction; i++) { 
				String transactionId	= approvedTransactions.get(i)[0];
				String transactionDate	= approvedTransactions.get(i)[1];
			%>
				<tr>
					<td><%=transactionId%></td>
					<td><%=username%></td>
					<td><%=transactionDate%></td>
					<td>
						<a href="detailtransaction.jsp?transactionid=<%=transactionId%>">details</a>
					</td>
				</tr>
			<% } %>
			</tbody>
		</table>
		<% } else { %>
		<span class="error">There are no waiting transaction at this moment.</span>
		<% } %>
	</div>
<% } %>

</div>
<t:templateFoot>
	<jsp:attribute name="footer"></jsp:attribute>
</t:templateFoot>