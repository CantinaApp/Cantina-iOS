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
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(modelData.cocktails) { (cocktail) in
                        NavigationLink(destination: CocktailDetailsView(cocktail: cocktail)) {
                            VStack {
                                ImageView(url: cocktail.imageUrl)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 75, height: 75)
                                    Text(cocktail.name)
                                        .font(.system(size: 12))
                                        .lineLimit(2)
                                        .frame(height: 30)
                            }
                        }
                    }
                }
                .navigationBarTitle("Favorites")
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView().environmentObject(ModelData())
    }
}
