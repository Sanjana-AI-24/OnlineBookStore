package com.bookstore.servlet;

import com.bookstore.dao.UserDAO;
import com.bookstore.model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String username = req.getParameter("username").trim();
        String password = req.getParameter("password").trim();

        UserDAO dao = new UserDAO();
        User user = dao.getUserByUsernameAndPassword(username, password);

        if (user != null) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());

            if ("admin".equals(user.getRole())) {
                res.sendRedirect("admin.jsp");
            } else {
                res.sendRedirect("books.jsp");
            }
        } else {
            req.setAttribute("errorMessage", "Invalid username or password. Please try again.");
            RequestDispatcher rd = req.getRequestDispatcher("login.jsp");
            rd.forward(req, res);
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.sendRedirect("login.jsp");
    }
}
