//
//  DetailedWeatherManager.swift
//  Explorer
//
//  Created by Tommy Truong on 4/19/23.
//

import Foundation
import CoreLocation

class DetailedWeatherManager {
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> DetailedForecast {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&cnt=40&appid=3dd5b7cd58d36aeabc991e1e56bfc7da&units=imperial")
                
        else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
                        
        let decodedData = try JSONDecoder().decode(DetailedForecast.self, from: data)
        
        print(decodedData)
        
        return decodedData
    }
}
