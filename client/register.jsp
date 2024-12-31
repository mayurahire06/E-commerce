<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registration Form</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 items-center h-screen">
	<!-- Navbar -->
    <%@ include file="navbar.jsp" %>
    <div class="flex justify-center mt-8">
	    <div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-md ">
	        <h2 class="text-2xl font-semibold text-gray-800 text-center mb-6">Create an Account</h2>
	        <form action="../RegisterServlet" method="POST">
	            <!-- Name -->
	            <div class="mb-4">
	                <label for="name" class="block text-gray-700 font-semibold">Name</label>
	                <input type="text" id="name" name="uname" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" required>
	            </div>
	            <!-- Email -->
	            <div class="mb-4">
	                <label for="email" class="block text-gray-700 font-semibold">Email</label>
	                <input type="email" id="email" name="email" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" required>
	            </div>
	            <!-- Password -->
	            <div class="mb-4">
	                <label for="password" class="block text-gray-700 font-semibold">Password</label>
	                <input type="password" id="password" name="password" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" required>
	            </div>
	            <!-- Phone -->
	            <div class="mb-4">
	                <label for="phone" class="block text-gray-700 font-semibold">Phone Number</label>
	                <input type="tel" id="phone" name="phone" class="w-full px-4 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" required>
	            </div>
	            <!-- Submit Button -->
	            <div class="mb-4 text-center">
	                <button type="submit" class="w-full bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-500">Register</button>
	            </div>
	        </form>
	         <%-- Display error message if registration fails --%>
	        <% String error = request.getParameter("registration");
	           if (error != null && error.equals("success")) { %>
	            <p style="color: red;">Email is already registered. Please login.</p>
	        <% } %>
	    </div>
	 </div>

</body>
</html>