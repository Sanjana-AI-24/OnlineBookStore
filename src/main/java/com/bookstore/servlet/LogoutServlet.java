package com.bookstore.servlet;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null) session.invalidate();
        res.sendRedirect("login.jsp");
    }
}
