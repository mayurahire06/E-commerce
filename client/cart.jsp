<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
	<!-- Navbar -->
	<%@ include file="navbar.jsp" %>
	
    <div class="container mx-auto mt-10">
        <h2 class="text-3xl font-bold text-center mb-6">Your Cart</h2>

        <%
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Get user ID from session
            HttpSession session1 = request.getSession(false);
            if (session1 == null || session1.getAttribute("uid") == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            int userId = (int) session1.getAttribute("uid");

            // Database credentials
            String dbURL = "jdbc:mysql://localhost:3306/furniture";
            String dbUser = "root";
            String dbPassword = "root";

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // Get product details from form and add to cart if applicable
            String productId = request.getParameter("productId");
            String quantityStr = request.getParameter("quantity");

            if (productId != null && quantityStr != null) {
                int productIdInt = Integer.parseInt(productId);
                int quantity = Integer.parseInt(quantityStr);

                String insertSql = "INSERT INTO cart (uid, pid, quantity) VALUES (?, ?, ?)";
                stmt = conn.prepareStatement(insertSql);
                stmt.setInt(1, userId);
                stmt.setInt(2, productIdInt);
                stmt.setInt(3, quantity);

                stmt.executeUpdate();
                stmt.close();
            }

            // Fetch cart details for display
            String sql = "SELECT c.cid, p.pname, p.price, c.quantity, (p.price * c.quantity) AS total_price " +
                         "FROM cart c " +
                         "JOIN product p ON c.pid = p.pid " +
                         "WHERE c.uid = ?";
            		
            /*String sql = "SELECT cart.cid, product.pname, product.price, cart.quantity, product.price * cart.quantity "+ 
		    "AS total_price "+
            	"FROM "+
            	    "cart, product "+
            	"WHERE "+ 
            	    "cart.pid = product.pid AND cart.uid = ?";*/
            		
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();

            boolean hasItems = false;
        %>

        <!-- Cart Table -->
        <div class="overflow-x-auto">
            <table class="table-auto w-full bg-white rounded-lg shadow-md">
                <thead>
                    <tr class="bg-gray-200">
                        <th class="px-4 py-2">Product Name</th>
                        <th class="px-4 py-2">Price</th>
                        <th class="px-4 py-2">Quantity</th>
                        <th class="px-4 py-2">Total</th>
                        <th class="px-4 py-2">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    while (rs.next()) {
                        hasItems = true;
                        String pname = rs.getString("pname");
                        int price = rs.getInt("price");
                        int quantity = rs.getInt("quantity");
                        int totalPrice = rs.getInt("total_price");
                        int cartId = rs.getInt("cid");
                    %>
                    <tr>
                        <td class="text-center border px-4 py-2"><%= pname %></td>
                        <td class="text-center border px-4 py-2">$<%= price %></td>
                        <td class="text-center border px-4 py-2"><%= quantity %></td>
                        <td class="text-center border px-4 py-2">$<%= totalPrice %></td>
                        <td class="text-center border px-4 py-2">
                            <!-- Remove from Cart -->
                            <form action="removeCart.jsp" method="post" class="inline">
                                <input type="hidden" name="cartId" value="<%= cartId %>">
                                <button type="submit" class="bg-red-500 text-white px-3 py-1 rounded-md hover:bg-red-600">
                                    Remove
                                </button>
                            </form>
                        </td>
                    </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
            <form action="order.jsp" method="post">
			    <button type="submit" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600">
			        Place Order
			    </button>
			</form>
        </div>

        <%
            if (!hasItems) {
                out.println("<p class='text-gray-500 text-center mt-4'>Your cart is empty.</p>");
            }
        } catch (Exception e) {
            out.println("<p class='text-red-500'>Error: " + e.getMessage() + "</p>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                out.println("<p class='text-red-500'>Error closing resources: " + e.getMessage() + "</p>");
            }
        }
        %>
    </div>
</body>
</html>
