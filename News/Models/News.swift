//
//  News.swift
//  News
//
//  Created by Тагир Булыков on 06.02.2024.
//

import Foundation

struct NewsResponse: Decodable {
    let articles: [News]
}

struct News: Decodable {
    let author: String?
    let title: String?
    let description: String?
    let content: String?
    let urlToImage: String?
}

