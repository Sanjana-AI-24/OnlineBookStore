package com.bookstore.servlet;

import com.bookstore.dao.UserDAO;
import com.bookstore.model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String fullName = req.getParameter("fullName").trim();
        String username = req.getParameter("username").trim();
        String email    = req.getParameter("email").trim();
        String phone    = req.getParameter("phone").trim();
        String password = req.getParameter("password").trim();
        String confirm  = req.getParameter("confirmPassword").trim();

        // Server-side validation
        StringBuilder error = new StringBuilder();

        if (fullName.isEmpty() || username.isEmpty() || email.isEmpty() || password.isEmpty()) {
            error.append("All fields are required. ");
        }
        if (username.length() < 8) {
            error.append("Username must be at least 8 characters. ");
        }
        if (!email.contains("@") || !email.contains(".")) {
            error.append("Please enter a valid email address. ");
        }
        if (password.length() < 6) {
            error.append("Password must be at least 6 characters. ");
        }
        if (!password.equals(confirm)) {
            error.append("Passwords do not match. ");
        }
        if (!phone.matches("\\d{10}")) {
            error.append("Phone number must be exactly 10 digits. ");
        }

        if (error.length() > 0) {
            req.setAttribute("errorMessage", error.toString().trim());
            req.setAttribute("fullName", fullName);
            req.setAttribute("username", username);
            req.setAttribute("email", email);
            req.setAttribute("phone", phone);
            RequestDispatcher rd = req.getRequestDispatcher("register.jsp");
            rd.forward(req, res);
            return;
        }

        UserDAO dao = new UserDAO();
        if (dao.usernameExists(username)) {
            req.setAttribute("errorMessage", "Username already taken. Please choose another.");
            RequestDispatcher rd = req.getRequestDispatcher("register.jsp");
            rd.forward(req, res);
            return;
        }
        if (dao.emailExists(email)) {
            req.setAttribute("errorMessage", "Email is already registered. Please login.");
            RequestDispatcher rd = req.getRequestDispatcher("register.jsp");
            rd.forward(req, res);
            return;
        }

        User user = new User();
        user.setFullName(fullName);
        user.setUsername(username);
        user.setEmail(email);
        user.setPhone(phone);
        user.setPassword(password);

        boolean success = dao.registerUser(user);
        if (success) {
            req.setAttribute("successMessage", "Registration successful! You can now login.");
            RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
            rd.forward(req, res);
        } else {
            req.setAttribute("errorMessage", "Registration failed. Please try again.");
            RequestDispatcher rd = req.getRequestDispatcher("register.jsp");
            rd.forward(req, res);
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.sendRedirect("register.jsp");
    }
}
