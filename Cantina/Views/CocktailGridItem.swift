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
                        .frame(width: 125, height: 125)
                        .cornerRadius(10)
                    Text(cocktail.name)
                        .foregroundColor(.primary)
                }
                .padding(.bottom, 25)
            }
        }
    }
}
