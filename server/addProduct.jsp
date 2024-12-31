<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Product</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
	
	<%
	    // Check if the user is logged in
	    String loggedInUser = (String) session.getAttribute("email");
	    if (loggedInUser == null) {
	        // Redirect to login page if the user is not logged in
	        response.sendRedirect("login.jsp");
	        return; // Prevent further execution of the page
	    }
	%>
	 <!-- Navbar -->
    <%@ include file="navbar.jsp" %>
    <div class="flex items-center justify-center h-screen">
        <div class="bg-white p-8 rounded shadow-md w-full max-w-md">
            <h2 class="text-2xl font-semibold text-center mb-4">Add New Product</h2>

            <!-- Add Product Form -->
            <form action="../AddProductServlet" method="POST" enctype="multipart/form-data">
                <!-- Product Name -->
                <div class="mb-4">
                    <label for="name" class="block text-gray-700">Product Name:</label>
                    <input type="text" id="name" name="name" class="w-full p-3 border border-gray-300 rounded" required>
                </div>

                <!-- Product Price -->
                <div class="mb-4">
                    <label for="price" class="block text-gray-700">Price (in ₹):</label>
                    <input type="number" id="price" name="price" class="w-full p-3 border border-gray-300 rounded" required>
                </div>

                <!-- Product Description -->
                <div class="mb-4">
                    <label for="description" class="block text-gray-700">Description:</label>
                    <textarea id="description" name="description" rows="4" class="w-full p-3 border border-gray-300 rounded" required></textarea>
                </div>

                <!-- Product Image -->
                <div class="mb-4">
                    <label for="image" class="block text-gray-700">Product Image:</label>
                    <input type="file" id="image" name="image" class="w-full p-3 border border-gray-300 rounded" accept="image/*" required>
                </div>

                <!-- Submit Button -->
                <div class="mb-4 text-center">
                    <button type="submit" class="w-full py-3 bg-gray-800 text-white rounded hover:bg-blue-600">
                        Add Product
                    </button>
                </div>
            </form>
        </div>
    </div>

</body>
</html>
