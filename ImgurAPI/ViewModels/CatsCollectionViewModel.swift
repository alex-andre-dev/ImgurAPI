//
//  CatsCollectionViewModel.swift
//  ImgurAPI
//
//  Created by Alexandre  Machado on 16/07/23.
//

import UIKit

class CatsCollectionViewModel {
   
    //MARK: - Properties
    
    private let api = APIAccess.shared

    //MARK: - Helpers
    
    func fetchData(completion: @escaping([CatImages]) -> Void) {
        api.posts { result in
            switch result {
            case .success(let mediaItems):
                completion(mediaItems)
            case .failure(let error):
                print(error)
            }
        }
    }
}
