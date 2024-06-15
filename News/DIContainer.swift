//
//  DIContainer.swift
//  News
//
//  Created by Тагир Булыков on 30.05.2024.
//

import Foundation

class DIContainer {
    static func createCoreDataService() -> CoreDataService {
        CoreDataServiceImpl()
    }
    
    static func createFavoritesService() -> FavoritesService {
        FavoritesServiceImpl(coreDataService: createCoreDataService())
    }
    
    static func createNewsService() -> NewsService {
        NewsServiceImpl()
    }
    
    /// имплиминтации ведутся только в DIContainer
    
}
