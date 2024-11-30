//
//  WeatherError.swift
//  WeatherTracker
//
//  Created by Robbie Elliott on 2024-11-23.
//

import Foundation

enum WeatherError: LocalizedError {
    case network(NetworkError)
    case invalidData
    case serverError

    var errorDescription: String? {
        switch self {
        case .network(let networkError):
            return networkError.errorDescription
        case .invalidData:
            return "Unable to process the weather data"
        case .serverError:
            return "Unable to reach the weather service"
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .network(let networkError):
            switch networkError {
            case .noConnection:
                return "Please check your internet connection and try again"
            case .noAPIKey:
                return "Add your WeatherAPI key to the project"
            default:
                return "Please try again later"
            }
        case .invalidData:
            return "Please try again"
        case .serverError:
            return "Please try again later"
        }
    }

    var errorTitle: String {
        switch self {
        case .network(let networkError):
            switch networkError {
            case .noConnection:
                return "No Internet Connection"
            case . noAPIKey:
                return "No API Key"
            default:
                return "Network Error"
            }
        case .invalidData, .serverError:
            return "Error"
        }
    }
}
