<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page session="true" %>


<%
    // Check if the user is logged in
    String loggedInUser = (String) session.getAttribute("email");
    if (loggedInUser == null) {
        // Redirect to login page if the user is not logged in
        response.sendRedirect("login.jsp");
        return; // Prevent further execution of the page
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Page</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
	<!-- Navbar -->
    <%@ include file="navbar.jsp" %>
	
    <div class="container mx-auto mt-10">
        <h2 class="text-3xl font-bold text-center mb-6">Available Products</h2>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-12 mt-8">
            <%
                // Database connection details
                String dbURL = "jdbc:mysql://localhost:3306/furniture";
                String dbUser = "root";
                String dbPassword = "root";

                // SQL query to fetch product data
                String sql = "SELECT pid, pname, price, description, image FROM product";

                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(sql);

                    // Loop through and render products
                    while (rs.next()) {
                        String pid = rs.getString("pid");
                        String pname = rs.getString("pname");
                        int price = rs.getInt("price");
                        String description = rs.getString("description");
                        //String imagePath = rs.getString("image");
            %>
            <div class="bg-gray-200 p-6 rounded-lg shadow-lg">
                <img src="<%= "." + rs.getString("image") %>" alt="<%= pname %>" class="w-full h-48 object-cover rounded-md">
                <h3 class="mt-4 text-xl font-semibold"><%= pname %></h3>
                <p class="mt-2 text-gray-600">$<%= price %></p>
                <p class="mt-2 text-gray-500"><%= description %></p>
				<a href="productDetails.jsp?id=<%= rs.getInt("pid") %>" class="mt-4 inline-block bg-yellow-500 text-gray-900 px-4 py-2 text-sm font-semibold rounded-full hover:bg-yellow-400">View Details</a>
            </div>
            <%
                    }
                } catch (Exception e) {
                    out.println("<p class='text-red-500'>Error: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                       // out.println("<p class='text-red-500'>Error closing resources: " + e.getMessage() + "</p>");
                    }
                }
            %>
        </div>
    </div>
</body>
</html>
