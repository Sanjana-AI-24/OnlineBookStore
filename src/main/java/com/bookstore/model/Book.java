package com.bookstore.model;

public class Book {
    private int id;
    private String title;
    private String author;
    private double price;
    private String genre;
    private String description;
    private int stock;
    private String coverImage;

    public Book() {}

    public Book(int id, String title, String author, double price, String genre, String description, int stock, String coverImage) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.price = price;
        this.genre = genre;
        this.description = description;
        this.stock = stock;
        this.coverImage = coverImage;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getGenre() { return genre; }
    public void setGenre(String genre) { this.genre = genre; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

    public String getCoverImage() { return coverImage; }
    public void setCoverImage(String coverImage) { this.coverImage = coverImage; }
}
