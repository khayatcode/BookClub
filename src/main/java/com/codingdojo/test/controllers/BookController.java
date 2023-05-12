package com.codingdojo.test.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.codingdojo.test.models.Book;
import com.codingdojo.test.models.User;
import com.codingdojo.test.services.BookService;
import com.codingdojo.test.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
@RequestMapping("/books")
public class BookController {

	@Autowired
	private BookService bookService;

	@Autowired
	private UserService userService;

	@GetMapping("/home")
	public String home(HttpSession session, Model model) {
		System.out.println(session.getAttribute("userID"));

		// Do this in all routes inside the page
		if (session.getAttribute("userID") == null) {
			return "redirect:/users";
		}

		User thisUser = this.userService.getByID((Long) session.getAttribute("userID"));
		model.addAttribute("user", thisUser);

		model.addAttribute("books", this.bookService.allBooks());
		model.addAttribute("borrowedBooks", thisUser.getBorrowedBooks());

		return "home.jsp";
	}

	@GetMapping("/create")
	public String renderCreate(HttpSession session, @ModelAttribute("book") Book book, Model model) {
		
		if (session.getAttribute("userID") == null) {
			return "redirect:/users";
		}
		
		User thisUser = this.userService.getByID((Long) session.getAttribute("userID"));
		model.addAttribute("user", thisUser);
		
		return "create.jsp";
	}

	@PostMapping("/create/new")
	public String submitCreate( @Valid @ModelAttribute("book") Book book, BindingResult result, Model model, HttpSession session ) {
		
		if(result.hasErrors()) {
			User thisUser = this.userService.getByID((Long) session.getAttribute("userID"));
			model.addAttribute("user", thisUser);
			model.addAttribute("bindingResult", result);
			System.out.println("ERROR");
			return "create.jsp";
		}
		
		bookService.createOrUpdate(book);
		System.out.println("Success");
		return "redirect:/books/home";
	}
	
	@GetMapping("/show/{id}")
	public String viewBook(HttpSession session, @PathVariable("id") Long id, Model model) {
		if (session.getAttribute("userID") == null) {
			return "redirect:/users";
		}
		
		User thisUser = this.userService.getByID((Long) session.getAttribute("userID"));
		model.addAttribute("user", thisUser);
		
		model.addAttribute("book", bookService.getByID(id));
		return "view.jsp";
		
	}
	
	@GetMapping("/edit/{id}")
	public String renderEdit(@PathVariable("id") Long id, @ModelAttribute("book") Book book, Model model, HttpSession session) {
		if (session.getAttribute("userID") == null) {
			return "redirect:/users";
		}
		
		User thisUser = this.userService.getByID((Long) session.getAttribute("userID"));
		model.addAttribute("user", thisUser);
		
		model.addAttribute("book", bookService.getByID(id));
		
		return "edit.jsp";
	}
	
	@PutMapping("update/{id}")
	public String submitEdit(@Valid @ModelAttribute("book") Book book, BindingResult result, Model model, HttpSession session) {
		if(result.hasErrors()) {
			User thisUser = this.userService.getByID((Long) session.getAttribute("userID"));
			model.addAttribute("user", thisUser);
	        model.addAttribute("bindingResult", result);
			return "edit.jsp";
		}
		
		bookService.createOrUpdate(book);
		System.out.println("Success");
		return "redirect:/books/home";
	}
	
	@DeleteMapping("/delete/{id}")
	public String deleteBook(@PathVariable("id") Long id) {
		bookService.deleteBook(id);
		return "redirect:/books/home";
	}

	@GetMapping("/{id}/borrow")
	public String borrowBook(@PathVariable("id") Long id, HttpSession session) {
		Book book = bookService.getByID(id);
		User user = userService.getByID((Long) session.getAttribute("userID"));
		book.setBorrower(user);
		bookService.createOrUpdate(book);
		return "redirect:/books/home";
	}

	@GetMapping("/{id}/unborrow")
	public String unBorrowBook(@PathVariable("id") Long id) {
		Book book = bookService.getByID(id);
		book.setBorrower(null);
		bookService.createOrUpdate(book);
		return "redirect:/books/home";
	}

	

}
