package com.bookstore.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String DRIVER   = "com.mysql.cj.jdbc.Driver";
    private static final String URL      = "jdbc:mysql://localhost:3306/bookstore_db?useSSL=false&serverTimezone=UTC";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root";

    private static Connection connection = null;

    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                Class.forName(DRIVER);
                connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            } catch (ClassNotFoundException e) {
                throw new SQLException("MySQL JDBC Driver not found: " + e.getMessage());
            }
        }
        return connection;
    }

    public static void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
                connection = null;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
