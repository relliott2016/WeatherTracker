# WeatherTracker

## Description
WeatherTracker is an iOS weather application built with Swift and SwiftUI that provides real-time weather information. The app features a clean, intuitive interface that displays comprehensive weather data for a selected city, including temperature, weather conditions, humidity, UV index, "feels like" temperature and a Celsius / Fahrenheit picker.

## Installation
1. Clone the repository
2. Obtain an API key from WeatherAPI:
   - Create an account at [WeatherAPI.com](https://www.weatherapi.com) if you don't have one.
   - Select the My Account tab and copy your key, or generate a new key.
4. Add the API key to the project:
   - Open `WeatherTracker.xcodeproj` in Xcode.
   - Select the WeatherTracker target in the project navigator.
   - In the editor view select the info tab and open the Custom iOS Target Properties section.
   - Locate the WEATHERAPI_KEY entry and replace the ADD_WEATHERAPI_KEY_HERE placeholder value with your key.
5. In the editor view select the Signing & Capabilities tab to add your own development team
6. Build and run the project on your device or simulator.

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
- Celsius / Fahrenheit picker
- Swift Testing test cases

## License

This project is licensed under the MIT License - see the [MIT License](LICENSE) file for details.

## Screenshots

<img src="https://github.com/relliott2016/WeatherTracker/blob/master/Screenshots/Welcome.png" width=30% height=30%>          <img src="https://github.com/relliott2016/WeatherTracker/blob/master/Screenshots/EmptyState.png" width=30% height=30%>          <img src="https://github.com/relliott2016/WeatherTracker/blob/master/Screenshots/NoSearchResults.png" width=30% height=30%> <img src="https://github.com/relliott2016/WeatherTracker/blob/master/Screenshots/SearchResults.png" width=30% height=30%> <img src="https://github.com/relliott2016/WeatherTracker/blob/master/Screenshots/City_Celsius.png" width=30% height=30%> <img src="https://github.com/relliott2016/WeatherTracker/blob/master/Screenshots/City_Fahrenheit.png" width=30% height=30%> <img src="https://github.com/relliott2016/WeatherTracker/blob/master/Screenshots/NoInternet.png" width=30% height=30%>