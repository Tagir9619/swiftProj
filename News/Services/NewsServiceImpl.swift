//
//  NewsService.swift
//  News
//
//  Created by Тагир Булыков on 06.02.2024.
//

import Foundation
import Moya

protocol NewsService: AnyObject {
    func getNews(completion:@escaping ([News]) -> () )
}


class NewsServiceImpl: NewsService {
    
    func getNews(completion:@escaping ([News]) -> () ) {
        
        let url = URL(string: "https://newsapi.org/v2/everything?q=bitcoin&apiKey=4ddb4a99eed64a84abf82eea18f96f5f")
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error == nil {
                if let data = data {
                    let response = try! JSONDecoder().decode(NewsResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(response.articles)
                    }
                }
            }
        }
        task.resume()
    }
    
    
    
    func parsing<Model: Decodable>(data: Data, responsModel: Model.Type) -> Model? {
        let model = try? JSONDecoder().decode(responsModel, from: data)
        return model
    }

}
