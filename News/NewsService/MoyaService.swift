//
//  MoyaService.swift
//  News
//
//  Created by Тагир Булыков on 27.02.2024.
//

import Foundation
import Moya

enum getNewsMoya {
    case getData
}


extension getNewsMoya: TargetType {
    var baseURL: URL {
        return URL(string: "https://newsapi.org")!
    }
    
    var path: String {
        switch self {
        case .getData:
            return "/v2/everything?q=bitcoin&apiKey=4ddb4a99eed64a84abf82eea18f96f5f"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getData:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getData:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}

