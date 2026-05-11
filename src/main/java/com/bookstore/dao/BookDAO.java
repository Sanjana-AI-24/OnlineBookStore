package com.bookstore.dao;

import com.bookstore.model.Book;
import com.bookstore.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {

    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books ORDER BY title";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                books.add(mapBook(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    public Book getBookById(int id) {
        String sql = "SELECT * FROM books WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapBook(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addBook(Book book) {
        String sql = "INSERT INTO books (title, author, price, genre, description, stock, cover_image) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthor());
            ps.setDouble(3, book.getPrice());
            ps.setString(4, book.getGenre());
            ps.setString(5, book.getDescription());
            ps.setInt(6, book.getStock());
            ps.setString(7, book.getCoverImage());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateBook(Book book) {
        String sql = "UPDATE books SET title=?, author=?, price=?, genre=?, description=?, stock=?, cover_image=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthor());
            ps.setDouble(3, book.getPrice());
            ps.setString(4, book.getGenre());
            ps.setString(5, book.getDescription());
            ps.setInt(6, book.getStock());
            ps.setString(7, book.getCoverImage());
            ps.setInt(8, book.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteBook(int id) {
        String sql = "DELETE FROM books WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Book mapBook(ResultSet rs) throws SQLException {
        Book b = new Book();
        b.setId(rs.getInt("id"));
        b.setTitle(rs.getString("title"));
        b.setAuthor(rs.getString("author"));
        b.setPrice(rs.getDouble("price"));
        b.setGenre(rs.getString("genre"));
        b.setDescription(rs.getString("description"));
        b.setStock(rs.getInt("stock"));
        b.setCoverImage(rs.getString("cover_image"));
        return b;
    }
}
