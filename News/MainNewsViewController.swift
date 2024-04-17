//
//  ViewController.swift
//  News
//
//  Created by Тагир Булыков on 04.02.2024.
//

import UIKit
import Moya

class MainNewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var tableView = UITableView()
    var newsService = NewsService()
    var articles: [News] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.register(LargeCell.self, forCellReuseIdentifier: "LargeCell")
        tableView.register(SmallCell.self, forCellReuseIdentifier: "SmallCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        newsService.getNews(completion: { articles in
            self.articles = articles
            self.tableView.reloadData()
        })
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
        let articleViewController = ArticleViewController()
        articleViewController.article = articles[indexPath.row]
        navigationController?.pushViewController(articleViewController, animated: true)
    }


}

