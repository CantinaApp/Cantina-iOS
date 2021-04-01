//
//  ContentView.swift
//  Cantina
//
//  Created by Andrew Davis on 3/11/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        TabView {
            List {
                ForEach(modelData.cocktails) { (cocktail) in
                    HStack {
                        ImageView(url: cocktail.imageUrl)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 75, height: 75)
                        Text(cocktail.name)
                    }
                }
            }
            .tabItem {
                Image("CocktailTabBarIcon")
                Text("Cocktails")
            }
            
            Text("Favorites")
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
