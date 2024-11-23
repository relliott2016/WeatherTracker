//
//  WeatherStatsView.swift
//  WeatherTracker
//
//  Created by Robbie Elliott on 2024-11-23.
//

import SwiftUI

struct WeatherStatsView: View {
    let humidity: Int
    let uvIndex: Int
    let feelsLike: Int

    var body: some View {
        HStack {
            StatItemView(
                title: "Humidity",
                value: "\(humidity)%"
            )

            Divider()
                .frame(height: 24)

            StatItemView(
                title: "UV",
                value: "\(uvIndex)"
            )

            Divider()
                .frame(height: 24)

            StatItemView(
                title: "Feels like",
                value: "\(feelsLike)°"
            )
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 20)
        .frame(width: 300)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemGray6))
        }
    }
}

private struct StatItemView: View {
    let title: String
    let value: String

    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.system(size: 13))
                .foregroundColor(.secondary.opacity(0.9))

            Text(value)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(.secondary.opacity(0.9))
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Previews
#Preview("Weather Stats") {
    VStack {
        WeatherStatsView(
            humidity: 20,
            uvIndex: 4,
            feelsLike: 38
        )
    }
    .padding()
}

#Preview("Dark Mode") {
    WeatherStatsView(
        humidity: 20,
        uvIndex: 4,
        feelsLike: 38
    )
    .padding()
    .preferredColorScheme(.dark)
}
