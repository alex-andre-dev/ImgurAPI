//
//  CatsCollectionViewModel.swift
//  ImgurAPI
//
//  Created by Alexandre  Machado on 16/07/23.
//

import UIKit

class CatsCollectionViewModel {
    
    private let api = APIAccess.shared
    private var catImages: [CatImage] = []
    
    var numberOfCatImages: Int {
        return catImages.count
    }
    
    //Carrega as imagens e popula o array catImages filtrando por somente imagens
    func fetchCatMedias(completion: @escaping (Error?) -> Void) {
        api.posts { [weak self] result in
            switch result {
            case .success(let mediaItems):
                self?.catImages = mediaItems.flatMap { $0.images.filter { $0.type == .imageJPEG || $0.type == .imagePNG } }
                completion(nil)
            case .failure(let error):
                print(error)
                completion(error)
            }
        }
    }

    func catImage(at index: Int) -> CatImage {
        return catImages[index]
    }
    
    func cleanCatImage(){
        catImages = []
    }
}

