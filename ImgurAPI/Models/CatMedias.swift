//
//  CatMedias.swift
//  ImgurAPI
//
//  Created by Alexandre  Machado on 16/07/23.
//

struct CatMedias: Codable{
    let data: [CatImages]
}

struct CatImages: Codable{
    let images: [CatImage]
}

struct CatImage: Codable {
    let id: String
    let type: String
    let link: String
}
