//
//  FavoritesAssembly.swift
//  News
//
//  Created by Тагир Булыков on 30.05.2024.
//

import Foundation

/// сборка 


class FavoritesAssembly {
    static func createModule() -> FavoritesView {
        let service = DIContainer.createFavoritesService()
        let view = FavoritesViewController()
        let presenter = FavoritesPresenterImpl(favoritesService: service, view: view)
        view.presenter = presenter
        return view
    }
}
