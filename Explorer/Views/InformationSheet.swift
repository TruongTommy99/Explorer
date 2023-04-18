//
//  InformationSheet.swift
//  Explorer
//
//  Created by Tommy Phat Nhu Truong on 4/12/23.
//

import SwiftUI
import CoreLocation
import WebKit

struct InformationSheet: View {
    @State var currentSuggestedLocation: SuggestedLocation
    
    
    @StateObject var weatherViewModel = WeatherViewModel()
    
    private let urlString = "https://www.google.com/search?q=flights+to+"
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue,.blue,.cyan]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Text(currentSuggestedLocation.name)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                if let data = weatherViewModel.data {
                    Text(data.currentWeather.temperature.formatted())
                        .font(.title2)
                        .foregroundColor(.white)
                    Text(data.currentWeather.condition.description)
                        .foregroundColor(.white)
                    
                    // Daily Forecast
                    VStack(alignment: .leading) {
                        Label("Hourly Forecast", systemImage: "clock")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(8)
                        Divider()
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(weatherViewModel.hourlyForecast,id :\.date) { forecast in
                                    VStack() {
                                        Text( (forecast == weatherViewModel.hourlyForecast[0]) ? "Now" : DateFormatter.localizedString(from: forecast.date, dateStyle: .none, timeStyle: .short))
                                            .font(.caption)
                                        Image(systemName: "\(forecast.symbolName)")
                                            .scaledToFit()
                                            .symbolRenderingMode(.monochrome)
                                            .frame(height: 40)
                                        Text(forecast.temperature.formatted())
                                            .fontWeight(.medium)
                                    }
                                    .padding(6)
                                }
                            }
                        }
                        // Weekly Forecast
                    }
                    .foregroundColor(.white)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8,style: .circular))
                    .padding(6)
                    NavigationLink("See more information") {
                            DetailedInformationSheet()
                    }
                    Link("Go to ", destination: URL(string: (urlString + currentSuggestedLocation.name.replacingOccurrences(of: " ", with: "+")).trimmingCharacters(in: .whitespaces))!)
                }
                else {
                    ProgressView()
                    }
                }
        }
        .onAppear {
            weatherViewModel.getWeather(for: CLLocation(latitude: currentSuggestedLocation.coordinate.latitude, longitude: currentSuggestedLocation.coordinate.longitude))
        }
    }
}

struct InformationSheet_Previews: PreviewProvider {
    static var previews: some View {
        InformationSheet(currentSuggestedLocation: SuggestedLocation.sampleLocations[0])
    }
}

