//
//  ContentView.swift
//  WeatherTracker
//
//  Created by Robbie Elliott on 2024-11-23.
//

import SwiftUI
import SwiftData

struct AppView: View {
    let viewModel: WeatherViewModel
    @State private var searchText = ""
    @State private var showNoResultsAlert = false
    @State private var showNetworkErrorAlert = false
    @State private var showInitialPromptAlert = false
    @State private var isErrorAlertPresented = false
    @FocusState private var isSearchFocused: Bool
    @Environment(\.verticalSizeClass) private var verticalSizeClass

    init(weatherClient: any WeatherAPIClientProtocol, modelContainer: ModelContainer) {
        self.viewModel = WeatherViewModel(
            weatherClient: weatherClient,
            modelContainer: modelContainer
        )
    }

    private var errorAlertTitle: String {
        viewModel.error?.errorTitle ?? "Error"
    }

    private var errorAlertMessage: String {
        if let error = viewModel.error {
            return [error.errorDescription, error.recoverySuggestion]
                .compactMap { $0 }
                .joined(separator: ". ")
        }
        return ""
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                searchBar
                    .safeAreaPadding(.top)

                if !viewModel.searchResults.isEmpty {
                    Spacer()
                        .frame(height: 32)

                    ScrollView(showsIndicators: false) {
                        searchResults
                    }
                } else {
                    ScrollView(showsIndicators: false) {
                        mainContent
                            .frame(minHeight: geometry.size.height - (verticalSizeClass == .compact ? 0 : 100))
                    }
                    .refreshable {
                        try? await Task.sleep(for: .milliseconds(500))
                        await viewModel.refreshWeather()
                        if viewModel.error != nil {
                            isErrorAlertPresented = true
                        }
                    }
                }
            }
        }
        .animation(.easeInOut, value: viewModel.currentCity)
        .animation(.easeInOut, value: viewModel.searchResults)
        .alert("No cities found", isPresented: $showNoResultsAlert) {
            Button("OK") {
                showNoResultsAlert = false
                isSearchFocused = true
            }
        } message: {
            Text("Please try a different search term")
        }
        .alert(errorAlertTitle, isPresented: .init(
            get: { viewModel.error != nil },
            set: { if !$0 { viewModel.error = nil } }
        )) {
            Button("OK") {
                viewModel.error = nil
            }
        } message: {
            Text(errorAlertMessage)
        }
        .alert("Welcome to WeatherTracker", isPresented: $showInitialPromptAlert) {
            Button("OK") {
                showInitialPromptAlert = false
                isSearchFocused = true
            }
        } message: {
            Text("Search for a city to get started")
        }
        .onAppear {
            if viewModel.currentCity == nil {
                showInitialPromptAlert = true
            }
        }
    }

    private var searchBar: some View {
        HStack {
            TextField("Search Location", text: $searchText)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .font(.system(size: 17))
                .focused($isSearchFocused)
                .onSubmit {
                    Task {
                        await viewModel.searchCity(searchText)
                        if viewModel.searchResults.isEmpty && !searchText.isEmpty && viewModel.error == nil {
                            showNoResultsAlert = true
                        }
                    }
                }

            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .font(.system(size: 17))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemGray6))
        }
        .padding(.horizontal, 24)
    }

    private var mainContent: some View {
        Group {
            if viewModel.isLoading && viewModel.currentCity != nil {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let currentCity = viewModel.currentCity {
                WeatherView(
                    city: currentCity,
                    weather: viewModel.currentWeather
                )
            } else {
                WeatherEmptyStateView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }

    private var searchResults: some View {
        LazyVStack(spacing: 12) {
            ForEach(viewModel.searchResults) { city in
                CitySearchResultsView(
                    cityName: "\(city.name)",
                    region: "\(city.region)",
                    country: "\(city.country)"
                )
                .onTapGesture {
                    Task {
                        await viewModel.selectCity(city)
                        searchText = ""
                        isSearchFocused = false
                    }
                }
            }
        }
    }
}

#Preview("Empty State") {
    AppView(
        weatherClient: MockWeatherAPIClient(),
        modelContainer: try! ModelContainer(
            for: WeatherCity.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
    )
}

#Preview("With City") {
    let mockClient = MockWeatherAPIClient()

    AppView(
        weatherClient: mockClient,
        modelContainer: try! ModelContainer(
            for: WeatherCity.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
    )
}

#Preview("Dark Mode") {
    AppView(
        weatherClient: MockWeatherAPIClient(),
        modelContainer: try! ModelContainer(
            for: WeatherCity.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
    )
    .preferredColorScheme(.dark)
}
