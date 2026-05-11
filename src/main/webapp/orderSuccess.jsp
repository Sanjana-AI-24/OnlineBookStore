<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    Integer orderId = (Integer) session.getAttribute("lastOrderId");
    if (orderId == null) {
        response.sendRedirect("books.jsp");
        return;
    }
    Double total    = (Double) session.getAttribute("lastOrderTotal");
    String address  = (String) session.getAttribute("lastOrderAddress");
    String phone    = (String) session.getAttribute("lastOrderPhone");
    String username = (String) session.getAttribute("username");

    // Clear order session data after displaying
    session.removeAttribute("lastOrderId");
    session.removeAttribute("lastOrderTotal");
    session.removeAttribute("lastOrderAddress");
    session.removeAttribute("lastOrderPhone");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Placed! — PageTurner</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        @keyframes popIn {
            0%   { transform: scale(0.5); opacity: 0; }
            70%  { transform: scale(1.1); }
            100% { transform: scale(1);   opacity: 1; }
        }
        .success-icon { animation: popIn 0.6s ease forwards; }
    </style>
</head>
<body>

<nav class="navbar">
    <a href="books.jsp" class="brand">📚 Page<span>Turner</span></a>
    <div class="nav-links">
        <a href="books.jsp">Browse Books</a>
        <a href="cart.jsp">🛒 Cart</a>
        <a href="#" style="color:#DDD; cursor:default;">👤 <%= username %></a>
        <a href="LogoutServlet" style="color:#F99;">Sign Out</a>
    </div>
</nav>

<div class="success-wrapper">
    <div class="success-card">
        <div class="success-icon">🎉</div>
        <h1>Order Placed!</h1>
        <p>Thank you, <strong><%= username %></strong>! Your order has been successfully placed and will be delivered soon.</p>

        <div class="order-details-box">
            <div class="row">
                <span class="label">Order ID</span>
                <span class="value">#<%= String.format("%05d", orderId) %></span>
            </div>
            <div class="row">
                <span class="label">Total Amount</span>
                <span class="value">₹<%= String.format("%.2f", total) %></span>
            </div>
            <div class="row">
                <span class="label">Delivery Address</span>
                <span class="value" style="max-width:55%; text-align:right; word-break:break-word;"><%= address %></span>
            </div>
            <div class="row">
                <span class="label">Contact Phone</span>
                <span class="value"><%= phone %></span>
            </div>
            <div class="row">
                <span class="label">Shipping</span>
                <span class="value" style="color:green;">FREE</span>
            </div>
            <div class="row">
                <span class="label">Status</span>
                <span class="value" style="color:var(--gold);">✓ Order Placed</span>
            </div>
        </div>

        <p style="font-size:0.88rem;">You will receive a confirmation shortly. Our delivery team will contact you on <strong><%= phone %></strong>.</p>

        <div style="margin-top:28px; display:flex; gap:12px; justify-content:center; flex-wrap:wrap;">
            <a href="books.jsp" class="btn btn-primary">Continue Shopping 📚</a>
        </div>
    </div>
</div>

<footer>
    &copy; 2024 <span>PageTurner Bookstore</span>. All rights reserved.
</footer>
<script src="js/script.js"></script>
</body>
</html>
