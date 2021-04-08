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
                Text(cocktail.name)
                    .font(.largeTitle)
                    .bold()
                    .lineLimit(nil)
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
}

struct CocktailDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
