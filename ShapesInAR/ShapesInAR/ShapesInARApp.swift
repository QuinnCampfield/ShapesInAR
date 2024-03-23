//
//  ShapesInARApp.swift
//  ShapesInAR
//
//  Created by Quinn C on 3/23/24.
//

import SwiftUI

@main
struct ShapesInARApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ARViewController.shared)
        }
    }
}
