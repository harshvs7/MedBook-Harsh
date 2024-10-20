//
//  HomeViewModel.swift
//  MedBook-Harsh
//
//  Created by Harshvardhan Sharma on 20/10/24.
//

import Foundation
import UIKit

class HomeViewModel {
    
    //MARK: remove allBooks for api call
    var allBooks: [Book] = [
        Book(title: "The Great Gatsby", author: "F. Scott Fitzgerald", coverID: 1, ratingsAverage: 4.5, ratingsCount: 52),
        Book(title: "To Kill a Mockingbird", author: "Harper Lee", coverID: 2, ratingsAverage: 4.7, ratingsCount: 65),
        Book(title: "1984", author: "George Orwell", coverID: 3, ratingsAverage: 4.6, ratingsCount: 78),
        Book(title: "The Catcher in the Rye", author: "J.D. Salinger", coverID: 4, ratingsAverage: 4.2, ratingsCount: 41),
        Book(title: "Pride and Prejudice", author: "Jane Austen", coverID: 5, ratingsAverage: 4.9, ratingsCount: 87),
        Book(title: "The Hobbit", author: "J.R.R. Tolkien", coverID: 6, ratingsAverage: 4.8, ratingsCount: 68),
        Book(title: "Moby Dick", author: "Herman Melville", coverID: 7, ratingsAverage: 4.1, ratingsCount: 56),
        Book(title: "War and Peace", author: "Leo Tolstoy", coverID: 8, ratingsAverage: 4.4, ratingsCount: 42),
        Book(title: "Crime and Punishment", author: "Fyodor Dostoevsky", coverID: 9, ratingsAverage: 4.7, ratingsCount: 63),
        Book(title: "The Adventures of Huckleberry Finn", author: "Mark Twain", coverID: 10, ratingsAverage: 4.3, ratingsCount: 59),
        Book(title: "The Odyssey", author: "Homer", coverID: 11, ratingsAverage: 4.6, ratingsCount: 73),
        Book(title: "Wuthering Heights", author: "Emily Brontë", coverID: 12, ratingsAverage: 4.2, ratingsCount: 44),
        Book(title: "Jane Eyre", author: "Charlotte Brontë", coverID: 13, ratingsAverage: 4.5, ratingsCount: 68),
        Book(title: "Brave New World", author: "Aldous Huxley", coverID: 14, ratingsAverage: 4.1, ratingsCount: 52),
        Book(title: "The Lord of the Rings", author: "J.R.R. Tolkien", coverID: 15, ratingsAverage: 4.9, ratingsCount: 92),
        Book(title: "Anna Karenina", author: "Leo Tolstoy", coverID: 16, ratingsAverage: 4.3, ratingsCount: 48),
        Book(title: "The Picture of Dorian Gray", author: "Oscar Wilde", coverID: 17, ratingsAverage: 4.4, ratingsCount: 55),
        Book(title: "Dracula", author: "Bram Stoker", coverID: 18, ratingsAverage: 4.2, ratingsCount: 45),
        Book(title: "Frankenstein", author: "Mary Shelley", coverID: 19, ratingsAverage: 4.0, ratingsCount: 37),
        Book(title: "The Divine Comedy", author: "Dante Alighieri", coverID: 20, ratingsAverage: 4.8, ratingsCount: 62),
        Book(title: "Les Misérables", author: "Victor Hugo", coverID: 21, ratingsAverage: 4.5, ratingsCount: 58),
        Book(title: "The Count of Monte Cristo", author: "Alexandre Dumas", coverID: 22, ratingsAverage: 4.9, ratingsCount: 81),
        Book(title: "The Brothers Karamazov", author: "Fyodor Dostoevsky", coverID: 23, ratingsAverage: 4.8, ratingsCount: 69),
        Book(title: "Don Quixote", author: "Miguel de Cervantes", coverID: 24, ratingsAverage: 4.2, ratingsCount: 49),
        Book(title: "Madame Bovary", author: "Gustave Flaubert", coverID: 25, ratingsAverage: 4.1, ratingsCount: 36),
        Book(title: "Fahrenheit 451", author: "Ray Bradbury", coverID: 26, ratingsAverage: 4.3, ratingsCount: 50),
        Book(title: "One Hundred Years of Solitude", author: "Gabriel García Márquez", coverID: 27, ratingsAverage: 4.7, ratingsCount: 64),
        Book(title: "The Metamorphosis", author: "Franz Kafka", coverID: 28, ratingsAverage: 4.0, ratingsCount: 41),
        Book(title: "The Stranger", author: "Albert Camus", coverID: 29, ratingsAverage: 4.5, ratingsCount: 72),
        Book(title: "Slaughterhouse-Five", author: "Kurt Vonnegut", coverID: 30, ratingsAverage: 4.3, ratingsCount: 53),
        Book(title: "A Tale of Two Cities", author: "Charles Dickens", coverID: 31, ratingsAverage: 4.6, ratingsCount: 68),
        Book(title: "Heart of Darkness", author: "Joseph Conrad", coverID: 32, ratingsAverage: 4.1, ratingsCount: 47),
        Book(title: "Lolita", author: "Vladimir Nabokov", coverID: 33, ratingsAverage: 4.2, ratingsCount: 55),
        Book(title: "Catch-22", author: "Joseph Heller", coverID: 34, ratingsAverage: 4.4, ratingsCount: 62),
        Book(title: "Ulysses", author: "James Joyce", coverID: 35, ratingsAverage: 4.3, ratingsCount: 48),
        Book(title: "Beloved", author: "Toni Morrison", coverID: 36, ratingsAverage: 4.6, ratingsCount: 65),
        Book(title: "Invisible Man", author: "Ralph Ellison", coverID: 37, ratingsAverage: 4.5, ratingsCount: 54),
        Book(title: "The Sun Also Rises", author: "Ernest Hemingway", coverID: 38, ratingsAverage: 4.2, ratingsCount: 40),
        Book(title: "The Road", author: "Cormac McCarthy", coverID: 39, ratingsAverage: 4.4, ratingsCount: 57),
        Book(title: "The Old Man and the Sea", author: "Ernest Hemingway", coverID: 40, ratingsAverage: 4.3, ratingsCount: 49)
    ]
    
    var books : [Book] = []

    var isLoading = false
    var totalResults = 0
    
    //MARK: remove this function and its caller for api call
    func filterBooks(byTitle searchText: String) {
        if searchText.isEmpty {
            books = []
        } else {
            books = allBooks.filter { book in
                return book.title.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func fetchBookCoverImage(coverID: Int?, completion: @escaping (UIImage?) -> Void) {
        guard let coverID = coverID else {
            completion(UIImage(systemName: "book"))
            return
        }
        
        let coverURL = "https://covers.openlibrary.org/b/id/\(coverID)-M.jpg"
        guard let url = URL(string: coverURL) else {
            completion(UIImage(systemName: "book"))
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(UIImage(systemName: "book"))
                }
            }
        }
    }
    
    func fetchBooks(query: String, offset: Int, completion: @escaping (Bool, String?) -> Void) {
        completion(true,"successful") //MARK: remove this code for api calls, and uncomment below one.
        
        
        /*
        // Prevent multiple API calls if already loading
        
        guard !isLoading else { return }
        isLoading = true
        
        let urlString = "https://openlibrary.org/search.json?title=\(query)&limit=10&offset=\(offset)"
        guard let url = URL(string: urlString) else {
            completion(false, "Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                self.isLoading = false
                DispatchQueue.main.async {
                    completion(false, "Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                }
                return
            }
            
            do {
                let bookResponse = try JSONDecoder().decode(BookResponse.self, from: data)
                self.totalResults = bookResponse.books.count
                
                let newBooks = bookResponse.books.compactMap { bookDoc -> Book? in
                    return Book(
                        title: bookDoc.title,
                        author: bookDoc.authorName?.first ?? "Unknown",
                        coverID: bookDoc.coverI,
                        ratingsAverage: bookDoc.ratingsAverage ?? 0.0,
                        ratingsCount: bookDoc.ratingsCount ?? 0
                    )
                }
                
                DispatchQueue.main.async {
                    self.books.append(contentsOf: newBooks)
                    self.isLoading = false
                    completion(true, nil)
                }
            } catch {
                print("Error decoding response: \(error)")
                self.isLoading = false
                DispatchQueue.main.async {
                    completion(false, "Error decoding response: \(error.localizedDescription)")
                }
            }
        }.resume() */
    }
}
