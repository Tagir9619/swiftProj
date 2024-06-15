//
//  ArtcilePresenter.swift
//  News
//
//  Created by Тагир Булыков on 02.06.2024.
//

import Foundation


protocol ArticlePresenter {
    var article: News? { get set }
    func isArticleSaved(article: News) -> Bool
    func saveData(article: News)
    func deleteData(article: News)
    func didWiewLoad()
}


class ArticlePresenterImpl: ArticlePresenter {

    
    private let favoritesService: FavoritesService
    weak var view: ArticleViewController?
    var article: News?
    
    init(favoritesService: FavoritesService, view: ArticleViewController) {
        self.favoritesService = favoritesService
        self.view = view
    }
    
    func isArticleSaved(article: News) -> Bool {
        favoritesService.isArticleSaved(article: article)
    }
    
    func saveData(article: News) {
        favoritesService.saveData(article: article)
    }
    
    func deleteData(article: News) {
        favoritesService.deleteData(article: article)
    }
    
    func didWiewLoad() {
        if let article = article {
            view?.set(article: article)
        }
    }
    
    
    
}
