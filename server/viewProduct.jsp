<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Orders</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-900">
	
	 <!-- Navbar -->
    <%@ include file="navbar.jsp" %>
    
    <div class="container mx-auto p-6">
        <h2 class="text-center text-3xl font-semibold mb-4">Ordered Products</h2>
        
        <!-- Table displaying products -->
        <table class="min-w-full table-auto border-collapse bg-white shadow-lg rounded-lg overflow-hidden">
            <thead class="bg-gray-800 text-white">
                <tr>
                    <th class="px-6 py-3 text-center">Order ID</th>
                    <th class="px-6 py-3 text-center">Product ID</th>
                    <th class="px-6 py-3 text-center">Product Name</th>
                    <th class="px-6 py-3 text-center">Quantity</th>
                    <th class="px-6 py-3 text-center">Price</th>
                    <th class="px-6 py-3 text-center">Total Amount</th>
                    <th class="px-6 py-3 text-center">Order Date</th>
                    <th class="px-6 py-3 text-center">Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Database connection details
                    String dbURL = "jdbc:mysql://localhost:3306/furniture"; // Replace with your database details
                    String dbUser = "root";
                    String dbPassword = "root";

                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;

                    try {
                        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                        stmt = conn.prepareStatement(
                            "SELECT o.oid, oi.pid, p.pname, oi.quantity, p.price, o.status, o.odate " +
                            "FROM orders o " +
                            "JOIN order_items oi ON o.oid = oi.oid " +
                            "JOIN product p ON oi.pid = p.pid " +
                            "ORDER BY o.oid DESC"); // Ordering by Order ID in descending order (latest first)

                        rs = stmt.executeQuery();

                        // SimpleDateFormat to format the order_date
                        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

                        // Display rows from the ResultSet directly in the table
                        while (rs.next()) {
                            int orderId = rs.getInt("oid");
                            int productId = rs.getInt("pid");
                            String productName = rs.getString("pname");
                            int quantity = rs.getInt("quantity");
                            int price = rs.getInt("price"); // Using int for price
                            int totalAmount = quantity * price; // Total amount calculation using int
                            String status = rs.getString("status");
                            Date orderDate = rs.getDate("odate"); // Assuming order_date is of type DATE

                            // Format the date for display
                            String formattedDate = (orderDate != null) ? dateFormat.format(orderDate) : "N/A";
                %>
                <tr class="border-t hover:bg-gray-50">
                    <td class="px-6 py-4 text-center"><%= orderId %></td>
                    <td class="px-6 py-4 text-center"><%= productId %></td>
                    <td class="px-6 py-4 text-center"><%= productName %></td>
                    <td class="px-6 py-4 text-center"><%= quantity %></td>
                    <td class="px-6 py-4 text-center"><%= price %></td>
                    <td class="px-6 py-4 text-center"><%= totalAmount %></td>
                    <td class="px-6 py-4 text-center"><%= formattedDate %></td> <!-- Display formatted order date -->
                    <td class="px-6 py-4 text-center"><%= status %></td>
                </tr>
                <%
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        // Close resources
                        try {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </tbody>
        </table>
    </div>

</body>
</html>
