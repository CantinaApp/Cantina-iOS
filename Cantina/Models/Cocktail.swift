//
//  Cocktail.swift
//  Cantina
//
//  Created by Andrew Davis on 3/29/21.
//

import Foundation
import UIKit

struct Cocktail: Hashable, Decodable, Identifiable {
    var id: String
    var name: String
    var glass: String
    var instructions: String
    var ingredients: [String: String]
    var imageUrl: URL
    var previewUrl: URL
    
    private enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case glass = "strGlass"
        case instructions = "strInstructions"
        case imageUrl = "strDrinkThumb"

        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"

        case measurement1 = "strMeasure1"
        case measurement2 = "strMeasure2"
        case measurement3 = "strMeasure3"
        case measurement4 = "strMeasure4"
        case measurement5 = "strMeasure5"
        case measurement6 = "strMeasure6"
        case measurement7 = "strMeasure7"
        case measurement8 = "strMeasure8"
        case measurement9 = "strMeasure9"
        case measurement10 = "strMeasure10"
        case measurement11 = "strMeasure11"
        case measurement12 = "strMeasure12"
        case measurement13 = "strMeasure13"
        case measurement14 = "strMeasure14"
        case measurement15 = "strMeasure15"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.glass = try container.decode(String.self, forKey: .glass)
        self.instructions = try container.decode(String.self, forKey: .instructions)
        self.ingredients = [String: String]()
        self.imageUrl = URL(string: try container.decode(String.self, forKey: .imageUrl))!
        self.previewUrl = URL(string: try container.decode(String.self, forKey: .imageUrl) + "/preview")!
        
        let ingredientKeys = [
            CodingKeys.ingredient1: CodingKeys.measurement1,
            CodingKeys.ingredient2: CodingKeys.measurement2,
            CodingKeys.ingredient3: CodingKeys.measurement3,
            CodingKeys.ingredient4: CodingKeys.measurement4,
            CodingKeys.ingredient5: CodingKeys.measurement5,
            CodingKeys.ingredient6: CodingKeys.measurement6,
            CodingKeys.ingredient7: CodingKeys.measurement7,
            CodingKeys.ingredient8: CodingKeys.measurement8,
            CodingKeys.ingredient9: CodingKeys.measurement9,
            CodingKeys.ingredient10: CodingKeys.measurement10,
            CodingKeys.ingredient11: CodingKeys.measurement11,
            CodingKeys.ingredient12: CodingKeys.measurement12,
            CodingKeys.ingredient13: CodingKeys.measurement13,
            CodingKeys.ingredient14: CodingKeys.measurement14,
            CodingKeys.ingredient15: CodingKeys.measurement15
        ]
        
        // Generate key-value pairs for each ingredient
        try ingredientKeys.forEach({ (ingredient, measurement) in
            do {
                let ingredient = try container.decode(String.self, forKey: ingredient)
                let measurement = try container.decode(String.self, forKey: measurement)
                self.ingredients[ingredient] = measurement
            } catch DecodingError.valueNotFound {
                // Inside of closure, so return will only end current iteration
                return
            }
        })
    }
    
    // TODO: Add Encodable protocol for storing favorites offline
}

extension Cocktail {
    var isFavorite: Bool {
        get {
            let favorites = Cocktail.getFavorites()
            return favorites[self.id] != nil
        }
        
        set {
            newValue == true ? addToFavorites() : removeFromFavorites()
        }
    }
    
    private func addToFavorites() {
        var favorites = Cocktail.getFavorites()
        favorites[self.id] = ""
        UserDefaults.standard.set(favorites, forKey: "favorites")
    }
    
    private func removeFromFavorites() {
        var favorites = Cocktail.getFavorites()
        favorites.removeValue(forKey: self.id)
        UserDefaults.standard.set(favorites, forKey: "favorites")
    }
    
    private static func getFavorites() -> [String: String] {
        var favorites = UserDefaults.standard.dictionary(forKey: "favorites")
        if favorites == nil {
            favorites = [String: String]()
            UserDefaults.standard.set(favorites, forKey: "favorites")
        }
        return favorites as! [String: String]
    }
}

// Used to decode from /search endpoint
struct CocktailList: Decodable {
    var drinks: [Cocktail]
}
