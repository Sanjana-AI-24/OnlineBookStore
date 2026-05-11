package com.bookstore.model;

import java.util.Date;
import java.util.List;

public class Order {
    private int id;
    private int userId;
    private String address;
    private String phone;
    private double totalAmount;
    private Date orderDate;
    private String status;
    private List<CartItem> items;

    public Order() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public Date getOrderDate() { return orderDate; }
    public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public List<CartItem> getItems() { return items; }
    public void setItems(List<CartItem> items) { this.items = items; }
}
