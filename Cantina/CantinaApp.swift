//
//  CantinaApp.swift
//  Cantina
//
//  Created by Andrew Davis on 3/11/21.
//

import SwiftUI

@main
struct CantinaApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
