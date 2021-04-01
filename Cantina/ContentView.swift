//
//  ContentView.swift
//  Cantina
//
//  Created by Andrew Davis on 3/11/21.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        TabView {
            CocktailsView()
                .tabItem {
                    Image("CocktailTabBarIcon")
                    Text("Cocktails")
                }
            
            FavoritesView()
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
