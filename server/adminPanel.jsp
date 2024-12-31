<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Panel</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 font-sans">
	
	<%
	    // Check if the user is logged in
	    String loggedInUser = (String) session.getAttribute("email");
	    if (loggedInUser == null) {
	        // Redirect to login page if the user is not logged in
	        response.sendRedirect("login.jsp");
	        return; // Prevent further execution of the page
	    }
	%>
	
    <div class="flex h-screen">

        <!-- Sidebar -->
        <aside class="w-1/5 bg-gray-800 text-white">
            <div class="p-4 text-center">
                <h2 class="text-2xl font-bold">Admin Panel</h2>
            </div>
            <nav class="mt-8">
                <ul>
                    <li class="px-4 py-2 hover:bg-gray-400">
                        <a href="manageUsers.jsp" class="block">Manage Users</a>
                    </li>
                    <li class="px-4 py-2 hover:bg-gray-400">
                        <a href="viewProduct.jsp" class="block">View Products</a>
                    </li>
                    <li class="px-4 py-2 hover:bg-gray-400">
                        <a href="addProduct.jsp" class="block">Add Product</a>
                    </li>
                    <li class="px-4 py-2 hover:bg-gray-400">
                        <a href="logout.jsp" class="block">Logout</a>
                    </li>
                </ul>
            </nav>
        </aside>

        <!-- Main Content -->
        <main class="flex-1 p-6">
            <h1 class="text-3xl font-semibold mb-4">Welcome, Admin!</h1>

            <!-- Functionalities Section -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <!-- Example Functionality Cards -->
                <div class="bg-white p-4 rounded shadow">
                    <h3 class="text-lg font-bold">Manage Users</h3>
                    <p class="text-gray-700">View, update, or delete user details.</p>
                    <a href="manageUsers.jsp" class="text-blue-800 hover:underline mt-2 inline-block">Go</a>
                </div>
                <div class="bg-white p-4 rounded shadow">
                    <h3 class="text-lg font-bold">View Products</h3>
                    <p class="text-gray-700">Browse and manage all listed products.</p>
                    <a href="viewProduct.jsp" class="text-blue-800 hover:underline mt-2 inline-block">Go</a>
                </div>
                <div class="bg-white p-4 rounded shadow">
                    <h3 class="text-lg font-bold">Add New Product</h3>
                    <p class="text-gray-700">Add new items to your product catalog.</p>
                    <a href="addProduct.jsp" class="text-gray-800 hover:underline mt-2 inline-block">Go</a>
                </div>
            </div>
        </main>
    </div>

</body>
</html>
