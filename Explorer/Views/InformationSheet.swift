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
    
    var body: some View {
        VStack {
            Text(currentSuggestedLocation.name)
                .bold()
                .font(.largeTitle)
            if let data = weatherViewModel.data {

                Text(data.currentWeather.date.description)
                Text(data.currentWeather.temperature.formatted())
                Text(data.minuteForecast?.summary ?? "")
                Text(data.hourlyForecast.forecast.description)
                Text(data.dailyForecast.forecast.description)

//                Chart(data)
            }
            else {
                Text("There is currently no available information about this location")
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
