//
//  WeatherView.swift
//  WeatherTracker
//
//  Created by Robbie Elliott on 2024-11-23.
//

import SwiftUI
import SwiftData

struct WeatherView: View {
    let city: WeatherCity
    let weather: WeatherResponse?

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 40)

            VStack(spacing: 0) {
                // Weather Icon
                if let weather = weather {
                    AsyncImage(url: weather.conditionIcon) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        case .failure(_):
                            Image(systemName: "cloud.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        case .empty:
                            ProgressView()
                        @unknown default:
                            Image(systemName: "cloud.fill")
                        }
                    }
                    .frame(width: 200, height: 200)
                    .padding(.bottom, -8)
                } else {
                    Image(systemName: "cloud.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 240, height: 240)
                        .padding(.bottom, -8)
                }

                VStack(spacing: 4) {
                    HStack(spacing: 8) {
                        Text(city.name)
                            .font(.system(size: 34, weight: .semibold))

                        Image(systemName: "location.north.fill")
                            .rotationEffect(.degrees(45))
                            .font(.system(size: 24))
                    }

                    // Temperature
                    Text("\(Int(round(weather?.temperature ?? 0)))°")
                        .font(.system(size: 80, weight: .medium))
                }
                .padding(.bottom, 32)
            }

            if let weather = weather {
                WeatherStatsView(
                    humidity: Int(weather.humidity),
                    uvIndex: Int(weather.uvIndex),
                    feelsLike: Int(round(weather.feelsLike))
                )
                .frame(width: 300)
            }

            Spacer()
        }
    }
}

#Preview("Weather View") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: WeatherCity.self, configurations: config)
    let mockCity = WeatherCity(
        name: "San Francisco",
        region: "California",
        country: "USA",
        latitude: 37.7749,
        longitude: -122.4194
    )

    WeatherView(city: mockCity, weather: nil)
        .modelContainer(container)
}

#Preview("Weather View with Data") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: WeatherCity.self, configurations: config)
    let mockCity = WeatherCity(
        name: "San Francisco",
        region: "California",
        country: "USA",
        latitude: 37.7749,
        longitude: -122.4194
    )
    let mockWeather = WeatherResponse(
        temperature: 18.0,
        condition: "Partly cloudy",
        conditionIcon: URL(string: "https://example.com/icon.png")!,
        humidity: 75,
        uvIndex: 4.0,
        feelsLike: 16.0
    )

    WeatherView(city: mockCity, weather: mockWeather)
        .modelContainer(container)
}

#Preview("Dark Mode") {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: WeatherCity.self, configurations: config)
    let mockCity = WeatherCity(
        name: "San Francisco",
        region: "California",
        country: "USA",
        latitude: 37.7749,
        longitude: -122.4194
    )
    let mockWeather = WeatherResponse(
        temperature: 18.0,
        condition: "Clear",
        conditionIcon: URL(string: "https://example.com/icon.png")!,
        humidity: 75,
        uvIndex: 4.0,
        feelsLike: 16.0
    )

    WeatherView(city: mockCity, weather: mockWeather)
        .modelContainer(container)
        .preferredColorScheme(.dark)
}
