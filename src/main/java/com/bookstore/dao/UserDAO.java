package com.bookstore.dao;

import com.bookstore.model.User;
import com.bookstore.util.DBConnection;

import java.sql.*;

public class UserDAO {

    public User getUserByUsernameAndPassword(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapUser(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean usernameExists(String username) {
        String sql = "SELECT id FROM users WHERE username = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean emailExists(String email) {
        String sql = "SELECT id FROM users WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (username, password, email, full_name, phone, role) VALUES (?, ?, ?, ?, ?, 'user')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getFullName());
            ps.setString(5, user.getPhone());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private User mapUser(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getInt("id"));
        u.setUsername(rs.getString("username"));
        u.setPassword(rs.getString("password"));
        u.setEmail(rs.getString("email"));
        u.setFullName(rs.getString("full_name"));
        u.setPhone(rs.getString("phone"));
        u.setRole(rs.getString("role"));
        return u;
    }
}
