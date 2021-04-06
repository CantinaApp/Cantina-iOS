//
//  CocktailRow.swift
//  Cantina
//
//  Created by Andrew Davis on 4/6/21.
//

import SwiftUI

struct CocktailRow: View {
    var cocktail: Cocktail
    
    var body: some View {
        HStack {
            HStack {
                ImageView(url: cocktail.imageUrl)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 75, height: 75)
                Text(cocktail.name)
            }
            
            Spacer()
            
            if cocktail.isFavorite() {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
            }
        }
    }
}
