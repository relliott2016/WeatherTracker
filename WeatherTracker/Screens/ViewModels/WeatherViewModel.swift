//
//  WeatherViewModel.swift
//  WeatherTracker
//
//  Created by Robbie Elliott on 2024-11-23.
//

import Foundation
import SwiftData
import Observation

@Observable
@MainActor
final class WeatherViewModel {
    var currentCity: WeatherCity?
    var currentWeather: WeatherResponse?
    var searchResults: [WeatherCity] = []
    var isLoading = false
    var error: WeatherError?

    private let weatherClient: any WeatherAPIClientProtocol
    private let modelContainer: ModelContainer

    init(weatherClient: any WeatherAPIClientProtocol, modelContainer: ModelContainer) {
        self.weatherClient = weatherClient
        self.modelContainer = modelContainer
        loadSavedCity()
    }

    private func loadSavedCity() {
        do {
            let descriptor = FetchDescriptor<WeatherCity>()
            let cities = try modelContainer.mainContext.fetch(descriptor)
            currentCity = cities.first
            if let city = currentCity {
                Task {
                    await fetchWeatherForCity(city)
                }
            }
        } catch {
            self.error = .invalidData
        }
    }

    func searchCity(_ query: String) async {
        guard !query.isEmpty else {
            searchResults = []
            return
        }

        isLoading = true
        error = nil
        // Clear search results before attempting the search
        searchResults = []

        do {
            let results = try await weatherClient.searchCity(query)
            // Only update searchResults if we successfully get data from the API
            searchResults = results.map { result in
                WeatherCity(
                    name: result.name,
                    region: result.region,
                    country: result.country,
                    latitude: result.latitude,
                    longitude: result.longitude
                )
            }
        } catch {
            if let weatherError = error as? WeatherError {
                self.error = weatherError
            } else {
                self.error = .serverError
            }
        }

        isLoading = false
    }

    func selectCity(_ city: WeatherCity) async {
        do {
            // Clear existing cities
            let descriptor = FetchDescriptor<WeatherCity>()
            let existingCities = try modelContainer.mainContext.fetch(descriptor)
            existingCities.forEach { modelContainer.mainContext.delete($0) }

            // Save new city
            modelContainer.mainContext.insert(city)
            try modelContainer.mainContext.save()

            currentCity = city
            await fetchWeatherForCity(city)

            // Clear search results after selection
            searchResults = []
        } catch {
            self.error = .invalidData
        }
    }

    private func fetchWeatherForCity(_ city: WeatherCity) async {
        isLoading = true
        error = nil

        do {
            let weather = try await weatherClient.fetchWeather(
                latitude: city.latitude,
                longitude: city.longitude
            )

            // Update persistent weather data
            city.lastTemperature_c = weather.temperature_c
            city.lastTemperature_f = weather.temperature_f
            city.lastCondition = weather.condition
            city.lastConditionIcon = weather.conditionIcon
            city.lastHumidity = weather.humidity
            city.lastUvIndex = weather.uvIndex
            city.lastFeelsLike_c = weather.feelsLike_c
            city.lastFeelsLike_f = weather.feelsLike_f
            city.lastUpdated = Date()

            try modelContainer.mainContext.save()

            currentWeather = weather
        } catch {
            if let weatherError = error as? WeatherError {
                self.error = weatherError
            } else {
                self.error = .serverError
            }
        }

        isLoading = false
    }

    func refreshWeather() async {
        guard let city = currentCity else { return }
        await fetchWeatherForCity(city)
    }
}
