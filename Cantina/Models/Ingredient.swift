//
//  Ingredient.swift
//  Cantina
//
//  Created by Andrew Davis on 4/21/21.
//

import Foundation

struct Ingredient: Hashable {
    var name: String
    var isSelected: Bool
}

extension Ingredient: Decodable {
    private enum APICodingKeys: String, CodingKey {
        case name = "strIngredient1"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: APICodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.isSelected = false
    }
}

// Used to decode from /list endpoint
struct IngredientList: Decodable {
    var ingredients: [Ingredient]
    
    private enum CodingKeys: String, CodingKey {
        case ingredients = "drinks"
    }
}
