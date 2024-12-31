<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order History</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
    <!-- Navbar -->
    <%@ include file="navbar.jsp" %>

    <div class="container mx-auto mt-10">
        <h2 class="text-3xl font-bold text-center mb-6">Your Orders</h2>

        <%
            Connection conn = null;
            PreparedStatement insertStmt = null;
            PreparedStatement selectStmt = null;
            ResultSet rs = null;

            try {
                // Get user ID from session
                HttpSession orderSession = request.getSession(false);
                if (orderSession == null || orderSession.getAttribute("uid") == null) {
                    response.sendRedirect("login.jsp"); // Redirect to login if not logged in
                    return;
                }

                int userId = (int) orderSession.getAttribute("uid");

                // Database connection details
                String dbURL = "jdbc:mysql://localhost:3306/furniture";
                String dbUser = "root";
                String dbPassword = "root";

                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

                // Insert a new order if the form is submitted
                String totalAmountParam = request.getParameter("totalAmount");
                String productNameParam = request.getParameter("productName");
                String quantityParam = request.getParameter("quantity");
                if (totalAmountParam != null && !totalAmountParam.isEmpty() && productNameParam != null && quantityParam != null) {
                    int totalAmount = Integer.parseInt(totalAmountParam);
                    int quantity = Integer.parseInt(quantityParam);

                    // Insert the order
                    String insertOrderSql = "INSERT INTO orders (uid, odate, tot_amt, status) VALUES (?, NOW(), ?, ?)";
                    insertStmt = conn.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS);
                    insertStmt.setInt(1, userId);
                    insertStmt.setInt(2, totalAmount);
                    insertStmt.setString(3, "Pending");
                    insertStmt.executeUpdate();

                    // Get the generated order ID
                    ResultSet generatedKeys = insertStmt.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        int orderId = generatedKeys.getInt(1);

                        // Insert order details
                        String insertOrderItemSql = "INSERT INTO order_items (oid, pid, quantity) SELECT ?, pid, ? FROM product WHERE pname = ?";
                        PreparedStatement itemStmt = conn.prepareStatement(insertOrderItemSql);
                        itemStmt.setInt(1, orderId);
                        itemStmt.setInt(2, quantity);
                        itemStmt.setString(3, productNameParam);
                        itemStmt.executeUpdate();
                        itemStmt.close();
                    }
                }

                // Fetch all orders for the user, sorted by most recent
                String selectSql = "SELECT o.oid, o.odate, o.status, oi.quantity, p.pname, oi.quantity * p.price AS tot_amt " +
                                   "FROM orders o " +
                                   "JOIN order_items oi ON o.oid = oi.oid " +
                                   "JOIN product p ON oi.pid = p.pid " +
                                   "WHERE o.uid = ? " +
                                   "ORDER BY o.odate DESC";
                		
                selectStmt = conn.prepareStatement(selectSql);
                selectStmt.setInt(1, userId);

                rs = selectStmt.executeQuery();

                boolean hasOrders = false;

                // Date format updated to "dd MM yyyy"
                SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
        %>
        <div class="overflow-x-auto">
            <table class="table-auto w-full bg-white rounded-lg shadow-md">
                <thead>
                    <tr class="bg-gray-200">
                        <th class="px-4 py-2">Order ID</th>
                        <th class="px-4 py-2">Product Name</th>
                        <th class="px-4 py-2">Quantity</th>
                        <th class="px-4 py-2">Total Amount</th>
                        <th class="px-4 py-2">Status</th>
                        <th class="px-4 py-2">Date</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        while (rs.next()) {
                            hasOrders = true;
                            int orderId = rs.getInt("oid");
                            Timestamp orderDate = rs.getTimestamp("odate");
                            int totalAmount = rs.getInt("tot_amt");
                            String status = rs.getString("status");
                            String productName = rs.getString("pname");
                            int quantity = rs.getInt("quantity");

                            String formattedDate = dateFormat.format(orderDate); // Format the date
                    %>
                    <tr>
                        <td class="text-center border px-4 py-2"><%= orderId %></td>
                        <td class="text-center border px-4 py-2"><%= productName %></td>
                        <td class="text-center border px-4 py-2"><%= quantity %></td>
                        <td class="text-center border px-4 py-2">$<%= totalAmount %></td>
                        <td class="text-center border px-4 py-2"><%= status %></td>
                        <td class="text-center border px-4 py-2"><%= formattedDate %></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
        <%
                if (!hasOrders) {
                    out.println("<p class='text-gray-500 text-center mt-4'>You have no orders.</p>");
                }
            } catch (Exception e) {
                out.println("<p class='text-red-500'>Error: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (insertStmt != null) insertStmt.close();
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
