<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bookstore.dao.BookDAO, com.bookstore.dao.OrderDAO, com.bookstore.model.Book, com.bookstore.model.Order, java.util.List" %>
<%
    if (!"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    BookDAO bookDAO = new BookDAO();
    OrderDAO orderDAO = new OrderDAO();
    List<Book> books = bookDAO.getAllBooks();
    List<Order> orders = orderDAO.getAllOrders();
    String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel — PageTurner</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<nav class="navbar">
    <a href="admin.jsp" class="brand">📚 Page<span>Turner</span></a>
    <div class="nav-links">
        <a href="admin.jsp" class="active">⚙ Admin Panel</a>
        <a href="#" style="color:#DDD; cursor:default;">👤 <%= username %> (Admin)</a>
        <a href="LogoutServlet" style="color:#F99;">Sign Out</a>
    </div>
</nav>

<div class="page-hero">
    <h1>Admin Dashboard</h1>
    <p>Manage books, view orders, and monitor the store</p>
</div>

<div class="container">

    <!-- Stats row -->
    <div style="display:grid; grid-template-columns:repeat(3,1fr); gap:20px; margin-bottom:32px;">
        <div style="background:var(--white); border-radius:10px; padding:24px; box-shadow:var(--shadow); text-align:center; border-top:4px solid var(--gold);">
            <div style="font-size:2.2rem; font-weight:900; color:var(--brown);"><%= books.size() %></div>
            <div style="color:var(--muted); font-size:0.9rem; font-weight:700;">Total Books</div>
        </div>
        <div style="background:var(--white); border-radius:10px; padding:24px; box-shadow:var(--shadow); text-align:center; border-top:4px solid var(--gold);">
            <div style="font-size:2.2rem; font-weight:900; color:var(--brown);"><%= orders.size() %></div>
            <div style="color:var(--muted); font-size:0.9rem; font-weight:700;">Total Orders</div>
        </div>
        <div style="background:var(--white); border-radius:10px; padding:24px; box-shadow:var(--shadow); text-align:center; border-top:4px solid var(--gold);">
            <div style="font-size:2.2rem; font-weight:900; color:var(--brown);">
                ₹<%= String.format("%.0f", orders.stream().mapToDouble(Order::getTotalAmount).sum()) %>
            </div>
            <div style="color:var(--muted); font-size:0.9rem; font-weight:700;">Total Revenue</div>
        </div>
    </div>

    <div class="admin-grid">

        <!-- Add Book Form -->
        <div class="admin-card">
            <h3>➕ Add New Book</h3>
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-error"><%= request.getAttribute("errorMessage") %></div>
            <% } %>
            <form action="AdminServlet" method="post">
                <input type="hidden" name="action" value="addBook">
                <div class="form-group">
                    <label>Book Title *</label>
                    <input type="text" name="title" placeholder="Enter book title" required>
                </div>
                <div class="form-group">
                    <label>Author *</label>
                    <input type="text" name="author" placeholder="Author name" required>
                </div>
                <div class="form-group">
                    <label>Price (₹) *</label>
                    <input type="number" name="price" step="0.01" min="0" placeholder="e.g. 299.00" required>
                </div>
                <div class="form-group">
                    <label>Genre *</label>
                    <select name="genre" required>
                        <option value="">Select Genre</option>
                        <option>Fiction</option>
                        <option>Non-Fiction</option>
                        <option>Mystery</option>
                        <option>Science Fiction</option>
                        <option>Fantasy</option>
                        <option>Biography</option>
                        <option>History</option>
                        <option>Self-Help</option>
                        <option>Romance</option>
                        <option>Thriller</option>
                        <option>Children</option>
                        <option>Poetry</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Description</label>
                    <textarea name="description" rows="3" placeholder="Brief book description"></textarea>
                </div>
                <div class="form-group">
                    <label>Stock *</label>
                    <input type="number" name="stock" min="0" placeholder="Available copies" required>
                </div>
                <div class="form-group">
                    <label>Cover Emoji</label>
                    <input type="text" name="coverImage" placeholder="e.g. 📕 or leave blank">
                    <div class="form-hint">Enter an emoji to represent the book cover</div>
                </div>
                <button type="submit" class="btn btn-primary">Add Book</button>
            </form>
        </div>

        <!-- Book List -->
        <div class="admin-card">
            <h3>📚 Manage Books</h3>
            <% if (books.isEmpty()) { %>
                <p style="color:var(--muted);">No books found.</p>
            <% } else { %>
            <div style="overflow-x:auto;">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Title</th>
                            <th>Author</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <% for (Book b : books) { %>
                        <tr>
                            <td style="font-weight:700; max-width:140px;"><%= b.getTitle() %></td>
                            <td style="color:var(--muted); font-size:0.85rem;"><%= b.getAuthor() %></td>
                            <td>₹<%= String.format("%.0f", b.getPrice()) %></td>
                            <td><%= b.getStock() %></td>
                            <td>
                                <form action="AdminServlet" method="post" onsubmit="return confirmDelete('Delete this book?')">
                                    <input type="hidden" name="action" value="deleteBook">
                                    <input type="hidden" name="bookId" value="<%= b.getId() %>">
                                    <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
            <% } %>
        </div>
    </div>

    <!-- Orders Table -->
    <div class="admin-card mt-32">
        <h3>📦 All Orders</h3>
        <% if (orders.isEmpty()) { %>
            <p style="color:var(--muted);">No orders yet.</p>
        <% } else { %>
        <div style="overflow-x:auto;">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>User ID</th>
                        <th>Address</th>
                        <th>Phone</th>
                        <th>Total</th>
                        <th>Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                <% for (Order o : orders) { %>
                    <tr>
                        <td style="font-weight:700;">#<%= String.format("%05d", o.getId()) %></td>
                        <td><%= o.getUserId() %></td>
                        <td style="font-size:0.82rem; max-width:160px;"><%= o.getAddress() %></td>
                        <td><%= o.getPhone() %></td>
                        <td style="font-weight:700; color:var(--brown);">₹<%= String.format("%.2f", o.getTotalAmount()) %></td>
                        <td style="font-size:0.82rem;"><%= o.getOrderDate() != null ? o.getOrderDate().toString().substring(0,16) : "N/A" %></td>
                        <td><span style="background:#E6F4EA; color:#2E7D32; padding:3px 10px; border-radius:4px; font-size:0.8rem; font-weight:700;"><%= o.getStatus() %></span></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>
        <% } %>
    </div>
</div>

<footer>
    &copy; 2024 <span>PageTurner Bookstore</span>. All rights reserved.
</footer>
<script src="js/script.js"></script>
</body>
</html>
