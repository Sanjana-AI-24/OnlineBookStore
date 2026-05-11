package com.bookstore.servlet;

import com.bookstore.dao.OrderDAO;
import com.bookstore.model.CartItem;
import com.bookstore.model.Order;
import com.bookstore.model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        String address = req.getParameter("address");
        String phone   = req.getParameter("phone");

        // Validate
        if (address == null || address.trim().isEmpty()) {
            req.setAttribute("errorMessage", "Address is required.");
            RequestDispatcher rd = req.getRequestDispatcher("checkout.jsp");
            rd.forward(req, res);
            return;
        }
        if (phone == null || !phone.trim().matches("\\d{10}")) {
            req.setAttribute("errorMessage", "Phone number must be exactly 10 digits.");
            RequestDispatcher rd = req.getRequestDispatcher("checkout.jsp");
            rd.forward(req, res);
            return;
        }

        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            res.sendRedirect("books.jsp");
            return;
        }

        double total = cart.values().stream().mapToDouble(CartItem::getSubtotal).sum();

        Order order = new Order();
        order.setUserId(user.getId());
        order.setAddress(address.trim());
        order.setPhone(phone.trim());
        order.setTotalAmount(total);
        order.setItems(new ArrayList<>(cart.values()));

        OrderDAO orderDAO = new OrderDAO();
        int orderId = orderDAO.placeOrder(order);

        if (orderId != -1) {
            session.removeAttribute("cart");
            session.setAttribute("lastOrderId", orderId);
            session.setAttribute("lastOrderTotal", total);
            session.setAttribute("lastOrderAddress", address.trim());
            session.setAttribute("lastOrderPhone", phone.trim());
            res.sendRedirect("orderSuccess.jsp");
        } else {
            req.setAttribute("errorMessage", "Failed to place order. Please try again.");
            RequestDispatcher rd = req.getRequestDispatcher("checkout.jsp");
            rd.forward(req, res);
        }
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        res.sendRedirect("checkout.jsp");
    }
}
