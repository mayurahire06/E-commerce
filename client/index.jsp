<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Furniture Store</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body>
    <!-- Navbar -->
    <%@ include file="navbar.jsp" %>

    <!-- Hero Section -->
    <section class="bg-cover bg-center h-screen relative" style="background-image: url('assets/bg1.jpg');">
        <div class="absolute inset-0 bg-black opacity-50"></div>
        <div class="container mx-auto text-center text-white relative z-10 py-32">
            <h1 class="text-4xl md:text-6xl font-bold">Find Your Perfect Furniture</h1>
            <p class="mt-4 text-xl">Modern, Classic, and Comfortable Styles</p>
            <a href="#shop" class="mt-6 inline-block bg-yellow-500 text-gray-900 px-6 py-3 text-lg font-semibold rounded-full hover:bg-yellow-400">Shop Now</a>
        </div>
    </section>

    <!-- Featured Products -->
    <section id="shop" class="py-16 bg-white">
        <div class="fluid-container  text-center">
            <h2 class="text-3xl font-bold">Featured Products</h2>
            <p class="mt-4 text-xl text-gray-600">Browse our latest and best-selling furniture pieces.</p>
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-12 mt-8">
                <!-- Product 1 -->
                <div class="bg-gray-200 p-6 rounded-lg shadow-lg">
                    <img src="assets/sofa.jpg" alt="Product 1" class="w-full h-48 object-cover rounded-md">
                    <h3 class="mt-4 text-xl font-semibold">Modern Sofa</h3>
                    <p class="mt-2 text-gray-600">$499.99</p>
                    <a href="#" class="mt-4 inline-block bg-yellow-500 text-gray-900 px-4 py-2 text-sm font-semibold rounded-full hover:bg-yellow-400">View Details</a>
                </div>
                <!-- Product 2 -->
                <div class="bg-gray-200 p-6 rounded-lg shadow-lg">
                    <img src="assets/dining.jpeg" alt="Product 2" class="w-full h-48 object-cover rounded-md">
                    <h3 class="mt-4 text-xl font-semibold">Wooden Dining Table</h3>
                    <p class="mt-2 text-gray-600">$299.99</p>
                    <a href="#" class="mt-4 inline-block bg-yellow-500 text-gray-900 px-4 py-2 text-sm font-semibold rounded-full hover:bg-yellow-400">View Details</a>
                </div>
                <!-- Product 3 -->
                <div class="bg-gray-200 p-6 rounded-lg shadow-lg">
                    <img src="assets/armchair.jpeg" alt="Product 3" class="w-full h-48 object-cover rounded-md">
                    <h3 class="mt-4 text-xl font-semibold">Cozy Armchair</h3>
                    <p class="mt-2 text-gray-600">$199.99</p>
                    <a href="#" class="mt-4 inline-block bg-yellow-500 text-gray-900 px-4 py-2 text-sm font-semibold rounded-full hover:bg-yellow-400">View Details</a>
                </div>
                <!-- Product 4 -->
                <div class="bg-gray-200 p-6 rounded-lg shadow-lg">
                    <img src="assets/coffee.jpg" alt="Product 4" class="w-full h-48 object-cover rounded-md">
                    <h3 class="mt-4 text-xl font-semibold">Stylish Coffee Table</h3>
                    <p class="mt-2 text-gray-600">$150.00</p>
                    <a href="#" class="mt-4 inline-block bg-yellow-500 text-gray-900 px-4 py-2 text-sm font-semibold rounded-full hover:bg-yellow-400">View Details</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-gray-900 text-white py-6">
        <div class="container mx-auto text-center">
            <p>&copy; 2024 Furniture Store. All Rights Reserved.</p>
            <ul class="flex justify-center space-x-6 mt-4">
                <li><a href="#about" class="hover:text-yellow-500">About Us</a></li>
                <li><a href="#contact" class="hover:text-yellow-500">Contact</a></li>
                <li><a href="#" class="hover:text-yellow-500">Privacy Policy</a></li>
                <li><a href="#" class="hover:text-yellow-500">Terms of Service</a></li>
            </ul>
        </div>
    </footer>

</body>
</html>