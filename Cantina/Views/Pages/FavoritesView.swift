//
//  FavoritesView.swift
//  Cantina
//
//  Created by Andrew Davis on 4/1/21.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var modelData: ModelData
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            HStack {
                if !modelData.cocktails.contains { cocktail in cocktail.isFavorite } {
                    Text("You have no favorited cocktails.")
                        .font(.title2)
                        .lineLimit(0)
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(modelData.cocktails) { (cocktail) in
                                if cocktail.isFavorite {
                                    NavigationLink(destination: CocktailDetailsView(cocktail: cocktail)) {
                                        CocktailGridItem(cocktail: cocktail)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Favorites")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView().environmentObject(ModelData())
    }
}
