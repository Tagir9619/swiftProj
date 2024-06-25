import Foundation

protocol Networking {
    func send<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async -> (URLRequest?, Result<T, ServiceError>)
    
    func sendMultipart<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async -> (URLRequest?, Result<T, ServiceError>)
    
    func perform<T: Decodable>(
        request: URLRequest,
        for endpoint: Endpoint,
        responseModel: T.Type
    ) async -> Result<T, ServiceError>
}

class URLSessionNetworking: NSObject, Networking {
    private func buildUrl(for endpoint: Endpoint) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.port = endpoint.port
        urlComponents.queryItems = endpoint.queryItems
        return urlComponents.url
    }
    
    func send<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async -> (URLRequest?, Result<T, ServiceError>) {
        guard let url = buildUrl(for: endpoint) else {
            return (nil, .failure(.invalidURL))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        if let body = endpoint.body {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        endpoint.headers?.forEach {
            request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        let response = await perform(request: request, for: endpoint, responseModel: responseModel)
        return (request, response)
    }
    
    func sendMultipart<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async -> (URLRequest?, Result<T, ServiceError>) {
        guard let url = buildUrl(for: endpoint),
              let data = endpoint.dataBody else { return (nil, .failure(.invalidURL)) }
        
        let filename = endpoint.fileName
        let boundary = endpoint.boundary
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = createBody(
            boundary: boundary,
            data: data,
            mimeType: endpoint.mimeType.rawValue,
            filename: filename
        )
        
        let response = await perform(request: request, for: endpoint, responseModel: responseModel)
        return (request, response)
    }
    
    func perform<T: Decodable>(
        request: URLRequest,
        for endpoint: Endpoint,
        responseModel: T.Type
    ) async -> Result<T, ServiceError>  {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.httpAdditionalHeaders = endpoint.headers
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        do {
            let (data, response) = try await session.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    return .failure(.decode)
                }
                
                return .success(decodedResponse)
                
            case 401:
                return .failure(.unauthorized)
                
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
    
    func createBody(
        boundary: String,
        data: Data,
        mimeType: String,
        filename: String
    ) -> Data {
        var body = Data()
        let boundaryPrefix = "--\(boundary)\r\n"
        
        body.append(boundaryPrefix)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
        body.append("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.append("\r\n")
        body.append("--".appending(boundary.appending("--")))
        
        return body
    }
}
