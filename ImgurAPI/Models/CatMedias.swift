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
    let type: TypeEnum
    let link: String
}

enum TypeEnum: String, Codable {
    case imageJPEG = "image/jpeg"
    case imagePNG = "image/png"
    case videoMp4 = "video/mp4"
}
