//
//  CocktailsView.swift
//  Cantina
//
//  Created by Andrew Davis on 4/1/21.
//

import SwiftUI

struct CocktailsView: View {
    @EnvironmentObject var modelData: ModelData
    
    @ObservedObject var searchBar: SearchBar = SearchBar()
    
    @State var filterModal = false

    var body: some View {
        NavigationView {
            List {
                ForEach(modelData.cocktails.filter { searchBar.text.isEmpty || $0.name.localizedStandardContains(searchBar.text) }) { (cocktail) in
                    HStack {
                        NavigationLink(destination: CocktailDetailsView(cocktail: cocktail)) {
                            CocktailRow(cocktail: cocktail)
                        }
                    }
                }
            }
            .navigationBarTitle("Cocktails")
            .add(searchBar)
            .toolbar {
                Button(action: {
                    self.filterModal.toggle()
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "line.horizontal.3.decrease")
                        Text("Filter")
                    }
                }
            }
        }.sheet(isPresented: $filterModal, content: {
            FilterModal()
        })
    }
}

struct CocktailsView_Previews: PreviewProvider {
    static var previews: some View {
        CocktailsView()
            .environmentObject(ModelData())
    }
}
