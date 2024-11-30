//
//  WeatherAPIClientProtocol.swift
//  WeatherTracker
//
//  Created by Robbie Elliott on 2024-11-23.
//

import Foundation

protocol WeatherAPIClientProtocol {
    func searchCity(_ query: String) async throws -> [CitySearchResult]
    func fetchWeather(latitude: Double, longitude: Double) async throws -> WeatherResponse
}
