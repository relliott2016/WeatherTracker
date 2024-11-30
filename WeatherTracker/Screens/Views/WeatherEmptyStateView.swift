//
//  EmptyStateView.swift
//  WeatherTracker
//
//  Created by Robbie Elliott on 2024-11-23.
//

import SwiftUI

struct WeatherEmptyStateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("No City Selected")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(Color.textPrimary)

            Text("Please Search For A City")
                .font(.body)
                .foregroundStyle(Color.textSecondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.backgroundPrimary)
    }
}

#Preview {
    WeatherEmptyStateView()
        .preferredColorScheme(.dark)
}
