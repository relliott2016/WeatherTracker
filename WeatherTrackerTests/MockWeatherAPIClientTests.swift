//
//  MockWeatherAPIClientTests.swift
//  WeatherTracker
//
//  Created by Robbie Elliott on 2024-11-26.
//

import Testing
import Foundation
import SwiftUI
@testable import WeatherTracker

@Suite("MockWeatherAPIClient Tests")
struct MockWeatherAPIClientTests {
    @Test("Search city returns expected results")
    func testSearchCity() async throws {
        let client = MockWeatherAPIClient()
        // Explicitly use WeatherTracker namespace
        let expectedResults: [WeatherTracker.CitySearchResult] = [
            .init(
                id: 1,
                name: "New York",
                region: "New York",
                country: "United States",
                lat: 40.7128,
                lon: -74.0060
            ),
            .init(
                id: 2,
                name: "London",
                region: "Greater London",
                country: "United Kingdom",
                lat: 51.5074,
                lon: -0.1278
            )
        ]
        client.searchCityResult = expectedResults

        let results = try await client.searchCity("New")

        // Instead of comparing arrays directly, compare their properties
        #expect(results.count == expectedResults.count)
        for (result, expected) in zip(results, expectedResults) {
            #expect(result.id == expected.id)
            #expect(result.name == expected.name)
            #expect(result.region == expected.region)
            #expect(result.country == expected.country)
            #expect(result.lat == expected.lat)
            #expect(result.lon == expected.lon)
        }
    }

    @Test("Search city throws error when shouldThrowError is true")
    func testSearchCityError() async throws {
        let client = MockWeatherAPIClient()
        client.shouldThrowError = true

        do {
            _ = try await client.searchCity("Test")
            #expect(Bool(false), "Expected an error to be thrown")
        } catch {
            #expect(error is WeatherTracker.NetworkError, "Expected NetworkError but got \(type(of: error))")
            #expect((error as? WeatherTracker.NetworkError) == .invalidResponse, "Expected invalidResponse error")
        }
    }

    @Test("Fetch weather returns expected weather response")
    func testFetchWeather() async throws {
        let client = MockWeatherAPIClient()
        // Use explicit type annotation
        let expectedResponse: WeatherTracker.WeatherResponse = .init(
            temperature_c: 20.0,
            temperature_f: 68.0,
            condition: "Cloudy",
            conditionIcon: URL(string: "https://example.com/cloudy.png")!,
            humidity: 75,
            uvIndex: 3.0,
            feelsLike_c: 19.0,
            feelsLike_f: 68.0
        )
        client.currentWeather = expectedResponse

        let result = try await client.fetchWeather(latitude: 0, longitude: 0)

        #expect(result.temperature_c == expectedResponse.temperature_c)
        #expect(result.temperature_f == expectedResponse.temperature_f)
        #expect(result.condition == expectedResponse.condition)
        #expect(result.conditionIcon == expectedResponse.conditionIcon)
        #expect(result.humidity == expectedResponse.humidity)
        #expect(result.uvIndex == expectedResponse.uvIndex)
        #expect(result.feelsLike_c == expectedResponse.feelsLike_c)
        #expect(result.feelsLike_f == expectedResponse.feelsLike_f)
    }

    @Test("Fetch weather throws error when shouldThrowError is true")
    func testFetchWeatherError() async throws {
        let client = MockWeatherAPIClient()
        client.shouldThrowError = true

        do {
            _ = try await client.fetchWeather(latitude: 0, longitude: 0)
            #expect(Bool(false), "Expected an error to be thrown")
        } catch let error {
            #expect(error is WeatherTracker.NetworkError, "Expected NetworkError but got \(type(of: error))")
            #expect((error as? WeatherTracker.NetworkError) == .invalidResponse, "Expected invalidResponse error")
        }
    }


    @Test("Fetch weather returns default values when currentWeather is nil")
    func testFetchWeatherDefaults() async throws {
        let client = MockWeatherAPIClient()
        client.currentWeather = nil

        let result = try await client.fetchWeather(latitude: 0, longitude: 0)

        #expect(result.temperature_c == 25.0)
        #expect(result.temperature_f == 77.0)
        #expect(result.condition == "Sunny")
        #expect(result.conditionIcon == URL(string: "https://example.com/sunny.png")!)
        #expect(result.humidity == 60)
        #expect(result.uvIndex == 5.0)
        #expect(result.feelsLike_c == 26.0)
        #expect(result.feelsLike_f == 79.0)
    }
}
