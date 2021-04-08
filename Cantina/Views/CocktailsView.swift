//
//  CocktailsView.swift
//  Cantina
//
//  Created by Andrew Davis on 4/1/21.
//

import SwiftUI

struct CocktailsView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationView {
            List {
                ForEach(modelData.cocktails) { (cocktail) in
                    HStack {
                        NavigationLink(destination: CocktailDetailsView(cocktail: cocktail)) {
                            ImageView(url: cocktail.imageUrl)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 75, height: 75)
                            Text(cocktail.name)
                        }
                    }
                }
            }
            .navigationBarTitle("Cocktails")
        }
    }
}

struct CocktailsView_Previews: PreviewProvider {
    static var previews: some View {
        CocktailsView()
            .environmentObject(ModelData())
    }
}
