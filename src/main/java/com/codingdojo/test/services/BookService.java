package com.codingdojo.test.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingdojo.test.models.Book;
import com.codingdojo.test.repositories.BookRepository;


@Service
public class BookService {
	
	@Autowired
	private BookRepository bookRepo;
	
	// All Items
	public List<Book> allBooks(){
		return bookRepo.findAll();
	}
	
	// Find One By ID
	
	public Book getByID(Long id) {
		return this.bookRepo.findById(id).orElse(null);
	}
	
	// Create Or Update
	public Book createOrUpdate(Book book) {
		return bookRepo.save(book);
	}
	
	// Delete
	public void deleteBook(Long id) {
		bookRepo.deleteById(id);
	}

}
