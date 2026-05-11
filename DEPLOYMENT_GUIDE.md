# PageTurner Online Bookstore
## Complete Deployment Guide — Eclipse + Apache Tomcat

---

## 📋 PREREQUISITES

Before starting, ensure you have the following installed:

| Tool              | Version Recommended  | Download Link                              |
|-------------------|---------------------|--------------------------------------------|
| JDK               | 11 or 17            | https://adoptium.net                       |
| Eclipse IDE       | 2022-12 or newer    | https://www.eclipse.org/downloads          |
| Apache Tomcat     | 9.x or 10.x         | https://tomcat.apache.org/download-90.cgi  |
| MySQL Server      | 8.0+                | https://dev.mysql.com/downloads            |
| MySQL Connector/J | 8.0+                | https://dev.mysql.com/downloads/connector/j|

---

## STEP 1 — Setup the MySQL Database

1. Open MySQL Workbench or MySQL Command Line Client.
2. Log in as root:
   ```
   mysql -u root -p
   ```
3. Run the provided SQL script:
   ```sql
   SOURCE /path/to/OnlineBookstore/bookstore_db.sql;
   ```
   Or copy-paste the contents of `bookstore_db.sql` into Workbench and execute.

4. Verify the setup:
   ```sql
   USE bookstore_db;
   SELECT * FROM users;
   SELECT * FROM books;
   ```

**Database credentials (default):**
- Host: localhost
- Port: 3306
- Database: bookstore_db
- Username: root
- Password: root

> ⚠️ If your MySQL password is different, update it in:
> `src/main/java/com/bookstore/util/DBConnection.java`
> Change the `PASSWORD` constant to match yours.

---

## STEP 2 — Import the Project into Eclipse

1. Open **Eclipse IDE for Enterprise Java Developers**.
2. Go to **File → Import → General → Existing Projects into Workspace**.
3. Click **Browse** and select the `OnlineBookstore` folder.
4. Make sure the project is checked and click **Finish**.

---

## STEP 3 — Convert to Dynamic Web Project (if needed)

If Eclipse does not recognize it as a web project:

1. Right-click the project → **Properties**.
2. Go to **Project Facets**.
3. Enable **Dynamic Web Module** (version 4.0) and **Java** (11 or 17).
4. Click **Apply and Close**.

---

## STEP 4 — Set Up the Build Path

1. Right-click project → **Build Path → Configure Build Path**.
2. Go to the **Libraries** tab.
3. Click **Add External JARs** and add the following JARs:

   **a) MySQL Connector JAR**
   - Download `mysql-connector-j-8.x.x.jar` from:
     https://dev.mysql.com/downloads/connector/j
   - Add it via: Build Path → Add External JARs

   **b) Servlet API JAR**
   - Locate `servlet-api.jar` inside your Tomcat installation:
     `<TOMCAT_HOME>/lib/servlet-api.jar`
   - Add it via: Build Path → Add External JARs

4. Also add the MySQL connector to `src/main/webapp/WEB-INF/lib/` folder:
   - Create the `lib` folder if it doesn't exist inside WEB-INF
   - Copy `mysql-connector-j-8.x.x.jar` into it

---

## STEP 5 — Configure Apache Tomcat in Eclipse

1. Open the **Servers** view: **Window → Show View → Servers**.
2. Right-click in the Servers panel → **New → Server**.
3. Select **Apache → Tomcat v9.0 Server** and click **Next**.
4. Click **Browse** and navigate to your Tomcat installation folder.
5. Click **Finish**.

---

## STEP 6 — Add Project to Tomcat

1. In the Servers panel, double-click your Tomcat server to open configuration.
2. Right-click the Tomcat server → **Add and Remove**.
3. Select **OnlineBookstore** from the left panel.
4. Click **Add →** then **Finish**.

---

## STEP 7 — Configure Project Structure

Ensure the following folder structure exists in Eclipse:

```
OnlineBookstore/
├── src/
│   └── main/
│       └── java/
│           └── com/bookstore/
│               ├── model/       (User.java, Book.java, CartItem.java, Order.java)
│               ├── dao/         (UserDAO.java, BookDAO.java, OrderDAO.java)
│               ├── servlet/     (LoginServlet.java, RegisterServlet.java, etc.)
│               └── util/        (DBConnection.java)
├── WebContent/  (or src/main/webapp/)
│   ├── WEB-INF/
│   │   ├── web.xml
│   │   └── lib/
│   │       └── mysql-connector-j-8.x.x.jar
│   ├── css/
│   │   └── style.css
│   ├── js/
│   │   └── script.js
│   ├── index.jsp
│   ├── login.jsp
│   ├── register.jsp
│   ├── books.jsp
│   ├── cart.jsp
│   ├── checkout.jsp
│   ├── orderSuccess.jsp
│   └── admin.jsp
└── bookstore_db.sql
```

> **Note:** Eclipse may use `WebContent` instead of `src/main/webapp`. 
> If so, move all JSP, CSS, and JS files to the `WebContent` folder.

---

## STEP 8 — Build the Project

1. Right-click the project → **Build Project** (or press Ctrl+B).
2. Fix any compilation errors shown in the Problems tab.
3. Common fixes:
   - Missing servlet-api: Add from Tomcat lib as shown in Step 4
   - Missing MySQL driver: Add connector JAR as shown in Step 4

---

## STEP 9 — Deploy and Run

1. Right-click the project → **Run As → Run on Server**.
2. Select your configured Tomcat server.
3. Click **Finish**.
4. Eclipse will start Tomcat and open a browser.
5. Navigate to: `http://localhost:8080/OnlineBookstore/`

---

## 🔑 SAMPLE LOGIN CREDENTIALS

| Role  | Username    | Password  |
|-------|-------------|-----------|
| Admin | adminuser   | admin123  |
| User  | johnsmith   | user123   |
| User  | priyasharma | user456   |
| User  | arunkumar   | pass1234  |

---

## 📱 APPLICATION FLOW

```
Home → Login / Register
         ↓
     Books Page (Browse all books)
         ↓
    Add to Cart (→ Cart page)
         ↓
    Cart Page (view, update quantity, remove)
         ↓ Place Order →
    Checkout (enter address + phone)
         ↓ Confirm Order →
    Order Success Page 🎉
```

**Admin Flow:**
```
Login as adminuser → Admin Dashboard
  - View stats (books, orders, revenue)
  - Add new books
  - Delete books
  - View all customer orders
```

---

## ✅ VALIDATION RULES

| Field             | Rule                                          |
|-------------------|-----------------------------------------------|
| Username          | Minimum 8 characters                          |
| Email             | Must contain @ and a valid domain (.com etc.) |
| Password          | Minimum 6 characters                          |
| Confirm Password  | Must match password                           |
| Phone Number      | Exactly 10 digits (numbers only)              |
| Full Name         | Cannot be empty                               |
| Delivery Address  | Minimum 10 characters                         |

Validation is enforced both client-side (JavaScript) and server-side (Java Servlet).

---

## 🛠️ TROUBLESHOOTING

**Problem: ClassNotFoundException for MySQL driver**
→ Solution: Ensure mysql-connector JAR is in WEB-INF/lib/ and on the build path.

**Problem: 404 error when accessing pages**
→ Solution: Check that Tomcat is running and the project is added to the server.

**Problem: SQL connection refused**
→ Solution: 
  1. Make sure MySQL server is running
  2. Check credentials in DBConnection.java
  3. Ensure database `bookstore_db` exists (run the SQL script)

**Problem: JSP pages not found**
→ Solution: Ensure JSP files are in the WebContent (or webapp) root, not inside WEB-INF.

**Problem: Compilation errors in Eclipse**
→ Solution: 
  1. Right-click project → Maven → Update Project (if Maven)
  2. Or manually add servlet-api.jar from Tomcat/lib to build path

**Problem: Port 8080 already in use**
→ Solution: In Eclipse Servers tab, double-click Tomcat → Change HTTP port to 8082.

---

## 🏗️ ARCHITECTURE OVERVIEW

```
Browser (JSP + HTML + CSS + JS)
        ↕ HTTP
Tomcat Server (Servlets)
        ↕ JDBC
MySQL Database
```

**Layers:**
- **Presentation Layer:** JSP pages + CSS + JavaScript
- **Controller Layer:** Java Servlets (handle HTTP requests)
- **Data Access Layer:** DAO classes (database operations)
- **Model Layer:** Plain Java objects (User, Book, CartItem, Order)
- **Utility Layer:** DBConnection.java (JDBC connection manager)

---

*PageTurner Bookstore — Built with Java EE, Servlets, JSP, JDBC, and MySQL*
