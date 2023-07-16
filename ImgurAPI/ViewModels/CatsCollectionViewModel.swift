//
//  CatsCollectionViewModel.swift
//  ImgurAPI
//
//  Created by Alexandre  Machado on 16/07/23.
//

import UIKit

class CatsCollectionViewModel {
    
    private var catImages: [CatImages] = []
    private let api = APIAccess()
    
    //MARK: - Helpers
    func fetchData(completion: @escaping() -> Void) {
        api.fetchCatMedias { [weak self] result in
            switch result {
            case .success(let mediaItems):
                self?.catImages = mediaItems
            case .failure(let error):
                print(error)
            }
        }
    }
}
