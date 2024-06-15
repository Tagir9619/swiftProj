//
//  ArticleAssembly.swift
//  News
//
//  Created by Тагир Булыков on 02.06.2024.
//

import Foundation


class ArticleAssembly {
    static func createModule(article: News) -> ArticleView {
        let service = DIContainer.createFavoritesService()
        let view = ArticleViewController()
        let presenter = ArticlePresenterImpl(favoritesService: service, view: view)
        presenter.article = article
        view.presenter = presenter
        return view
    }
}
