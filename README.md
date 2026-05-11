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

Use this corrected and properly separated version for the **Project Structure** section in your README file.

## 📂 Project Structure

```text
OnlineBookStore/
│
├── src/
│   └── main/
│       ├── java/
│       │   └── com/bookstore/
│       │       ├── dao/             
│       │       │   ├── BookDAO.java
│       │       │   ├── UserDAO.java
│       │       │   └── OrderDAO.java
│       │       │
│       │       ├── model/           
│       │       │   ├── Book.java
│       │       │   ├── User.java
│       │       │   ├── Order.java
│       │       │   └── CartItem.java
│       │       │
│       │       ├── servlet/         
│       │       │   ├── LoginServlet.java
│       │       │   ├── RegisterServlet.java
│       │       │   ├── CartServlet.java
│       │       │   ├── OrderServlet.java
│       │       │   └── AdminServlet.java
│       │       │
│       │       └── util/            
│       │           └── DBConnection.java
│       │
│       └── webapp/
│           ├── css/
│           │   └── style.css
│           │
│           ├── js/
│           │   └── script.js
│           │
│           ├── WEB-INF/
│           │   └── web.xml
│           │
│           ├── index.jsp
│           ├── login.jsp
│           ├── register.jsp
│           ├── books.jsp
│           ├── cart.jsp
│           └── admin.jsp
│
├── bookstore_db.sql
├── pom.xml
└── README.md
```

---

## 🔧 Installation & Setup

Follow these steps to run the project on your local machine.

### 1. Prerequisites

- JDK 8 or higher
- Apache Tomcat 9.0+
- MySQL Server
- IDE (Eclipse / IntelliJ IDEA / VS Code)

---

### 2. Database Setup

Create the database:

```sql
CREATE DATABASE bookstore_db;
```

Import the SQL file:

```bash
mysql -u root -p bookstore_db < bookstore_db.sql
```

---

### 3. Configure Database Connection

Update your MySQL credentials in:

```text
src/main/java/com/bookstore/util/DBConnection.java
```

```java
private static final String URL = "jdbc:mysql://localhost:3306/bookstore_db";
private static final String USER = "YOUR_MYSQL_USERNAME";
private static final String PASS = "YOUR_MYSQL_PASSWORD";
```

---

### 4. Run the Application

1. Import the project into your IDE
2. Add MySQL Connector and Servlet API dependencies
3. Run the project on Apache Tomcat Server

Open in browser:

```text
http://localhost:8080/OnlineBookStore
```
