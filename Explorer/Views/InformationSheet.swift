//
//  InformationSheet.swift
//  Explorer
//
//  Created by Tommy Phat Nhu Truong on 4/12/23.
//

import SwiftUI
import CoreLocation
import Charts

struct InformationSheet: View {
    @State var currentSuggestedLocation: SuggestedLocation
    
    @StateObject var weatherViewModel = WeatherViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue,.blue,.orange]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Text(currentSuggestedLocation.name)
                    .font(.largeTitle)
                if let data = weatherViewModel.data {

                    Text(data.currentWeather.temperature.formatted())
                        .font(.title2)
                    Text(data.currentWeather.condition.description)
                    
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
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(weatherViewModel.hourlyForecast,id :\.date) { forecast in
                                VStack {
                                    Text(forecast.date.formatted(date: .omitted, time: .omitted))
                                        .bold()
                                    Image(systemName: "\(forecast.symbolName).fill")
                                        .font(.title2)
                                        .symbolRenderingMode(.multicolor)
                                    Text(forecast.temperature.formatted())
                                        .fontWeight(.semibold)
                                }
                            }
                        }
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8,style: .circular))
                        .padding()
                    }
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8,style: .circular))
                    .padding(6)
                    
                    // Weekly Forecast
                }
                else {
                    ProgressView()
                }
            }
                .foregroundColor(.white)

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
