//
//  Forecast.swift
//  Explorer
//
//  Created by Tommy Truong on 4/18/23.
//

import Foundation

struct MyForecast: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds
struct Clouds:Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp, feels_like, temp_min, temp_max: Double
    let pressure, humidity: Double
//    let sea_level, grnd_level: Double
}

// MARK: - Sys
struct Sys: Codable {
    let country: String
    let sunrise, sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
    var id: Double
    var main: String
    var description: String
    var icon: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Double
//    let gust: Double
}
