<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user") != null) {
        if ("admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("admin.jsp");
        } else {
            response.sendRedirect("books.jsp");
        }
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login — PageTurner Bookstore</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="auth-wrapper">
    <div class="auth-box">
        <div class="auth-header">
            <div class="logo">📚 PageTurner</div>
            <p>Your curated online bookstore</p>
        </div>
        <div class="auth-body">
            <h2>Welcome Back</h2>

            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-error"><%= request.getAttribute("errorMessage") %></div>
            <% } %>
            <% if (request.getAttribute("successMessage") != null) { %>
                <div class="alert alert-success"><%= request.getAttribute("successMessage") %></div>
            <% } %>

            <form action="LoginServlet" method="post" onsubmit="return validateLoginForm()">
                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" placeholder="Enter your username" autocomplete="username">
                    <div class="field-error" id="usernameError"></div>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter your password" autocomplete="current-password">
                    <div class="field-error" id="passwordError"></div>
                </div>

                <div class="alert alert-info" style="font-size:0.82rem; padding:10px 14px; margin-bottom:16px;">
                    <strong>Sample credentials:</strong><br>
                    Admin — username: <strong>adminuser</strong> / password: <strong>admin123</strong><br>
                    User — username: <strong>johnsmith</strong> / password: <strong>user123</strong>
                </div>

                <button type="submit" class="btn btn-primary btn-full">Sign In</button>
            </form>

            <div class="auth-footer">
                New to PageTurner? <a href="register.jsp">Create an account</a>
            </div>
        </div>
    </div>
</div>
<script src="js/script.js"></script>
</body>
</html>
