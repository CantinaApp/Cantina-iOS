//
//  FilterModal.swift
//  Cantina
//
//  Created by Raymond Truong on 4/19/21.
//

import SwiftUI

struct FilterModal: View {
    
    @EnvironmentObject var modelData: ModelData
        
    @Binding var filterModal: Bool
    
    @State var selectedIngredients: Array<Ingredient>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(selectedIngredients.enumerated()), id:\.offset) { (index, ingredient) in
                    Button(action: {selectedIngredients[index].isSelected.toggle()} ) {
                        HStack {
                            Text(ingredient.name)
                            Spacer()
                            Image(systemName: (selectedIngredients[index].isSelected) ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(Color.blue)
                        }
                    }
                }
            }
            .navigationBarTitle("Select Ingredients", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        filterModal.toggle()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        modelData.ingredients = selectedIngredients
                        filterModal.toggle()
                    }
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("Clear") {
                        Array(selectedIngredients.enumerated()).forEach { (index, ingredient) in
                            selectedIngredients[index].isSelected = false
                        }
                    }
                    Spacer()
                    Button("Select All") {
                        Array(selectedIngredients.enumerated()).forEach { (index, ingredient) in
                            selectedIngredients[index].isSelected = true
                        }
                    }
                }
            }
        }
    }
}
