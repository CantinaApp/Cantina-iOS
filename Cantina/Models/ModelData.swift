//
//  ModelData.swift
//  Cantina
//
//  Created by Andrew Davis on 3/30/21.
//

import Combine
import Foundation

final class ModelData: ObservableObject {
    @Published var cocktails: [Cocktail]
    
    init() {
        self.cocktails = [Cocktail]()
        loadCocktails()
        
        // Set image cache capacity
        URLCache.shared.memoryCapacity = 6 * (1024*1024) // 6MB ram
        URLCache.shared.diskCapacity = 40 * (1024*1024) // 40MB disk
    }
    
    func loadCocktails() {
        var baseUrl = URLComponents(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php")!
        
        for letter in "abcdefghijklmnopqrstuvwxyz" {
            // Append query item for "first letter"
            let query = [URLQueryItem(name: "f", value: String(letter))]
            baseUrl.queryItems = query
            
            // Asynchronously get each list of cocktails (grouped by first letter)
            let task = URLSession.shared.dataTask(with: baseUrl.url!) { (data, response, error) in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    let decoder = JSONDecoder()
                    if let cocktailList = try? decoder.decode(CocktailList.self, from: data) {
                        self.cocktails.append(contentsOf: cocktailList.drinks)
                        
                        // TODO: Remove sorting or make entire operation sync
                        self.cocktails.sort { (a, b) -> Bool in
                            a.name < b.name
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
