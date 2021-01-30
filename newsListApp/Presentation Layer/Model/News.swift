//
//  News.swift
//  newsListApp
//
//  Created by Aiymgul Sarsenbayeva on 1/30/21.
//

import Foundation

struct News: Codable {
    let title: String
    let author: String?
    let description: String
    let publishedAt: String
    let shareLink: String
    let urlToImage: String?
    
    private enum CodingKeys: String, CodingKey {
        case title, author, description, publishedAt
        case shareLink = "url"
        case urlToImage
    }
}

struct NewsWrapper: Codable {
    let articles: [News]
}
