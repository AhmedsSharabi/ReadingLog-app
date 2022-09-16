//
//  File.swift
//  Book
//
//  Created by Ahmed Sharabi on 14/09/2022.
//

import Foundation

struct Book: Codable {
    let items: [Item]
}

struct Item: Codable {
    
    let id: String
    let volumeInfo: Volume
}

struct Volume: Codable {
    let title: String
    let subtitle: String?
    let authors: [String]?
    let imageLinks: Images?
}
struct Images:Codable {
    let smallThumbnail: String
    let thumbnail: String
}

