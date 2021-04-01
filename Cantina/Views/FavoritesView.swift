//
//  FavoritesView.swift
//  Cantina
//
//  Created by Andrew Davis on 4/1/21.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        NavigationView {
            Text("Favorites")
                .navigationBarTitle("Favorites")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
