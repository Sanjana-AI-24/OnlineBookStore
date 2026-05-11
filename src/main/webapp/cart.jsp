<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map, com.bookstore.model.CartItem" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    @SuppressWarnings("unchecked")
    Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
    int cartCount = (cart != null) ? cart.values().stream().mapToInt(CartItem::getQuantity).sum() : 0;
    double grandTotal = 0;
    if (cart != null) {
        for (CartItem item : cart.values()) grandTotal += item.getSubtotal();
    }
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart — PageTurner</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<nav class="navbar">
    <a href="books.jsp" class="brand">📚 Page<span>Turner</span></a>
    <div class="nav-links">
        <a href="books.jsp">Browse Books</a>
        <a href="cart.jsp" class="active">🛒 Cart <% if (cartCount > 0) { %><span class="cart-badge"><%= cartCount %></span><% } %></a>
        <a href="#" style="color:#DDD; cursor:default;">👤 <%= username %></a>
        <a href="LogoutServlet" style="color:#F99;">Sign Out</a>
    </div>
</nav>

<div class="page-hero">
    <h1>Shopping Cart</h1>
    <p>Review your selected books before placing an order</p>
</div>

<div class="container">

    <% if (cart == null || cart.isEmpty()) { %>
        <div class="empty-state">
            <div class="icon">🛒</div>
            <h3>Your cart is empty</h3>
            <p>Looks like you haven't added any books yet.</p>
            <a href="books.jsp" class="btn btn-primary mt-20">Browse Books</a>
        </div>
    <% } else { %>

    <table class="cart-table">
        <thead>
            <tr>
                <th>Book</th>
                <th>Author</th>
                <th>Unit Price</th>
                <th>Quantity</th>
                <th>Subtotal</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <% for (CartItem item : cart.values()) { %>
            <tr>
                <td>
                    <strong style="font-family:'Playfair Display',serif;"><%= item.getBook().getTitle() %></strong>
                    <br><span style="font-size:0.8rem;color:var(--muted);"><%= item.getBook().getGenre() %></span>
                </td>
                <td style="color:var(--muted);"><%= item.getBook().getAuthor() %></td>
                <td style="font-weight:700;">₹<%= String.format("%.2f", item.getBook().getPrice()) %></td>
                <td>
                    <form action="CartServlet" method="post" style="display:flex; align-items:center; gap:6px;">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="bookId" value="<%= item.getBook().getId() %>">
                        <button type="button" onclick="updateQty(<%= item.getBook().getId() %>, -1)" class="btn btn-sm btn-outline" style="padding:4px 10px;">−</button>
                        <input type="number" id="qty-<%= item.getBook().getId() %>" name="quantity" value="<%= item.getQuantity() %>" min="1" max="99" class="qty-input">
                        <button type="button" onclick="updateQty(<%= item.getBook().getId() %>, 1)" class="btn btn-sm btn-outline" style="padding:4px 10px;">+</button>
                        <button type="submit" class="btn btn-sm btn-dark" style="padding:5px 12px;">↻</button>
                    </form>
                </td>
                <td style="font-weight:700; color:var(--brown);">₹<%= String.format("%.2f", item.getSubtotal()) %></td>
                <td>
                    <form action="CartServlet" method="post" onsubmit="return confirmDelete('Remove this book from cart?')">
                        <input type="hidden" name="action" value="remove">
                        <input type="hidden" name="bookId" value="<%= item.getBook().getId() %>">
                        <button type="submit" class="btn btn-sm btn-danger">Remove</button>
                    </form>
                </td>
            </tr>
        <% } %>
        </tbody>
    </table>

    <div class="cart-summary">
        <div class="total-row">
            <span>Items in cart</span>
            <span><%= cartCount %> item(s)</span>
        </div>
        <div class="total-row">
            <span>Subtotal</span>
            <span>₹<%= String.format("%.2f", grandTotal) %></span>
        </div>
        <div class="total-row">
            <span>Shipping</span>
            <span style="color:green; font-weight:700;">FREE</span>
        </div>
        <div class="grand-total">
            <span>Grand Total</span>
            <span>₹<%= String.format("%.2f", grandTotal) %></span>
        </div>

        <div class="cart-actions">
            <a href="books.jsp" class="btn btn-outline">← Continue Shopping</a>
            <a href="checkout.jsp" class="btn btn-primary">Place Order →</a>
            <form action="CartServlet" method="post" style="margin:0;" onsubmit="return confirmDelete('Clear all items from cart?')">
                <input type="hidden" name="action" value="clear">
                <button type="submit" class="btn btn-danger">Clear Cart</button>
            </form>
        </div>
    </div>

    <% } %>
</div>

<footer>
    &copy; 2024 <span>PageTurner Bookstore</span>. All rights reserved.
</footer>
<script src="js/script.js"></script>
</body>
</html>
