//
//  NetworkError.swift
//  WeatherTracker
//
//  Created by Robbie Elliott on 2024-11-23.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidData
    case noConnection
    case noAPIKey

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid"
        case .invalidResponse:
            return "The server returned an invalid response"
        case .invalidData:
            return "The data received was invalid"
        case .noConnection:
            return "No internet connection available"
        case .noAPIKey:
            return "No API key was found"
        }
    }
}
