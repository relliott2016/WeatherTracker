//
//  WeatherTrackerApp.swift
//  WeatherTracker
//
//  Created by Robbie Elliott on 2024-11-23.
//

import SwiftUI
import SwiftData

@main
struct WeatherTrackerApp: App {
    let sharedModelContainer: ModelContainer = {
        let schema = Schema([
            WeatherCity.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    let weatherClient: WeatherAPIClient = WeatherAPIClient()

    var body: some Scene {
        WindowGroup {
            AppView(
                weatherClient: weatherClient,
                modelContainer: sharedModelContainer
            )
        }
    }
}
