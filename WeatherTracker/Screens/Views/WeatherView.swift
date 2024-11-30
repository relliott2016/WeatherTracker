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
    @State private var isCelsius = true

    var temperatures: (actual: Double, feelsLike: Double) {
        guard let weather = weather else { return (0.0, 0.0) }
        return isCelsius ? (weather.temperature_c, weather.feelsLike_c): (weather.temperature_f, weather.feelsLike_f)
    }

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 40)

            VStack(spacing: 0) {
                // Weather Icon
                if let weather {
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
                    Text("\(Int(round(temperatures.actual)))°")
                        .font(.system(size: 80, weight: .medium))
                }
                .padding(.bottom, 32)
            }
            .padding(.bottom, 32)

            if let weather {
                WeatherStatsView(
                    humidity: Int(weather.humidity),
                    uvIndex: Int(weather.uvIndex),
                    feelsLike: Int(round(temperatures.feelsLike))
                )
                .frame(width: 300)
                .padding(.bottom, 32)
            }

            Toggle(isOn: $isCelsius) {
                Text(isCelsius ? "Celsius" : "Fahrenheit")
                    .font(.system(size: 14))
            }
            .toggleStyle(SwitchToggleStyle(tint: Color.blue.opacity(0.8)))
            .frame(width: 150)
            .background(RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.1)))

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
        temperature_c: 15.0,
        temperature_f: 59.0,
        condition: "Partly cloudy",
        conditionIcon: URL(string: "https://example.com/icon.png")!,
        humidity: 75,
        uvIndex: 4.0,
        feelsLike_c: 16.0,
        feelsLike_f: 61.0
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
        temperature_c: 15.0,
        temperature_f: 59.0,
        condition: "Partly cloudy",
        conditionIcon: URL(string: "https://example.com/icon.png")!,
        humidity: 75,
        uvIndex: 4.0,
        feelsLike_c: 16.0,
        feelsLike_f: 61.0
    )

    WeatherView(city: mockCity, weather: mockWeather)
        .modelContainer(container)
        .preferredColorScheme(.dark)
}
