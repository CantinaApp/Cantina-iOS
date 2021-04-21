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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Array(modelData.ingredients.enumerated()), id:\.offset) { (index, ingredient) in
                    Button(action: {modelData.ingredients[index].isSelected.toggle()} ) {
                        HStack {
                            Text(ingredient.name)
                            Spacer()
                            Image(systemName: (ingredient.isSelected) ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(Color.blue)
                        }
                    }
                }
            }
            .navigationBarTitle("Select Ingredients", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        filterModal.toggle()
                    }
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("Clear") {
                        Array(modelData.ingredients.enumerated()).forEach { (index, ingredient) in
                            modelData.ingredients[index].isSelected = false
                        }
                    }
                    Spacer()
                    Button("Select All") {
                        Array(modelData.ingredients.enumerated()).forEach { (index, ingredient) in
                            modelData.ingredients[index].isSelected = true
                        }
                    }
                }
            }
        }
    }
}
