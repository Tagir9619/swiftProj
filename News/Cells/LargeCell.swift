//
//  LargeCell.swift
//  News
//
//  Created by Тагир Булыков on 04.02.2024.
//

import UIKit

class LargeCell:UITableViewCell {
    
    private let authorLabel = UILabel()
    private let titleLabel = UILabel()
    private let pictureImageView = UIImageView(image: UIImage(named: "fortnightly_healthcare"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeLayout()
        makeStyle()
    }
    
    func configure(article: News) {
        titleLabel.text = article.title
        if article.author != nil {
            authorLabel.text = article.author
        } else {
            authorLabel.text = "Unknown author"
        }
        
        if let imageURL = URL(string: article.urlToImage ?? "") {
                pictureImageView.kf.setImage(with: imageURL)
            } else {
                pictureImageView.image = UIImage(named: "заглушка")
            }
    }
    
    private func makeLayout() {
        contentView.addSubview(authorLabel)
        contentView.addSubview(titleLabel)
        layoutPictureImageView()
        
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: pictureImageView.bottomAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
    
    private func layoutPictureImageView() {
        contentView.addSubview(pictureImageView)
        pictureImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pictureImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            pictureImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            pictureImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            pictureImageView.widthAnchor.constraint(equalTo: pictureImageView.widthAnchor),
            pictureImageView.heightAnchor.constraint(equalTo: pictureImageView.widthAnchor, multiplier: 0.7)
        ])
    }
    
    private func makeStyle() {
        authorLabel.font = .librefranklinFont(size: 16, style: .regular)
        titleLabel.font = .librefranklinFont(size: 20, style: .regular)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
