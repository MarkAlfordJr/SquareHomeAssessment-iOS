//
//  ApiManager.swift
//  SquareTakeHome
//
//  Created by Mark Alford on 4/5/22.
//

import Foundation

class ApiManager {
    // DEPENDENCY INJECTION
        // now, api manager can use URLSession or MockSession data
    static let sharedInstance = ApiManager()
        // when ever an object is called, either:
            // production URLSession
            // 'MockSession' test json
    public init() {}
    /// generic API function
    /// - parameters: ApiEndpoint case function
    /// - parameters: completion handler for api result
    func getRequest<T: Codable>(endpoint: EndPoint, completion: @escaping (Result<T, Error>) -> ()) {
        // 1 hook up endpoint properties to URL components
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseUrl
        components.queryItems = endpoint.queryParameters
        components.path = endpoint.path
        
        // 2 setup url and http method
        guard let url = components.url else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.httpMethod
        
        // 3 setup data task
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            // 4 make sure error is empty
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription ?? "Unknown Error")
                return
            }
            // 5 make sure data is safe
            guard response != nil, let safeData = data else {return}
            // 6 parse JSON
            do {
                let result = try JSONDecoder().decode(T.self, from: safeData)
                print(result)
                completion(.success(result))
            } catch {
                let error = NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey: "found error getting result"])
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
}
