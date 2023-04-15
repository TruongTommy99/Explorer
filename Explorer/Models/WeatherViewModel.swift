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
    
    var service = WeatherService.shared
    
    func getWeather(for location: CLLocation){
        Task(priority: .high) { @MainActor in
            do  {
                let weather = try await service.weather(for: location)
                self.data = weather
                print(weather.currentWeather)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
}
