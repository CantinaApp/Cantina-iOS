//
//  CocktailGridItem.swift
//  Cantina
//
//  Created by Raymond Truong on 4/9/21.
//

import SwiftUI

struct CocktailGridItem: View {
    var cocktail: Cocktail
    
    var body: some View {
        HStack {
            NavigationLink(destination: CocktailDetailsView(cocktail: cocktail)) {
                VStack {
                    ImageView(url: cocktail.previewUrl)
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
}
