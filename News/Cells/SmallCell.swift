//
//  SmallCell.swift
//  News
//
//  Created by Тагир Булыков on 04.02.2024.
//

import UIKit
import Kingfisher
import CoreData


class SmallCell: UITableViewCell {
    private let authorLabel = UILabel()
    private let titleLabel = UILabel()
    private let pictureImageView = UIImageView()
    
    
    
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
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: pictureImageView.leadingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 9),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: pictureImageView.leadingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
        ])
    }
    
    private func layoutPictureImageView() {
        contentView.addSubview(pictureImageView)
        pictureImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pictureImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            //pictureImageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            pictureImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            pictureImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20),
            pictureImageView.widthAnchor.constraint(equalToConstant: 70),
            pictureImageView.heightAnchor.constraint(equalToConstant: 70)
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



