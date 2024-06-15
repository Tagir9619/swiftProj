//
//  FavoritesPresenter.swift
//  News
//
//  Created by Тагир Булыков on 29.05.2024.
//

import Foundation


protocol FavoritesPresenter {
    func loadArticles()
    func deleteArticles(article: News)
}


class FavoritesPresenterImpl: FavoritesPresenter {
    
    
    private let favoritesService: FavoritesService
    weak var view: FavoritesView?
    var news = [News]()
    
    init(favoritesService: FavoritesService, view: FavoritesView) {
        self.favoritesService = favoritesService
        self.view = view
    }
    
    func loadArticles() {
        news = favoritesService.fetchedSaveArticles()
        view?.set(articles: news)
    }
    
    func deleteArticles(article: News) {
        favoritesService.deleteData(article: article)
    }
    
}
