//
//  SearchResultView.swift
//  WeatherTracker
//
//  Created by Robbie Elliott on 2024-11-23.
//

import SwiftUI

struct CitySearchResultsView: View {
   let cityName: String
   let region: String
   let country: String

   var body: some View {
       HStack(alignment: .center, spacing: 16) {
           VStack(alignment: .leading, spacing: 8) {
               Text(cityName)
                   .font(.system(size: 22, weight: .bold))
                   .foregroundColor(.primary)
               Text(region)
                   .font(.system(size: 18, weight: .regular))
                   .foregroundColor(.primary)
               Text(country)
                   .font(.system(size: 18, weight: .regular))
                   .foregroundColor(.primary)
           }
           .padding(.top, 8)
           Spacer()
           Image("Weather")
               .resizable()
               .aspectRatio(contentMode: .fit)
               .frame(width: 64, height: 64)
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
            cityName: "Holborn",
            region: "Camden Greater London",
            country: "United Kingdom"
        )
        CitySearchResultsView(
            cityName: "Oshawa",
            region: "Ontario",
            country: "Canada"
        )
    }
    .padding()
    .background(Color(.systemBackground))
}
