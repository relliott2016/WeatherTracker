//
//  CitySearchResult.swift
//  WeatherTracker
//
//  Created by Robbie Elliott on 2024-11-23.
//

import Foundation

struct CitySearchResult: Codable, Identifiable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double

    var latitude: Double { lat }
    var longitude: Double { lon }

    func toWeatherCity() -> WeatherCity {
        WeatherCity(
            name: name,
            region: region,
            country: country,
            latitude: latitude,
            longitude: longitude
        )
    }
}
