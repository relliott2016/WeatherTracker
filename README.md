# WeatherTracker

## Description
WeatherTracker is an iOS weather application built with Swift and SwiftUI that provides real-time weather information. The app features a clean, intuitive interface that displays comprehensive weather data for a selected city, including temperature, weather conditions, humidity, UV index, and "feels like" temperature.

## Installation
1. Clone the repository
2. Open `WeatherTracker.xcodeproj` in Xcode
3. In Xcode, update the Signing & Capabilities settings to use your own development team
4. Build and run the project on your device or simulator.

## Usage
- Launch the app to view weather information for your saved city
- Use the search bar to find a new city
- Tap on a search result to update your primary city
- Weather data for your selected city will automatically load each time you open the app

## Features
- Real-time weather data from WeatherAPI.com
- Current temperature and weather conditions with icons
- Detailed weather metrics (humidity, UV index, feels like temperature)
- City search functionality with scrollable results and error handling for invalid cities
- SwiftData integration for persistent city storage
- User-friendly onboarding prompts for initial city selection
- Pull-to-refresh functionality for updating weather data
- Network connectivity monitoring with appropriate user alerts for offline scenarios

## Technical Notes
- Search results include placeholder weather icons and temperature values to maintain a consistent user interface, as these data points are not available in the search endpoint of the WeatherAPI.

## License

This project is licensed under the MIT License - see the [MIT License](LICENSE) file for details.
