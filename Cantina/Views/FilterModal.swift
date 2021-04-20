//
//  FilterModal.swift
//  Cantina
//
//  Created by Raymond Truong on 4/19/21.
//

import SwiftUI

struct FilterModal: View {
    
    @ObservedObject var filterSearchBar: SearchBar = SearchBar()
    
    var ingredients = (0...60).map{"Ingredient #\($0)"}
    
    @Binding var filterModal: Bool
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.ingredients.filter { filterSearchBar.text.isEmpty || $0.localizedStandardContains(filterSearchBar.text) }, id:\.self) { (ingredient) in
                    HStack {
                        Text(ingredient)
                        Spacer()
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Color.blue)
                    }
                }
            }
            .add(filterSearchBar)
            .navigationBarTitle("Select Ingredients", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        filterModal = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Apply") {
                        print("Apply filter for selected ingredients and dismiss modal")
                        filterModal = false
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("Clear") {
                        print("Clear all selected ingredients")
                    }
                    Spacer()
                    Button("Select All") {
                        print("Select all ingredients")
                    }
                }
            }
        }
    }
}
