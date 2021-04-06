//
//  FavoriteButton.swift
//  Cantina
//
//  Created by Andrew Davis on 4/6/21.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isFavorited: Bool
    
    func toggleState() {
        isFavorited.toggle()
    }
    
    var body: some View {
        Button(action: toggleState) {
            Image(systemName: isFavorited ? "heart.fill" : "heart")
                .foregroundColor(isFavorited ? Color.red : Color.gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isFavorited: .constant(true))
    }
}
