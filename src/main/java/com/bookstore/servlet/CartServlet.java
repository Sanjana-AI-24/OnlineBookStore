package com.bookstore.servlet;

import com.bookstore.dao.BookDAO;
import com.bookstore.model.Book;
import com.bookstore.model.CartItem;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        if (session.getAttribute("user") == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        String action  = req.getParameter("action");
        String bookIdStr = req.getParameter("bookId");

        // Retrieve or create cart (Map<bookId, CartItem>)
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new LinkedHashMap<>();
            session.setAttribute("cart", cart);
        }

        if ("add".equals(action) && bookIdStr != null) {
            int bookId = Integer.parseInt(bookIdStr);
            BookDAO bookDAO = new BookDAO();
            Book book = bookDAO.getBookById(bookId);
            if (book != null) {
                if (cart.containsKey(bookId)) {
                    cart.get(bookId).setQuantity(cart.get(bookId).getQuantity() + 1);
                } else {
                    cart.put(bookId, new CartItem(book, 1));
                }
            }
            res.sendRedirect("cart.jsp");

        } else if ("remove".equals(action) && bookIdStr != null) {
            cart.remove(Integer.parseInt(bookIdStr));
            res.sendRedirect("cart.jsp");

        } else if ("update".equals(action) && bookIdStr != null) {
            int qty = Integer.parseInt(req.getParameter("quantity"));
            int bookId = Integer.parseInt(bookIdStr);
            if (qty <= 0) {
                cart.remove(bookId);
            } else if (cart.containsKey(bookId)) {
                cart.get(bookId).setQuantity(qty);
            }
            res.sendRedirect("cart.jsp");

        } else if ("clear".equals(action)) {
            cart.clear();
            res.sendRedirect("books.jsp");
        } else {
            res.sendRedirect("cart.jsp");
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.sendRedirect("cart.jsp");
    }
}
