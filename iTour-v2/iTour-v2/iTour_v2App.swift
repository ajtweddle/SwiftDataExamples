//
//  iTour_v2App.swift
//  iTour-v2
//
//  Created by Allan Tweddle on 19/12/2023.
//

import SwiftData
import SwiftUI

@main
struct iTour_v2App: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Label("Destinations", systemImage: "map")
                    }

                SightsView()
                    .tabItem {
                        Label("Sights", systemImage: "mappin.and.ellipse")
                    }
            }
        }
        .modelContainer(for: Destination.self)
    }
}
