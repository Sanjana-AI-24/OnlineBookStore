<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("user") != null) {
        response.sendRedirect("books.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register — PageTurner Bookstore</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="auth-wrapper">
    <div class="auth-box" style="max-width:520px;">
        <div class="auth-header">
            <div class="logo">📚 PageTurner</div>
            <p>Create your account and start reading</p>
        </div>
        <div class="auth-body">
            <h2>Create Account</h2>

            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-error"><%= request.getAttribute("errorMessage") %></div>
            <% } %>

            <form action="RegisterServlet" method="post" onsubmit="return validateRegisterForm()">

                <div class="form-group">
                    <label for="fullName">Full Name *</label>
                    <input type="text" id="fullName" name="fullName" placeholder="Your full name"
                           value="<%= request.getAttribute("fullName") != null ? request.getAttribute("fullName") : "" %>">
                    <div class="field-error" id="fullNameError"></div>
                </div>

                <div class="form-group">
                    <label for="username">Username *</label>
                    <input type="text" id="username" name="username" placeholder="At least 8 characters"
                           value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>">
                    <div class="form-hint">Minimum 8 characters, no spaces allowed</div>
                    <div class="field-error" id="usernameError"></div>
                </div>

                <div class="form-group">
                    <label for="email">Email Address *</label>
                    <input type="email" id="email" name="email" placeholder="you@example.com"
                           value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>">
                    <div class="form-hint">Must be a valid email with @ symbol</div>
                    <div class="field-error" id="emailError"></div>
                </div>

                <div class="form-group">
                    <label for="phone">Phone Number *</label>
                    <input type="tel" id="phone" name="phone" placeholder="10-digit number"
                           value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>">
                    <div class="form-hint">Exactly 10 digits, numbers only</div>
                    <div class="field-error" id="phoneError"></div>
                </div>

                <div class="form-group">
                    <label for="password">Password *</label>
                    <input type="password" id="password" name="password" placeholder="Minimum 6 characters">
                    <div class="form-hint">At least 6 characters</div>
                    <div class="field-error" id="passwordError"></div>
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Confirm Password *</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Re-enter password">
                    <div class="field-error" id="confirmError"></div>
                </div>

                <button type="submit" class="btn btn-primary btn-full">Create Account</button>
            </form>

            <div class="auth-footer">
                Already have an account? <a href="login.jsp">Sign in</a>
            </div>
        </div>
    </div>
</div>
<script src="js/script.js"></script>
</body>
</html>
