//
//  APIAccess.swift
//  ImgurAPI
//
//  Created by Alexandre  Machado on 16/07/23.
//

import Foundation

class APIAccess {
    
    enum NetworkError: Error {
        case badResponse(URLResponse?)
        case badData
    }
    
    static var shared = APIAccess()
        
    let session: URLSession
    
    private let baseURL = "https://api.imgur.com/3/gallery/search/?q=cats"
    private let clientId = "1ceddedc03a5d71"
    
    init(){
        session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    private func request(url: URL) -> URLRequest{
        var request = URLRequest(url: url)
        request.addValue("Client-ID \(clientId)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func posts(completion: @escaping (Result<[CatImages], Error>) -> Void){
        guard let url = URL(string:baseURL) else { return }
        let req = request(url: url)
        
        let task = session.dataTask(with: req) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.badResponse(response)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.badData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(CatMedias.self, from: data)
                let catMedias = response.data
                completion(.success(catMedias))
            } catch let error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
