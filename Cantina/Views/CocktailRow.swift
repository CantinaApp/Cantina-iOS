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
            ImageView(url: cocktail.previewUrl)
                .aspectRatio(contentMode: .fill)
                .frame(width: 75, height: 75)
                .cornerRadius(10)
                .padding(.trailing, 10)
            VStack(alignment: .leading) {
                Text(cocktail.name)
                Text(cocktail.ingredients.keys.joined(separator: ", "))
                    .font(.caption)
                    .lineLimit(1)
            }
            Spacer(minLength: 10)
        }
    }
}
