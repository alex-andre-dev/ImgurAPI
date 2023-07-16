//
//  APIAccess.swift
//  ImgurAPI
//
//  Created by Alexandre  Machado on 16/07/23.
//

import Foundation

class APIAccess {
    
    private let baseURL = "https://api.imgur.com/3/gallery/search/?q=cats"
    private let clientId = "1ceddedc03a5d71"
    
    func fetchCatMedias(completion: @escaping (Result<[CatImages], Error>) -> Void) {
        
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "URL Inválida", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Cliente-ID \(clientId)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(CatMedias.self, from: data)
                    let catMedias = response
                    print(response)
                    completion(.success([CatImages(images: [CatImage(id: "", type: "", link: "")])]))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
