//
//  FavoritesViewController.swift
//  News
//
//  Created by Тагир Булыков on 10.03.2024.
//

import Foundation
import UIKit
import CoreData

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarControllerDelegate {
    
    
    
    // MARK: - Views
    private let tableView = UITableView()
    var articles: [News] = []
    var favoritesService = FavoritesService()
    
    
    //MARK: - Lifecircle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchArticles()
        tableView.reloadData()
    }
}
    //MARK: - Extention
extension FavoritesViewController {
    func setupLayout() {
        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        view.backgroundColor = .systemPurple
        tableView.register(SmallCell.self, forCellReuseIdentifier: "SmallCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    //MARK: - TableView Settings
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SmallCell", for: indexPath) as! SmallCell
        let article = articles[indexPath.row]
        cell.configure(article: article)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleViewController = ArticleViewController()
        articleViewController.article = articles[indexPath.row]
        navigationController?.pushViewController(articleViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let trash = UIContextualAction(style: .destructive,
                                       title: "Trash") { [weak self] (action, view, completionHandler) in
            guard let self = self else {return}
            let article = articles[indexPath.row]
            self.favoritesService.deleteData(article: self.articles[indexPath.row])
            self.articles.removeAll() { deleteArticle in
                deleteArticle.urlToImage == article.urlToImage
            }
            tableView.reloadData()
            completionHandler(true)
        }
        trash.backgroundColor = .systemRed
        
        let configuration = UISwipeActionsConfiguration(actions: [trash])
        
        return configuration
    }

    //MARK: - Fetch Articles
    func fetchArticles() {
        let fetchedArticles = favoritesService.fetchedSaveArticles()
        articles = fetchedArticles
    }
}





/// 1. Сделать CoreDataService, которая содержит все метод работы с CoreData из AppDelegate
/// 2. Сделать FavoritesService, которая содержит все запросы в базу, сохранения и т.д.
/// 3. Сервис и контроллеры должен работать через News
/// 4. SOLID - изучить
///
///  1. Сделать заполнение звезды при сохранении и удалении
