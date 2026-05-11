package com.bookstore.dao;

import com.bookstore.model.Order;
import com.bookstore.model.CartItem;
import com.bookstore.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public int placeOrder(Order order) {
        String orderSql  = "INSERT INTO orders (user_id, address, phone, total_amount, status) VALUES (?, ?, ?, ?, 'Placed')";
        String itemSql   = "INSERT INTO order_items (order_id, book_id, quantity, unit_price) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            int orderId = -1;
            try (PreparedStatement ps = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, order.getUserId());
                ps.setString(2, order.getAddress());
                ps.setString(3, order.getPhone());
                ps.setDouble(4, order.getTotalAmount());
                ps.executeUpdate();
                ResultSet keys = ps.getGeneratedKeys();
                if (keys.next()) orderId = keys.getInt(1);
            }

            if (orderId != -1 && order.getItems() != null) {
                try (PreparedStatement ps2 = conn.prepareStatement(itemSql)) {
                    for (CartItem item : order.getItems()) {
                        ps2.setInt(1, orderId);
                        ps2.setInt(2, item.getBook().getId());
                        ps2.setInt(3, item.getQuantity());
                        ps2.setDouble(4, item.getBook().getPrice());
                        ps2.addBatch();
                    }
                    ps2.executeBatch();
                }
            }

            conn.commit();
            return orderId;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, u.username FROM orders o JOIN users u ON o.user_id = u.id ORDER BY o.order_date DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Order ord = new Order();
                ord.setId(rs.getInt("id"));
                ord.setUserId(rs.getInt("user_id"));
                ord.setAddress(rs.getString("address"));
                ord.setPhone(rs.getString("phone"));
                ord.setTotalAmount(rs.getDouble("total_amount"));
                ord.setOrderDate(rs.getTimestamp("order_date"));
                ord.setStatus(rs.getString("status"));
                orders.add(ord);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
}
