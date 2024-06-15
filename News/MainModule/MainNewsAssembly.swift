//
//  MainNewsAssembly.swift
//  News
//
//  Created by Тагир Булыков on 11.06.2024.
//

import Foundation


class MainNewsAssembly {
    static func createModule() -> MainNewsView {
        let service = DIContainer.createNewsService()
        let view = MainNewsViewController()
        let presenter = MainNewsPresenterImpl(newsService: service, view: view)
        view.presenter = presenter
        return view
    }
}
