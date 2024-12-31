<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
	
    <div class="flex items-center justify-center h-screen">
        <div class="bg-white p-8 rounded shadow-md w-96">
            <h2 class="text-2xl font-semibold text-center mb-4" style=" font-family: 'Poppins', sans-serif;">Admin Login</h2>

            <!-- Login Form -->
            <form action="../AdminLoginServlet" method="POST">
                <div class="mb-4">
                    <label for="email" class="block text-gray-700">Email:</label>
                    <input type="email" id="email" name="email" class="w-full p-3 border border-gray-300 rounded" required>
                </div>

                <div class="mb-4">
                    <label for="password" class="block text-gray-700">Password:</label>
                    <input type="password" id="password" name="password" class="w-full p-3 border border-gray-300 rounded" required>
                </div>

                <div class="mb-4 text-center">
                    <button type="submit" class="w-full py-3 bg-blue-500 text-white rounded hover:bg-blue-600">Login</button>
                </div>
                
            </form>
        </div>
    </div>

</body>
</html>