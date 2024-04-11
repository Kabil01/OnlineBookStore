package com.uniquedeveloper.registration;

public class Book {
    private int id;
    private String bookName;
    private String author;
    private String imageLink;
    private String genre;
    private double price;
    private String bookFile;
    
    public String getBookFile() {
    	return this.bookFile;
    }
    
    public void setBookFile(String book) {
    	this.bookFile=book;
    }
    
    // Getter and Setter for 'id'
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Getter and Setter for 'bookName'
    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    // Getter and Setter for 'author'
    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    // Getter and Setter for 'imageLink'
    public String getImageLink() {
        return imageLink;
    }

    public void setImageLink(String imageLink) {
        this.imageLink = imageLink;
    }

    // Getter and Setter for 'genre'
    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    // Getter and Setter for 'price'
    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}
