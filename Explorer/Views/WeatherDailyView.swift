//
//  WeatherDailyView.swift
//  Explorer
//
//  Created by Tommy Truong on 4/18/23.
//

import SwiftUI

struct WeatherDailyView: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    
    @State var currentSuggestedLocation: SuggestedLocation
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.7),.cyan.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Text(currentSuggestedLocation.name)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                if let data = weatherViewModel.data {
                    Text(data.currentWeather.temperature.description.replacingOccurrences(of: "C", with: ""))
                        .font(.title2)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Text(data.currentWeather.condition.description)
                        .foregroundColor(.white)
//                            Text("current time is \(Date.now.formatted()) and the time there is \(data.currentWeather.metadata.date.formatted())")
//                            Text("You are \(data.currentWeather.date > Date.now ? "ahead": "behind") ")
                    
                    // Daily Forecast
                    VStack(alignment: .leading) {
                        Label("Hourly Forecast", systemImage: "clock")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(8)
                        Divider()
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(weatherViewModel.hourlyForecastList,id :\.date) { forecast in
                                    VStack() {
                                        Text( (forecast == weatherViewModel.hourlyForecastList[0]) ? "Now" : DateFormatter.localizedString(from: forecast.date, dateStyle: .none, timeStyle: .short).replacingOccurrences(of: "PM", with: "").replacingOccurrences(of: "AM", with: "").replacingOccurrences(of: ":00", with: ""))
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                        Image(systemName: "\(forecast.symbolName).fill")
                                            .scaledToFit()
                                            .symbolRenderingMode(.multicolor)
                                            .frame(height: 40)
                                        Text(forecast.temperature.formatted().replacingOccurrences(of: "F", with: ""))
                                            .fontWeight(.medium)
                                    }
                                    .padding(2)
                                }
                            }
                        }
                        // Weekly Forecast
                    }
                    .foregroundColor(.white)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8,style: .circular))
                    .padding(6)
                }
                else {
                    ProgressView()
                }
            }
        }
        .cornerRadius(8)
        .padding()
    }
}

//struct WeatherDailyView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherDailyView( currentSuggestedLocation: <#SuggestedLocation#>)
//    }
//}
