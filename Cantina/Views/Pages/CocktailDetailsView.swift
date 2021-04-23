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
    
    var cocktailIndex: Int {
        modelData.cocktails.firstIndex(of: cocktail)!
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ImageView(url: cocktail.imageUrl)
                    .aspectRatio(contentMode: .fill)
                
                HStack {
                    Text(cocktail.name)
                        .bold()
                    
                    FavoriteButton(isFavorited: $modelData.cocktails[cocktailIndex].isFavorite)
                        .padding(.leading, 5)
                }
                .font(.largeTitle)
                .padding(10)

                VStack(alignment: .leading) {
                    Text("Ingredients")
                        .font(.title2)
                        .bold()

                    ForEach(Array(cocktail.ingredients.keys), id: \.self) { (ingredient) in
                        Text(cocktail.ingredients[ingredient]!.lowercased() + ingredient)
                    }
                }
                .padding(10)

                VStack(alignment: .leading) {
                    Text("Instructions")
                        .font(.title2)
                        .bold()

                    Text(cocktail.instructions)
                }
                .padding(10)
            }
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
        .padding(.bottom, 20)
        .toolbar {
            Button(action: { showShareSheet(name: cocktail.name, instructions: cocktail.instructions, ingredients: cocktail.ingredients) }) {
                Image(systemName: "square.and.arrow.up")
            }
        }
    }
    
    func showShareSheet(name: String, instructions: String, ingredients: [String: String]) {
        var ingredientsString = ""
        for key in ingredients.keys {
            ingredientsString.append(cocktail.ingredients[key]!.lowercased() + key + "\n")
        }
        
        let shareString = ["Cocktail: " + name + "\nIngredients:\n" + ingredientsString + "Instructions: " + instructions]
        let activityController = UIActivityViewController(activityItems: shareString, applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
    }
}

struct CocktailDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
