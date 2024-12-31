<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>Manage Users' Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
	
	<% 
        String updateMessage = (String) request.getAttribute("updateMessage");
        if (updateMessage != null) {
            // Display the alert with the update message
    %>
        <script>
            alert("<%= updateMessage %>");
        </script>
    <% 
        }
    %>
    <!-- Navbar -->
    <%@ include file="navbar.jsp" %>
    <div class="container mx-auto mt-10">
        <h2 class="text-3xl font-bold text-center mb-6">Manage Users' Orders</h2>

        <%
            Connection conn = null;
            PreparedStatement selectStmt = null;
            PreparedStatement updateStmt = null;
            ResultSet rs = null;

            try {
                // Check if admin is logged in
                HttpSession adminSession = request.getSession(false);
                if (adminSession == null || adminSession.getAttribute("email") == null) {
                    response.sendRedirect("login.jsp"); // Redirect to admin login if not logged in
                    return;
                }

                // Database connection details
                String dbURL = "jdbc:mysql://localhost:3306/furniture";
                String dbUser = "root";
                String dbPassword = "root";

                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                // Fetch all users' orders
                String selectSql = "SELECT o.oid, o.uid, o.odate, o.status, oi.quantity, p.pname, oi.quantity * p.price AS tot_amt, u.uname " +
                                   "FROM orders o " +
                                   "JOIN order_items oi ON o.oid = oi.oid " +
                                   "JOIN product p ON oi.pid = p.pid " +
                                   "JOIN user u ON o.uid = u.uid " +
                                   "ORDER BY o.odate DESC";
                selectStmt = conn.prepareStatement(selectSql);
                rs = selectStmt.executeQuery();

                // Date format for displaying order date
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd MM yyyy");
        %>

        <!-- Table for displaying users' orders -->
        <div class="overflow-x-auto">
            <table class="table-auto w-full bg-white rounded-lg shadow-md">
                <thead>
                    <tr class="text-white bg-gray-800">
                        <th class="px-4 py-2">Order ID</th>
                        <th class="px-4 py-2">User Name</th>
                        <th class="px-4 py-2">Date</th>
                        <th class="px-4 py-2">Total Amount</th>
                        <th class="px-4 py-2">Status</th>
                        <th class="px-4 py-2">Product Name</th>
                        <th class="px-4 py-2">Quantity</th>
                        <th class="px-4 py-2">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        while (rs.next()) {
                            int orderId = rs.getInt("oid");
                            int userId = rs.getInt("uid");
                            Timestamp orderDate = rs.getTimestamp("odate");
                            String status = rs.getString("status");
                            String productName = rs.getString("pname");
                            int quantity = rs.getInt("quantity");
                            int totalAmount = rs.getInt("tot_amt");
                            String username = rs.getString("uname");

                            String formattedDate = dateFormat.format(orderDate); // Format the date
                    %>
                    <tr>
                        <td class="text-center border px-4 py-2"><%= orderId %></td>
                        <td class="text-center border px-4 py-2"><%= username %></td>
                        <td class="text-center border px-4 py-2"><%= formattedDate %></td>
                        <td class="text-center border px-4 py-2">$<%= totalAmount %></td>
                        <td class="text-center border px-4 py-2">
                            <form action="updateOrderStatus.jsp" method="post">
                                <select name="status" class="border px-2 py-1">
                                    <option value="Pending" <%= status.equals("Pending") ? "selected" : "" %>>Pending</option>
                                    <option value="Shipped" <%= status.equals("Shipped") ? "selected" : "" %>>Shipped</option>
                                    <option value="Delivered" <%= status.equals("Delivered") ? "selected" : "" %>>Delivered</option>
                                </select>
                                <input type="hidden" name="orderId" value="<%= orderId %>">
                                <button type="submit" class="bg-gray-800 text-white px-4 py-1 rounded">Update</button>                                
                            </form>
                        </td>
                        <td class="text-center border px-4 py-2"><%= productName %></td>
                        <td class="text-center border px-4 py-2"><%= quantity %></td>
                        <td class="text-center border px-4 py-2">
                            <form action="deleteOrder.jsp" method="post">
                                <input type="hidden" name="orderId" value="<%= orderId %>">
                                <button type="submit" class="bg-red-500 text-white px-4 py-1 rounded">Delete</button>
                            </form>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>

        <%
            } catch (Exception e) {
                out.println("<p class='text-red-500'>Error: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (selectStmt != null) selectStmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    out.println("<p class='text-red-500'>Error closing resources: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>
</body>
</html>
