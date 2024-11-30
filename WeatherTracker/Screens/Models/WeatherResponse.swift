//
//  WeatherResponse.swift
//  WeatherTracker
//
//  Created by Robbie Elliott on 2024-11-23.
//

import Foundation

struct WeatherResponse: Codable {
    let temperature_c: Double
    let temperature_f: Double
    let condition: String
    let conditionIcon: URL
    let humidity: Int
    let uvIndex: Double
    let feelsLike_c: Double
    let feelsLike_f: Double
}
