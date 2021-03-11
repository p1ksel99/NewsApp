//
//  Articles.swift
//  NewsApp
//
//  Created by Rostyslav Shmorhun on 06.02.2021.
//

import Foundation

struct Articles: Decodable {
    
    var author: String?
    var title: String?
    var description: String?
    var url: String
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
}
