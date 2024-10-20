//
//  BookTableViewCell.swift
//  MedBook-Harsh
//
//  Created by Harshvardhan Sharma on 19/10/24.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let authorLabel = UILabel()
    let ratingsLabel = UILabel()
    let coverImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(coverImageView)
        addSubview(titleLabel)
        addSubview(authorLabel)
        addSubview(ratingsLabel)
        
        NSLayoutConstraint.activate([
            //imageView in the left
            coverImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            coverImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            coverImageView.widthAnchor.constraint(equalToConstant: 50),
            coverImageView.heightAnchor.constraint(equalToConstant: 75),
            
            //title right of image
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 8),
            
            //author name below title
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            authorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            //Ratings right of author name
            ratingsLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 4),
            ratingsLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
    }
    
    func configure(with book: Book) {
        titleLabel.text = book.title
        authorLabel.text = book.author
        ratingsLabel.text = "Rating: \(book.ratingsAverage) | (\(book.ratingsCount) reviews)"
        
        if let coverID = book.coverID {
            let coverURL = "https://covers.openlibrary.org/b/id/\(coverID)-M.jpg"
            if let url = URL(string: coverURL) {
                let data = try? Data(contentsOf: url)
                coverImageView.image = UIImage(data: data!)
            }
        } else {
            coverImageView.image = UIImage(systemName: "book")
        }
    }
}
