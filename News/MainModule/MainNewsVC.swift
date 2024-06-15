//
//  ViewController.swift
//  News
//
//  Created by Тагир Булыков on 04.02.2024.
//

import UIKit
import Moya


protocol MainNewsView: AnyObject {
    func set(articles: [News])
}


class MainNewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MainNewsView {
    
    
    var presenter: MainNewsPresenter?
    private var tableView = UITableView()
    var articles: [News] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.register(LargeCell.self, forCellReuseIdentifier: "LargeCell")
        tableView.register(SmallCell.self, forCellReuseIdentifier: "SmallCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        presenter?.loadArticles()
    }
    
    func set(articles: [News]) {
        self.articles = articles
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LargeCell", for: indexPath) as! LargeCell
            let article = articles[indexPath.row]
            cell.configure(article: article)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SmallCell", for: indexPath) as! SmallCell
            let article = articles[indexPath.row]
            cell.configure(article: article)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = articles[indexPath.row]
        let articleViewController = ArticleAssembly.createModule(article: selectedArticle) as! ArticleViewController
        
        navigationController?.pushViewController(articleViewController, animated: true)
    }


}

