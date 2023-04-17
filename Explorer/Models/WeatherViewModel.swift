//
//  WeatherViewModel.swift
//  Explorer
//
//  Created by Tommy Phat Nhu Truong on 4/14/23.
//

import Foundation
import WeatherKit
import CoreLocation

class WeatherViewModel: ObservableObject {
    
    @Published var data: Weather?
    
    @Published var hourlyForecast = [HourWeather]()
    
    @Published var tenDayForecast = [DayWeather]()
    
    var service = WeatherService.shared
    
    func getWeather(for location: CLLocation){
        Task(priority: .high) { @MainActor in
            do  {
                let weather = try await service.weather(for: location)
                self.data = weather
                // HOURLY FORECAST
                for i in 0..<60 {
                    if i.isMultiple(of: 3){
                        self.hourlyForecast.append(weather.hourlyForecast.forecast[i])
                    }
                }
                self.tenDayForecast = weather.dailyForecast.forecast
                self.hourlyForecast = weather.hourlyForecast.forecast
                print(weather.currentWeather)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
}
