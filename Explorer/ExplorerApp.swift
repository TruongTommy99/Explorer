//
//  ExplorerApp.swift
//  Explorer
//
//  Created by Tommy Truong on 4/10/23.
//

import SwiftUI
import MapKit

@main
struct ExplorerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(currentSuggestedLocation: SuggestedLocation.initialGlobe,hasLookAroundScene: false, mapConfigurations: MapConfigurations() )
        }
    }
}
