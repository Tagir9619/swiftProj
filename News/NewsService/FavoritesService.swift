//
//  FavoritesService.swift
//  News
//
//  Created by Тагир Булыков on 29.03.2024.
//

import Foundation
import UIKit
import CoreData





class FavoritesService {
    let coreDataService = CoreDataService()

    func fetchedSaveArticles() -> [News] {
        var news = [News]()
        let fetchedArticle = coreDataService.fetch(nameDB: "NewsDB")
        
        for article in fetchedArticle {
            if let examplare = article as? NewsDB {
                let newsExaplmare = News(
                    author: examplare.author,
                    title: examplare.title,
                    description: examplare.desc,
                    content: examplare.content,
                    urlToImage: examplare.urlToImage
                    )
                news.append(newsExaplmare)
            }
        }
        return news
    }
    
    func saveData(article: News) {
        if let urlToImage = article.urlToImage {
            let predicate = NSPredicate(format: "urlToImage == %@", urlToImage)
            let fetcedArticles = coreDataService.fetch(nameDB: "NewsDB", predicate: predicate)
            if fetcedArticles.count == 0 {
                let newsDB = NewsDB(context: coreDataService.context)
                
                newsDB.author = article.author
                newsDB.title = article.title
                newsDB.urlToImage = article.urlToImage
                newsDB.content = article.content
                newsDB.desc = article.description
                coreDataService.saveContext()
            }
        }
    }
    
    func deleteData(article: News) {
        if let compaundPredicate = compoundPredicate(article: article) {
            let fetcedArticles = coreDataService.fetch(nameDB: "NewsDB", predicate: compaundPredicate)
            for delete in fetcedArticles {
                coreDataService.deleteContext(article: delete)
            }
        }
    }
    
    func compoundPredicate(article: News) -> NSCompoundPredicate? {
        var predicates: [NSPredicate] = []
        if let author = article.author {
            let predicate = NSPredicate(format: "author == %@", author)
            predicates.append(predicate)
        }
        if let urlToImage = article.urlToImage {
            let predicate = NSPredicate(format: "urlToImage == %@", urlToImage)
            predicates.append(predicate)
        }
        if predicates.isEmpty {
            print("Совпадений не найдено")
            return nil
        }
        return NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
    }
    
    
    func isArticleSaved(article: News) -> Bool {
        let compoundPredicate = compoundPredicate(article: article)
        let fetchedArticles = coreDataService.fetch(nameDB: "NewsDB", predicate: compoundPredicate)
        if !fetchedArticles.isEmpty {
            return true
        } else {
            return false
        }
    }
    
}
