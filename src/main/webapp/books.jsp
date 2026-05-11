<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bookstore.dao.BookDAO, com.bookstore.model.Book, java.util.List, java.util.Map, com.bookstore.model.CartItem" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = (String) session.getAttribute("username");
    BookDAO bookDAO = new BookDAO();
    List<Book> books = bookDAO.getAllBooks();

    @SuppressWarnings("unchecked")
    Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
    int cartCount = (cart != null) ? cart.values().stream().mapToInt(CartItem::getQuantity).sum() : 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Books — PageTurner</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<nav class="navbar">
    <a href="books.jsp" class="brand">📚 Page<span>Turner</span></a>
    <div class="nav-links">
        <a href="books.jsp" class="active">Browse Books</a>
        <a href="cart.jsp">🛒 Cart <% if (cartCount > 0) { %><span class="cart-badge"><%= cartCount %></span><% } %></a>
        <a href="#" style="color:#DDD; cursor:default;">👤 <%= username %></a>
        <a href="LogoutServlet" style="color:#F99;">Sign Out</a>
    </div>
</nav>

<div class="page-hero">
    <h1>Our Collection</h1>
    <p>Discover your next great read from our curated selection</p>
</div>

<div class="container">
    <% if (request.getAttribute("successMessage") != null) { %>
        <div class="alert alert-success"><%= request.getAttribute("successMessage") %></div>
    <% } %>

    <% if (books == null || books.isEmpty()) { %>
        <div class="empty-state">
            <div class="icon">📖</div>
            <h3>No Books Available</h3>
            <p>Our collection is being updated. Please check back soon.</p>
        </div>
    <% } else { %>
    <div class="books-grid">
        <% for (Book book : books) { %>
        <div class="book-card">
            <div class="book-cover" style="font-size:3.5rem;">
                <%= book.getCoverImage() != null && !book.getCoverImage().isEmpty() ? book.getCoverImage() : "📗" %>
            </div>
            <div class="book-info">
                <div class="book-title"><%= book.getTitle() %></div>
                <div class="book-author">by <%= book.getAuthor() %></div>
                <div class="book-genre"><%= book.getGenre() %></div>
                <div class="book-price">₹<%= String.format("%.2f", book.getPrice()) %></div>
                <p class="book-desc"><%= book.getDescription().length() > 80 ? book.getDescription().substring(0, 80) + "..." : book.getDescription() %></p>
                <form action="CartServlet" method="post" style="margin-top:12px;">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="bookId" value="<%= book.getId() %>">
                    <button type="submit" class="btn btn-primary btn-sm btn-full">🛒 Add to Cart</button>
                </form>
            </div>
        </div>
        <% } %>
    </div>
    <% } %>
</div>

<footer>
    &copy; 2024 <span>PageTurner Bookstore</span>. All rights reserved.
</footer>
<script src="js/script.js"></script>
</body>
</html>
