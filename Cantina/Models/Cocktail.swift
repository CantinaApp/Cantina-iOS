//
//  Cocktail.swift
//  Cantina
//
//  Created by Andrew Davis on 3/29/21.
//

import Foundation
import UIKit

struct Cocktail: Hashable, Identifiable {
    var id: String
    var name: String
    var glass: String
    var instructions: String
    var ingredients: [String: String]
    var imageUrl: URL
    var previewUrl: URL
}

// MARK: Favoriting
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

    static func getFavorites() -> [String: Data] {
        var favorites = UserDefaults.standard.dictionary(forKey: "favorites")
        if favorites == nil {
            favorites = [String: Data]()
            UserDefaults.standard.set(favorites, forKey: "favorites")
        }
        return favorites as! [String: Data]
    }

    private func addToFavorites() {
        var favorites = Cocktail.getFavorites()
        favorites[self.id] = try! JSONEncoder().encode(self)
        UserDefaults.standard.set(favorites, forKey: "favorites")
    }

    private func removeFromFavorites() {
        var favorites = Cocktail.getFavorites()
        favorites.removeValue(forKey: self.id)
        UserDefaults.standard.set(favorites, forKey: "favorites")
    }
}

// MARK: Decoding
extension Cocktail: Codable {
    private enum APICodingKeys: String, CodingKey {
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
    private enum CodingKeys: String, CodingKey {
        case id, name, glass, instructions, ingredients, imageUrl, previewUrl
    }
    
    init(from decoder: Decoder) throws {
        if let cocktail = Cocktail(fromAPI: decoder) {
            self = cocktail
        } else {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decode(String.self, forKey: .id)
            self.name = try container.decode(String.self, forKey: .name)
            self.glass = try container.decode(String.self, forKey: .glass)
            self.instructions = try container.decode(String.self, forKey: .instructions)
            self.ingredients = try container.decode([String: String].self, forKey: .ingredients)
            self.imageUrl  = try container.decode(URL.self, forKey: .imageUrl)
            self.previewUrl = try container.decode(URL.self, forKey: .previewUrl)
        }
    }
    
    init?(fromAPI decoder: Decoder) {
        let ingredientMap = [
            APICodingKeys.ingredient1: APICodingKeys.measurement1,
            APICodingKeys.ingredient2: APICodingKeys.measurement2,
            APICodingKeys.ingredient3: APICodingKeys.measurement3,
            APICodingKeys.ingredient4: APICodingKeys.measurement4,
            APICodingKeys.ingredient5: APICodingKeys.measurement5,
            APICodingKeys.ingredient6: APICodingKeys.measurement6,
            APICodingKeys.ingredient7: APICodingKeys.measurement7,
            APICodingKeys.ingredient8: APICodingKeys.measurement8,
            APICodingKeys.ingredient9: APICodingKeys.measurement9,
            APICodingKeys.ingredient10: APICodingKeys.measurement10,
            APICodingKeys.ingredient11: APICodingKeys.measurement11,
            APICodingKeys.ingredient12: APICodingKeys.measurement12,
            APICodingKeys.ingredient13: APICodingKeys.measurement13,
            APICodingKeys.ingredient14: APICodingKeys.measurement14,
            APICodingKeys.ingredient15: APICodingKeys.measurement15
        ]
        
        do {
            let container = try decoder.container(keyedBy: APICodingKeys.self)
            
            self.id = try container.decode(String.self, forKey: .id)
            self.name = try container.decode(String.self, forKey: .name)
            self.glass = try container.decode(String.self, forKey: .glass)
            self.instructions = try container.decode(String.self, forKey: .instructions)
            self.ingredients = [String: String]()
            self.imageUrl = URL(string: try container.decode(String.self, forKey: .imageUrl))!
            self.previewUrl = self.imageUrl.appendingPathComponent("/preview")
            
            try ingredientMap.forEach { (ingredient, measurement) in
                do {
                    let ingredient = try container.decode(String.self, forKey: ingredient)
                    var measurement = (try? container.decode(String.self, forKey: measurement)) ?? ""
                    
                    if (!measurement.isEmpty && !measurement.hasSuffix(" ")) {
                        measurement = measurement + " "
                    }
                    
                    self.ingredients[ingredient] = measurement
                } catch DecodingError.valueNotFound {
                    // Inside of closure, so return will only end current iteration
                    return
                }
            }
            
        } catch {
            return nil
        }
    }
}

// Used to decode from /search endpoint
struct CocktailList: Decodable {
    var drinks: [Cocktail]
}
