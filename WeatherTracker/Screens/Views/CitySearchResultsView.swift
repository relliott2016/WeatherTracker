//
//  SearchResultView.swift
//  WeatherTracker
//
//  Created by Robbie Elliott on 2024-11-23.
//

import SwiftUI

struct CitySearchResultsView: View {
    let cityName: String
    let temperature: Double
    let conditionIcon: URL

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text(cityName)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.primary)

                HStack(alignment: .top, spacing: 0) {
                    Text("°")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(.primary)
                        .padding(.top, 8)
                    Text("\(Int(temperature))")
                        .font(.system(size: 64, weight: .regular))
                        .foregroundColor(.primary)
                }
            }
            .padding(.top, 8)

            Spacer()

            // Weather condition icon
            AsyncImage(url: conditionIcon) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
            } placeholder: {
                Image(systemName: "cloud")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 4)
        .frame(maxWidth: 350)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemGray6))
        }
        .contentShape(Rectangle())
    }
}

#Preview("Search Result") {
    VStack(spacing: 12) {
        CitySearchResultsView(
            cityName: "Mumbai, India",
            temperature: 20,
            conditionIcon: URL(string: "https://cdn.weatherapi.com/weather/64x64/day/113.png")!
        )
        CitySearchResultsView(
            cityName: "Mumbai, Maharashtra, India",
            temperature: 22,
            conditionIcon: URL(string: "https://cdn.weatherapi.com/weather/64x64/day/113.png")!
        )
    }
    .padding()
    .background(Color(.systemBackground))
}
