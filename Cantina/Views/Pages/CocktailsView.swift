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
    
    @State var filterModal: Bool = false
    
    @State private var navBtnID = UUID()

    var body: some View {
        NavigationView {
            List {
                ForEach(filterCocktails(modelData: modelData, query: searchBar.text)) { (cocktail) in
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
                ToolbarItem {
                    if !modelData.ingredients.isEmpty {
                        Button(action: {
                            filterModal.toggle()
                        }) {
                            HStack(spacing: 6) {
                                Image(systemName: "line.horizontal.3.decrease")
                                Text("Filter")
                            }
                        }
                        .id(self.navBtnID) //force layout engine to refresh because swift bug
                    }
                }
            }
        }
        .sheet(isPresented: $filterModal) {
            FilterModal(filterModal: $filterModal, selectedIngredients: modelData.ingredients)
                .onDisappear {
                    self.navBtnID = UUID()
                }
        }
    }
}

func filterCocktails(modelData: ModelData, query: String) -> Array<Cocktail> {
    // Filter by search bar
    var results = modelData.cocktails.filter { query.isEmpty || $0.name.localizedStandardContains(query) }
    
    let selectedIngredients = modelData.ingredients.filter { $0.isSelected }.map{ $0.name }
    
    // Filter by ingredients if selected
    if !selectedIngredients.isEmpty {
        results = results.filter { Set($0.ingredients.keys).intersection(selectedIngredients).isEmpty == false }
    }
    
    return results
}

struct CocktailsView_Previews: PreviewProvider {
    static var previews: some View {
        CocktailsView()
            .environmentObject(ModelData())
    }
}
