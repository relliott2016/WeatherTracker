//
//  Config.swift
//  WeatherTracker
//
//  Created by Robbie Elliott on 2024-11-23.
//

import Foundation

struct Config {
    static var weatherAPIKey: String? {
        guard let apiKey = Bundle.main.infoDictionary?["WEATHERAPI_KEY"] as? String else {
            print("WEATHERAPI_KEY entry is missing from the Info.plist")
            return nil
        }

        guard apiKey != "ADD_WEATHERAPI_KEY_HERE" else {
            print("You need to replace the WEATHERAPI_KEY placeholder ADD_WEATHERAPI_KEY_HERE with your API key in the Info.plist")
            return nil
        }

        return apiKey
    }
}
