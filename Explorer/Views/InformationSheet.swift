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
    var currentSuggestedLocation: SuggestedLocation
    
    @StateObject var weatherViewModel = WeatherViewModel()
    
    let now = Date.now
    
    var body: some View {
        ScrollView {
            VStack {
                Text(currentSuggestedLocation.name)
                    .bold()
                    .font(.largeTitle)
                if let data = weatherViewModel.data {
                    if now < data.currentWeather.date {
                        Text(data.currentWeather.date.formatted())
                        Text("You are currently behind by \(Calendar.current.dateComponents([.hour], from: now, to: data.currentWeather.date))")
                    }
                    else {
                        Text(data.currentWeather.date.formatted())
                        Text("You are currently ahead by \(Calendar.current.dateComponents([.hour], from: now, to: data.currentWeather.date))")

                    }
                }
                
                else {
                    ProgressView()
                        .progressViewStyle(.circular)
                }

            }
            .onAppear {
                weatherViewModel.getWeather(for: CLLocation(latitude: currentSuggestedLocation.coordinate.latitude, longitude: currentSuggestedLocation.coordinate.longitude))
                
        }
        }
    }
}

struct InformationSheet_Previews: PreviewProvider {
    static var previews: some View {
        InformationSheet(currentSuggestedLocation: SuggestedLocation.sampleLocations[0])
    }
}

