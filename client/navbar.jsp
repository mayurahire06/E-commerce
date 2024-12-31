<!-- Navbar -->
<nav class="bg-gray-900 text-white p-4">
    <div class="container mx-auto max-w-screen-2xl flex justify-between items-center">
        <a href="index.jsp" class="text-2xl font-bold">Furniture Store</a>
        <ul class="flex space-x-6">
            <%
                String currentPage = request.getRequestURI();
            %>
            
                <li><a href="index.jsp" class="hover:text-yellow-500">Home</a></li>
            
            
            <%
                HttpSession navSession = request.getSession(false);
                if (navSession != null && navSession.getAttribute("email") != null) {
                    if (!currentPage.contains("product.jsp")) {
            %>
                <li><a href="product.jsp" class="hover:text-yellow-500">Shop</a></li>
               
                
            <% } %>
                <li><a href="logout.jsp" class="hover:text-yellow-500">Logout</a></li>
                             
            <%
           		if (!currentPage.contains("order.jsp")) {
            %>
                <li><a href="order.jsp" class="hover:text-yellow-500">Order</a></li>
            <%               
                }
            	if (!currentPage.contains("cart.jsp")) {
                %>
                    <li><a href="cart.jsp" class="hover:text-yellow-500">Cart</a></li>
                <%               
                    }
            
              } else {
                    if (!currentPage.contains("register.jsp")) {
            %>
                <li><a href="login.jsp" class="hover:text-yellow-500">Login</a></li>
                
            <%
                    }
             
                }
            %>
        </ul>
    </div>
</nav>

