//
//  MockWeatherAPIClient.swift
//  WeatherTracker
//
//  Created by Robbie Elliott on 2024-11-23.
//

import Foundation

// Mock for Previews testing
class MockWeatherAPIClient: WeatherAPIClientProtocol {
    var searchCityResult: [CitySearchResult] = []
    var currentWeather: WeatherResponse?
    var shouldThrowError = false

    func searchCity(_ query: String) async throws -> [CitySearchResult] {
        if shouldThrowError { throw NetworkError.invalidResponse }
        return searchCityResult
    }

    func fetchWeather(latitude: Double, longitude: Double) async throws -> WeatherResponse {
        if shouldThrowError { throw NetworkError.invalidResponse }
        return currentWeather ?? WeatherResponse(
            temperature_c: 25.0,
            temperature_f: 77.0,
            condition: "Sunny",
            conditionIcon: URL(string: "https://example.com/sunny.png")!,
            humidity: 60,
            uvIndex: 5.0,
            feelsLike_c: 26.0,
            feelsLike_f: 79.0
        )
    }
}
