<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Details</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
	<!-- Navbar -->
	<%@ include file="navbar.jsp" %>
	
    <div class="container mx-auto mt-4">
	    
        <h2 class="text-3xl font-bold text-center mb-6">Product Details</h2>

        <%
            int productId = Integer.parseInt(request.getParameter("id")); 
            String dbURL = "jdbc:mysql://localhost:3306/furniture";
            String dbUser = "root";
            String dbPassword = "root";
          
            String sql = "SELECT pid, pname, price, description, image FROM product WHERE pid = ?";  
            
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, productId);  // Set the product ID parameter
                rs = stmt.executeQuery();

                if (rs.next()) {
                    String name = rs.getString("pname");  // Fetch product name
                    int price = rs.getInt("price");
                    String description = rs.getString("description");
                    String imagePath = rs.getString("image");
        %>

        <div class="flex flex-col justify-center items-center mb-6">
            <!-- Image with cover and center alignment -->
            <img src="<%= "." + imagePath %>" alt="<%= name %>" class="w-96 h-96 object-cover rounded-md">
            
            <h3 class="text-2xl font-semibold mb-4">Product: <%= name %></h3>
            <p class="text-lg text-gray-600">Price: $<%= price %></p>
            <p class="mt-2 text-gray-500">Description: <%= description %></p>
            
            <!-- Add to Cart Form -->
            <form action="cart.jsp" method="post"> 
                <input type="hidden" name="productId" value="<%= productId %>">
                <input type="number" name="quantity" value="1" min="1" class="w-20 text-center">
                <button type="submit" class="inline-block bg-yellow-500 text-gray-900 px-4 py-2 text-sm font-semibold rounded-full hover:bg-yellow-400">
                    Add to Cart
                </button>
            </form>
      
            <div class="mt-4">               
                <a href="product.jsp" class="inline-block bg-yellow-500 text-gray-900 px-4 py-2 text-sm font-semibold rounded-full hover:bg-yellow-400">
                    More Products
                </a>
            </div>
        </div>

        <% 
                } else {
                    out.println("<p class='text-red-500'>Product not found.</p>");
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
