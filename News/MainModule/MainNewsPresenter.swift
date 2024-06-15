//
//  MainNewsPresenter.swift
//  News
//
//  Created by Тагир Булыков on 23.05.2024.
//

import Foundation

protocol MainNewsPresenter {
    func loadArticles()
}



class MainNewsPresenterImpl:MainNewsPresenter {
    private let newsService: NewsService
    private weak var view: MainNewsView?
    
    init(newsService: NewsService, view: MainNewsView) {
        self.newsService = newsService
        self.view = view
    }
    
    func loadArticles() {
        newsService.getNews(completion: { [weak self] articles in
            self?.view?.set(articles: articles)
        })
    }
}

