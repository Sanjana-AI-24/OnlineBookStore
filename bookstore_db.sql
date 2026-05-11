-- =========================================
-- PageTurner Bookstore — Database Setup
-- Run this file in MySQL before deploying
-- =========================================

-- 1. Create Database
CREATE DATABASE IF NOT EXISTS bookstore_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE bookstore_db;

-- 2. Users Table
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS books;

CREATE TABLE users (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    username    VARCHAR(50)  NOT NULL UNIQUE,
    password    VARCHAR(100) NOT NULL,
    email       VARCHAR(100) NOT NULL UNIQUE,
    full_name   VARCHAR(100) NOT NULL,
    phone       VARCHAR(15),
    role        ENUM('user','admin') DEFAULT 'user',
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Books Table
CREATE TABLE books (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    title       VARCHAR(200) NOT NULL,
    author      VARCHAR(100) NOT NULL,
    price       DECIMAL(10,2) NOT NULL,
    genre       VARCHAR(50),
    description TEXT,
    stock       INT DEFAULT 0,
    cover_image VARCHAR(20) DEFAULT '📗',
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Orders Table
CREATE TABLE orders (
    id           INT AUTO_INCREMENT PRIMARY KEY,
    user_id      INT NOT NULL,
    address      TEXT NOT NULL,
    phone        VARCHAR(15) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status       VARCHAR(50) DEFAULT 'Placed',
    order_date   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 5. Order Items Table
CREATE TABLE order_items (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    order_id    INT NOT NULL,
    book_id     INT NOT NULL,
    quantity    INT NOT NULL,
    unit_price  DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (book_id)  REFERENCES books(id)
);

-- =========================================
-- SAMPLE DATA
-- =========================================

-- Sample Users
-- Admin: username=adminuser, password=admin123
-- User:  username=johnsmith, password=user123
INSERT INTO users (username, password, email, full_name, phone, role) VALUES
('adminuser', 'admin123', 'admin@pageturner.com', 'Admin User',    '9000000001', 'admin'),
('johnsmith',  'user123',  'john@example.com',    'John Smith',    '9876543210', 'user'),
('priyasharma','user456',  'priya@example.com',   'Priya Sharma',  '9123456789', 'user'),
('arunkumar',  'pass1234', 'arun@example.com',    'Arun Kumar',    '9988776655', 'user');

-- Sample Books (10 popular books)
INSERT INTO books (title, author, price, genre, description, stock, cover_image) VALUES
('The Alchemist',
 'Paulo Coelho',
 299.00,
 'Fiction',
 'A magical story of Santiago, a young shepherd who travels from Spain to the Egyptian desert in search of treasure and his Personal Legend.',
 50, '📕'),

('Atomic Habits',
 'James Clear',
 399.00,
 'Self-Help',
 'A proven framework for improving every day. James Clear reveals practical strategies to form good habits and break bad ones.',
 35, '📘'),

('The Great Gatsby',
 'F. Scott Fitzgerald',
 249.00,
 'Fiction',
 'Set in the Jazz Age, this classic novel explores themes of decadence, idealism, resistance to change, and social upheaval.',
 40, '📗'),

('Sapiens: A Brief History of Humankind',
 'Yuval Noah Harari',
 499.00,
 'History',
 'An exploration of how Homo sapiens came to dominate planet Earth through cognitive, agricultural, and scientific revolutions.',
 30, '📙'),

('To Kill a Mockingbird',
 'Harper Lee',
 279.00,
 'Fiction',
 'A gripping, heart-wrenching tale of coming-of-age in the American South, exploring racial injustice and moral growth.',
 45, '📕'),

('Harry Potter and the Philosopher''s Stone',
 'J.K. Rowling',
 349.00,
 'Fantasy',
 'The magical beginning of Harry''s journey to Hogwarts where he discovers he''s a wizard and faces the dark wizard Voldemort.',
 60, '📓'),

('The Art of War',
 'Sun Tzu',
 199.00,
 'Non-Fiction',
 'An ancient Chinese military treatise dating from 5th century BC, still considered the definitive work on military strategy and tactics.',
 25, '📒'),

('Rich Dad Poor Dad',
 'Robert T. Kiyosaki',
 349.00,
 'Self-Help',
 'What the rich teach their kids about money that the poor and middle class do not. A personal finance classic.',
 40, '📘'),

('1984',
 'George Orwell',
 259.00,
 'Science Fiction',
 'A dystopian novel set in a totalitarian society where Big Brother watches everything. A chilling portrayal of state surveillance.',
 35, '📗'),

('The Hitchhiker''s Guide to the Galaxy',
 'Douglas Adams',
 289.00,
 'Science Fiction',
 'A wildly imaginative comic science fiction series following Arthur Dent after Earth is demolished to make way for a hyperspace bypass.',
 30, '🌌');

-- Verify
SELECT 'Setup Complete!' AS Status;
SELECT COUNT(*) AS TotalUsers  FROM users;
SELECT COUNT(*) AS TotalBooks  FROM books;
