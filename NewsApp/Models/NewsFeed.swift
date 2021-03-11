//
//  NewsFeed.swift
//  NewsApp
//
//  Created by Rostyslav Shmorhun on 06.02.2021.
//

import Foundation

struct NewsFeed: Decodable {
    
    var status:String = ""
    var totalResults:Int = 0
    let articles:[Articles]?
    
}
