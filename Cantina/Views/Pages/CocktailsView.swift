//
//  CocktailsView.swift
//  Cantina
//
//  Created by Andrew Davis on 4/1/21.
//

import SwiftUI

struct CocktailsView: View {
    @EnvironmentObject var modelData: ModelData
    
    @ObservedObject var drinkSearchBar: SearchBar = SearchBar()
    
    @State var filterModal: Bool = false
    
    @State private var navBtnID = UUID()

    var body: some View {
        NavigationView {
            List {
                ForEach(modelData.cocktails.filter { drinkSearchBar.text.isEmpty || $0.name.localizedStandardContains(drinkSearchBar.text) }) { (cocktail) in
                    HStack {
                        NavigationLink(destination: CocktailDetailsView(cocktail: cocktail)) {
                            CocktailRow(cocktail: cocktail)
                        }
                    }
                }
            }
            .navigationBarTitle("Cocktails")
            .add(drinkSearchBar)
            .toolbar {
                ToolbarItem {
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
        .sheet(isPresented: $filterModal) {
            FilterModal(filterModal: $filterModal)
                .onDisappear {
                    self.navBtnID = UUID()
                }
        }
    }
}

struct CocktailsView_Previews: PreviewProvider {
    static var previews: some View {
        CocktailsView()
            .environmentObject(ModelData())
    }
}
