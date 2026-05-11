package com.bookstore.servlet;

import com.bookstore.dao.BookDAO;
import com.bookstore.dao.OrderDAO;
import com.bookstore.model.Book;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        if (!"admin".equals(session.getAttribute("role"))) {
            res.sendRedirect("login.jsp");
            return;
        }

        String action = req.getParameter("action");
        BookDAO bookDAO = new BookDAO();

        if ("addBook".equals(action)) {
            Book book = new Book();
            book.setTitle(req.getParameter("title"));
            book.setAuthor(req.getParameter("author"));
            book.setPrice(Double.parseDouble(req.getParameter("price")));
            book.setGenre(req.getParameter("genre"));
            book.setDescription(req.getParameter("description"));
            book.setStock(Integer.parseInt(req.getParameter("stock")));
            book.setCoverImage(req.getParameter("coverImage"));
            bookDAO.addBook(book);

        } else if ("deleteBook".equals(action)) {
            int id = Integer.parseInt(req.getParameter("bookId"));
            bookDAO.deleteBook(id);
        }

        res.sendRedirect("admin.jsp");
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        if (!"admin".equals(session.getAttribute("role"))) {
            res.sendRedirect("login.jsp");
            return;
        }
        res.sendRedirect("admin.jsp");
    }
}
