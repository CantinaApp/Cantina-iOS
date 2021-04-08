//
//  CocktailDetailsView.swift
//  Cantina
//
//  Created by Jon Huber on 4/7/21.
//

import SwiftUI

struct CocktailDetailsView: View {
    @EnvironmentObject var modelData: ModelData
    var cocktail: Cocktail

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ImageView(url: cocktail.imageUrl)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 250, height: 250)
                
                VStack(alignment: .leading) {
                    Text("Ingredients")
                        .font(.title)
                        .bold()
                    
                    ForEach(Array(cocktail.ingredients.keys), id: \.self) { (ingredient) in
                        Text(cocktail.ingredients[ingredient]!.lowercased() + " of " + ingredient)
                    }
                }
                .padding(.top, 20)
                
                VStack(alignment: .leading) {
                    Text("Instructions")
                        .font(.title)
                        .bold()
                    
                    Text(cocktail.instructions)
                }
                .padding(.top, 20)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(20)
        }
        .navigationBarTitle(cocktail.name)
    }
}

struct CocktailDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
