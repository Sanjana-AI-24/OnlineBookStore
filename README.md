# 📚 Online Book Store - Full Stack Java EE Application

A feature-rich E-commerce platform for purchasing books, built using a **Three-Tier Architecture**. This project demonstrates a clean separation of concerns, secure user authentication, and persistent data management using the **DAO Pattern** and **Hibernate/JDBC**.

---

## 🏗️ Architecture Overview
The project is divided into three distinct layers to ensure scalability and maintainability:
1.  **Presentation Layer:** Dynamic UI built with **JSP**, **HTML5**, and **CSS3**.
2.  **Business Logic Layer:** Managed by **Java Servlets** to handle request processing, session management, and routing.
3.  **Data Access Layer:** Utilizes the **DAO (Data Access Object) Pattern** with **MySQL** to optimize database interactions.

---

## 🚀 Key Features

### 👤 User Module
- **Secure Authentication:** Registration and Login system with session tracking (`LoginServlet`, `RegisterServlet`).
- **Dynamic Catalog:** Browse a real-time list of books fetched dynamically from the database.
- **Shopping Cart:** Add/Remove books, update quantities, and view total costs in real-time.
- **Checkout Flow:** Integrated order processing and order confirmation tracking.

### 🛡️ Admin Module
- **Inventory Management:** Specialized dashboard for administrators to view all orders and manage book listings.
- **Data Integrity:** Server-side validation to ensure clean data entry and secure transactions.

### 💾 Technical Highlights
- **DAO Pattern:** Decouples business logic from database code for better modularity.
- **State Management:** Uses `HTTPSession` to maintain cart data across multiple pages.
- **Relational Mapping:** Clean database schema including tables for `Users`, `Books`, and `Orders`.

---

## 🛠️ Technology Stack
- **Languages:** Java, SQL, HTML5, CSS3, JavaScript
- **Backend:** Java Servlets, Java EE (J2EE)
- **Database/ORM:** MySQL, Hibernate ORM / JDBC
- **Frontend:** JSP (JavaServer Pages)
- **Server:** Apache Tomcat 9.0+
- **Version Control:** Git & GitHub

---

## 📂 Project Structure
```text
OnlineBookStore/
├── src/main/java/
│   ├── com/bookstore/dao/        # Data Access Objects (BookDAO, UserDAO, OrderDAO)
│   ├── com/bookstore/model/      # POJOs / Entities (Book, User, Order, CartItem)
│   ├── com/bookstore/servlet/    # Controllers (Cart, Login, Order, Admin Servlets)
│   └── com/bookstore/util/       # Database Connection Utilities
├── src/main/webapp/
│   ├── css/ & js/                # Static UI Assets (style.css, script.js)
│   ├── WEB-INF/                  # web.xml Deployment Descriptor
│   └── *.jsp                     # Dynamic View Pages (index, books, cart, etc.)
├── bookstore_db.sql              # Database Schema & Sample Data
└── README.md                     # Project Documentation

---

##**🔧 Installation & Setup**
Clone the Project:

Bash
git clone [https://github.com/Sanjana-AI-24/OnlineBookStore.git](https://github.com/Sanjana-AI-24/OnlineBookStore.git)
Database Configuration:

Import bookstore_db.sql into your MySQL Workbench or Shell.

Update your MySQL credentials in src/main/java/com/bookstore/util/DBConnection.java or hibernate.cfg.xml.

Deployment:

Import the project into your IDE (Eclipse/IntelliJ).

Configure Apache Tomcat as the deployment server.

Run the project on the server and access http://localhost:8080/OnlineBookStore.

👩‍💻 Author
G. Sanjana Artificial Intelligence & Data Science Student
