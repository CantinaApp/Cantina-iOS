//
//  FilterModal.swift
//  Cantina
//
//  Created by Raymond Truong on 4/19/21.
//

import SwiftUI

struct FilterModal: View {
    
    var ingredients = (0...60).map{"Ingredient #\($0)"}
    
    var body: some View {
        List(ingredients, id: \.self) { ingredient in
            HStack {
                Text(ingredient)
                Spacer()
                Image(systemName: "checkmark")
                    .foregroundColor(Color.blue)
            }
        }
    }
}
