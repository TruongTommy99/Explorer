//
//  WeatherViewModel.swift
//  Explorer
//
//  Created by Tommy Phat Nhu Truong on 4/14/23.
//

import Foundation
import WeatherKit
import CoreLocation

//class WeatherViewModel: ObservableObject {
//    
//    @Published var data: Weather?
//    
//    @Published var hourlyForecastList = [HourWeather]()
//    
//    @Published var tenDayForecast = [DayWeather]()
//    
//    @Published var currentDate = Date()
//    
//    var service = WeatherService.shared
//    
//    func getWeather(for location: CLLocation){
//        Task(priority: .high) { @MainActor in
//            do  {
//                let weather = try await service.weather(for: location)
//                self.data = weather
//                // HOURLY FORECAST
//                for i in 0...24 {
//                        self.hourlyForecastList.append(weather.hourlyForecast.forecast[i])
//                }
//                print(weather.currentWeather.date)
//                print(data?.currentWeather.date.formatted())
//                self.tenDayForecast = weather.dailyForecast.forecast
//            }
//            catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
//}
