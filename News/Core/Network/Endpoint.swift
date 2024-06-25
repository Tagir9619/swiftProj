import Foundation

enum MimeType: String {
    case mp4 = "video/mp4"
}

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var port: Int { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var method: RequestMethod { get }
    var needAuth: Bool { get }
    var headers: [String: String]? { get }
    var defaultHeaders: [String: String]? { get }
    var body: [String: Any]? { get }
    
    // Multipart
    var boundary: String { get }
    var fileName: String { get }
    var mimeType: MimeType { get }
    var dataBody: Data? { get }
}

extension Endpoint {
    var scheme: String { "http" }
    var host: String { "localhost" }
    var port: Int { 4000 }
    var needAuth: Bool { false }
    
    var queryItems: [URLQueryItem]? { nil }
    
    var headers: [String: String]? {
        defaultHeaders
    }
    
    var defaultHeaders: [String: String]? {
        if needAuth {
            return ["Authorization": "Bearer " + (DIContainerStorages.buildAuthStorage().getAccessToken() ?? "")]
        }
        
        return [:]
    }
    
    var body: [String : Any]? { nil }
    
    // MARK: - Multipart
    
    var boundary: String { "Boundary-\(UUID().uuidString)" }
    var fileName: String { "" }
    var mimeType: MimeType { .mp4 }
    var dataBody: Data? { nil }
}
