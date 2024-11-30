//
//  WeatherCity.swift
//  WeatherTracker
//
//  Created by Robbie Elliott on 2024-11-23.
//

import Foundation
import SwiftData

@Model
class WeatherCity {
    var name: String
    var region: String
    var country: String
    var latitude: Double
    var longitude: Double

    @Attribute(.externalStorage)
    var lastConditionIcon: URL?
    var lastTemperature_c: Double?
    var lastTemperature_f: Double?
    var lastCondition: String?
    var lastHumidity: Int?
    var lastUvIndex: Double?
    var lastFeelsLike_c: Double?
    var lastFeelsLike_f: Double?
    var lastUpdated: Date?

    init(
        name: String,
        region: String,
        country: String,
        latitude: Double,
        longitude: Double
    ) {
        self.name = name
        self.region = region
        self.country = country
        self.latitude = latitude
        self.longitude = longitude
    }
}
