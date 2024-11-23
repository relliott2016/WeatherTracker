//
//  WeatherAPIClient.swift
//  WeatherTracker
//
//  Created by Robbie Elliott on 2024-11-23.
//

import Foundation

enum Endpoints {
    static let baseURL = "https://api.weatherapi.com/v1"
    static let search = baseURL + "/search.json"
    static let current = baseURL + "/current.json"
}

struct WeatherAPIClient: WeatherAPIClientProtocol {
    func searchCity(_ query: String) async throws -> [CitySearchResult] {
        // Check for connectivity
        guard await NetworkMonitor.shared.checkConnection() else {
            throw WeatherError.network(.noConnection)
        }

        guard let apiKey = Config.weatherAPIKey else {
            throw WeatherError.network(.noAPIKey)
        }

        var components = URLComponents(string: Endpoints.search)!
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: query)
        ]

        guard let url = components.url else {
            throw WeatherError.serverError
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw WeatherError.serverError
            }

            return try JSONDecoder().decode([CitySearchResult].self, from: data)
        } catch let error as NSError {
            if error.domain == NSURLErrorDomain {
                switch error.code {
                case NSURLErrorNotConnectedToInternet:
                    throw WeatherError.network(.noConnection)
                default:
                    throw WeatherError.serverError
                }
            }
            throw WeatherError.invalidData
        }
    }

    func fetchWeather(latitude: Double, longitude: Double) async throws -> WeatherResponse {
        // Check for connectivity
        guard await NetworkMonitor.shared.checkConnection() else {
            throw WeatherError.network(.noConnection)
        }

        guard let apiKey = Config.weatherAPIKey else {
            throw WeatherError.serverError
        }

        var components = URLComponents(string: Endpoints.current)!
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: "\(latitude),\(longitude)"),
            URLQueryItem(name: "aqi", value: "no")
        ]

        guard let url = components.url else {
            throw WeatherError.serverError
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw WeatherError.serverError
            }

            struct APIResponse: Codable {
                let current: Current

                struct Current: Codable {
                    let temp_c: Double
                    let condition: Condition
                    let humidity: Int
                    let uv: Double
                    let feelslike_c: Double

                    struct Condition: Codable {
                        let text: String
                        let icon: String
                    }
                }
            }

            let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
            let iconUrl = apiResponse.current.condition.icon
            let fullIconUrl = iconUrl.hasPrefix("http") ? iconUrl : "https:" + iconUrl
            return WeatherResponse(
                temperature: apiResponse.current.temp_c,
                condition: apiResponse.current.condition.text,
                conditionIcon: URL(string: fullIconUrl)!,
                humidity: apiResponse.current.humidity,
                uvIndex: apiResponse.current.uv,
                feelsLike: apiResponse.current.feelslike_c
            )
        } catch let error as NSError {
            if error.domain == NSURLErrorDomain {
                switch error.code {
                case NSURLErrorNotConnectedToInternet:
                    throw WeatherError.network(.noConnection)
                default:
                    throw WeatherError.serverError
                }
            }
            throw WeatherError.invalidData
        }
    }
}
