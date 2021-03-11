//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Rostyslav Shmorhun on 10.02.2021.
//

import Foundation

class  NetworkManager {
    
    
    func fetchData(comp: @escaping ([Articles])->())  {
        
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=2363bb479d3444f4a3154b98e26b6ab0"
        guard let url = URL(string: urlString) else {
            return
        }
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if error == nil && data != nil {
                // Parse JSON
                let decoder = JSONDecoder()
                do {
                    let newsFeed = try decoder.decode(NewsFeed.self, from: data!)
                    DispatchQueue.main.async {
                        comp(newsFeed.articles!)
                    }
                }
                catch {
                    print("error in JSON Parsing")
                }
            }
        }
        dataTask.resume()
    }
    
}



