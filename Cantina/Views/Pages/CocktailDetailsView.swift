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
            GeometryReader { geometry in
                ZStack {
                    if geometry.frame(in: .global).minY <= 0 {
                        ImageView(url: cocktail.imageUrl)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .offset(y: geometry.frame(in: .global).minY/9)
                            .clipped()
                    } else {
                        ImageView(url: cocktail.imageUrl)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                            .clipped()
                            .offset(y: -geometry.frame(in: .global).minY)
                    }
                }
            }
            .frame(height: 400)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(cocktail.name)
                        .bold()
                        .lineLimit(nil)
                    
                    FavoriteButton(isFavorited: $modelData.cocktails[cocktailIndex].isFavorite)
                        .padding(.leading, 5)
                    
                    Button(action: { showShareSheet(name: cocktail.name, instructions: cocktail.instructions, ingredients: cocktail.ingredients) }) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(Color.gray)
                    }
                    .padding(.leading, 5)
                }
                .font(.largeTitle)
                .padding(.top, 10)
                
                VStack(alignment: .leading) {
                    Text("Ingredients")
                        .font(.title2)
                        .bold()

                    ForEach(Array(cocktail.ingredients.keys), id: \.self) { (ingredient) in
                        Text(cocktail.ingredients[ingredient]! + ingredient)
                    }
                }
                .padding(.top, 20)

                VStack(alignment: .leading) {
                    Text("Instructions")
                        .font(.title2)
                        .bold()

                    Text(cocktail.instructions)
                }
                .padding(.top, 20)
            }
            .frame(width: 350)
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    func showShareSheet(name: String, instructions: String, ingredients: [String: String]) {
        var ingredientsString = ""
        for key in ingredients.keys {
            ingredientsString.append(cocktail.ingredients[key]! + " " + key + "\n")
        }
        
        let shareString = [name + "\n" + ingredientsString + instructions]
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
