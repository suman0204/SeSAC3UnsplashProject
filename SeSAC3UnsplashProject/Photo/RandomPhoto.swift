//
//  RandomPhoto.swift
//  SeSAC3UnsplashProject
//
//  Created by 홍수만 on 2023/09/18.
//

import Foundation

//struct RandomPhoto: Codable, Hashable{
//    let randomPhotoList: [RandomPhotoElement]
//}

struct RandomPhotoElement: Codable, Hashable{
    let id, slug: String?
    let createdAt, updatedAt, promotedAt: String
    let width, height: Int
    let color, blurHash: String
    let description: String?
    let urls: Urls
    let likes: Int

    enum CodingKeys: String, CodingKey {
        case id, slug
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case promotedAt = "promoted_at"
        case width, height, color
        case blurHash = "blur_hash"
        case description
        case urls, likes
        
    }
}

struct Urls: Codable, Hashable {
    let raw, full, regular, small: String
    let thumb, smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}
