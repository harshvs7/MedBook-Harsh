//
//  HomeViewModel.swift
//  MedBook-Harsh
//
//  Created by Harshvardhan Sharma on 20/10/24.
//

import Foundation

class HomeViewModel {
    var books: [Book] = []
    var isLoading = false
    var totalResults = 0
    
    func fetchBooks(query: String, offset: Int, completion: @escaping (Bool, String?) -> Void) {
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
                self.totalResults = bookResponse.docs.count
                
                let newBooks = bookResponse.docs.compactMap { bookDoc -> Book? in
                    return Book(
                        title: bookDoc.title,
                        author: bookDoc.author_name?.first ?? "Unknown",
                        coverID: bookDoc.cover_i,
                        ratingsAverage: bookDoc.ratings_average ?? 0.0,
                        ratingsCount: bookDoc.ratings_count ?? 0
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
        }.resume()
    }
}
