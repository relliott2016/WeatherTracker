//
//  WeatherResponse.swift
//  WeatherTracker
//
//  Created by Robbie Elliott on 2024-11-23.
//

import Foundation

struct WeatherResponse: Codable {
    let temperature: Double
    let condition: String
    let conditionIcon: URL
    let humidity: Int
    let uvIndex: Double
    let feelsLike: Double
}
