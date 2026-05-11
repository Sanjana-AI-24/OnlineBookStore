<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map, com.bookstore.model.CartItem" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    @SuppressWarnings("unchecked")
    Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
    if (cart == null || cart.isEmpty()) {
        response.sendRedirect("books.jsp");
        return;
    }

    double grandTotal = 0;
    for (CartItem item : cart.values()) grandTotal += item.getSubtotal();

    int cartCount = cart.values().stream().mapToInt(CartItem::getQuantity).sum();
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout — PageTurner</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<nav class="navbar">
    <a href="books.jsp" class="brand">📚 Page<span>Turner</span></a>
    <div class="nav-links">
        <a href="books.jsp">Browse Books</a>
        <a href="cart.jsp">🛒 Cart <span class="cart-badge"><%= cartCount %></span></a>
        <a href="#" style="color:#DDD; cursor:default;">👤 <%= username %></a>
        <a href="LogoutServlet" style="color:#F99;">Sign Out</a>
    </div>
</nav>

<div class="page-hero">
    <h1>Checkout</h1>
    <p>Almost there! Enter your delivery details</p>
</div>

<div class="container">
    <div style="display:grid; grid-template-columns:1fr 1fr; gap:32px; align-items:start;">

        <!-- Delivery Form -->
        <div class="checkout-card" style="max-width:none;">
            <h2>Delivery Details</h2>
            <p class="sub">We'll deliver your books to this address</p>

            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-error"><%= request.getAttribute("errorMessage") %></div>
            <% } %>

            <form action="OrderServlet" method="post" onsubmit="return validateCheckoutForm()">
                <div class="form-group">
                    <label for="address">Delivery Address *</label>
                    <textarea id="address" name="address" rows="4" placeholder="Enter your complete address including flat/house no., street, city, state and PIN code" style="resize:vertical;"></textarea>
                    <div class="form-hint">Minimum 10 characters</div>
                    <div class="field-error" id="addressError"></div>
                </div>

                <div class="form-group">
                    <label for="checkoutPhone">Phone Number *</label>
                    <input type="tel" id="checkoutPhone" name="phone" placeholder="10-digit mobile number">
                    <div class="form-hint">We'll call you for delivery updates</div>
                    <div class="field-error" id="phoneError"></div>
                </div>

                <div style="display:flex; gap:12px; margin-top:8px;">
                    <a href="cart.jsp" class="btn btn-outline">← Back to Cart</a>
                    <button type="submit" class="btn btn-primary">Confirm Order ✓</button>
                </div>
            </form>
        </div>

        <!-- Order Summary -->
        <div class="admin-card">
            <h3>Order Summary</h3>
            <% for (CartItem item : cart.values()) { %>
            <div style="display:flex; justify-content:space-between; padding:10px 0; border-bottom:1px solid var(--border); font-size:0.9rem;">
                <div>
                    <div style="font-weight:700; font-family:'Playfair Display',serif;"><%= item.getBook().getTitle() %></div>
                    <div style="color:var(--muted); font-size:0.82rem;">by <%= item.getBook().getAuthor() %> × <%= item.getQuantity() %></div>
                </div>
                <div style="font-weight:700; color:var(--brown);">₹<%= String.format("%.2f", item.getSubtotal()) %></div>
            </div>
            <% } %>
            <div style="display:flex; justify-content:space-between; padding:14px 0 0; font-size:1.2rem; font-weight:700; font-family:'Playfair Display',serif; color:var(--brown);">
                <span>Total</span>
                <span>₹<%= String.format("%.2f", grandTotal) %></span>
            </div>
            <div style="margin-top:12px; padding:10px; background:#F0F7E8; border-radius:8px; font-size:0.85rem; color:#2E7D32; font-weight:700;">
                ✓ Free shipping on all orders
            </div>
        </div>
    </div>
</div>

<footer>
    &copy; 2024 <span>PageTurner Bookstore</span>. All rights reserved.
</footer>
<script src="js/script.js"></script>
</body>
</html>
