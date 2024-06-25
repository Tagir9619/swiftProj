import Foundation

struct DefaultResponse: Decodable {
    enum Status: String, Decodable {
        case success
        case error
    }
    
    let status: Status
}
