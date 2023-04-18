//
//  DetailedInformationSheet.swift
//  Explorer
//
//  Created by Tommy Phat Nhu Truong on 4/17/23.
//

import SwiftUI
import Charts

struct DetailedInformationSheet: View {
    
    var suggestedLocation: SuggestedLocation
        
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    
    @State var currentChartViewType: WeatherChartViewType = .Minute
    
    var body: some View {
        VStack {
            if let data = weatherViewModel.data {
                ZStack {
                    VStack {
                        List {
                            Section {
                                DetailedRowInformation(title: "Local Time",
                                                       information: data.currentWeather.date.description)
                                DetailedRowInformation(title: "Temperature",
                                                       information: data.currentWeather.temperature.description)
                                DetailedRowInformation(title: "Feels like", information: data.currentWeather.apparentTemperature.description)
                                DetailedRowInformation(title: "Dew Point", information: data.currentWeather.apparentTemperature.description)
                                DetailedRowInformation(title: "Humidity", information: data.currentWeather.humidity.description)
                                DetailedRowInformation(title: "Pressure", information: data.currentWeather.pressure.description)
                                DetailedRowInformation(title: "Pressure Trend", information: data.currentWeather.pressureTrend.description)
                            }header: {
                                Text("General Information")
                            }footer: {
                                Text("There is currently \(data.currentWeather.isDaylight ? "" : "no") dailight")
                            }
                            
                            Section {
                                Picker("Pick forecast type", selection: self.$currentChartViewType.animation(.easeInOut)) {
                                    ForEach(WeatherChartViewType.allCases, id: \.self) { value in
                                        Text(value.localizedName)
                                            .tag(value)
                                    }
                                }
                                .pickerStyle(.segmented)
                                switch currentChartViewType {
                                case .Minute:
                                    if let minforecast = data.minuteForecast{
                                        Chart(data.minuteForecast!.forecast, id:\.date) { daily in
                                            LineMark(x: .value("Hour", daily.date.formatted(date: .omitted, time: .shortened  )),
                                                     y: .value("Temperature", daily.precipitationChance))
                                        }
                                    }
                                    else {
                                        Text("Currently no information on minute forecast.")
                                    }
                                case .Hourly:
                                    Text("Lowest and highest temperature daily")
                                        .bold()
                                    Chart(data.dailyForecast.forecast, id:\.date) { daily in
                                        PointMark(
                                            x: .value("Day", daily.date.formatted(date: .abbreviated, time: .omitted)),
                                            y: .value("Low temperature", daily.lowTemperature.formatted())
                                                        )
                                        .foregroundStyle(.red)
                                                        PointMark(
                                                            x: .value("Day", daily.date.formatted(date: .abbreviated, time: .omitted)),
                                                            y: .value("High temperature", daily.highTemperature.formatted())
                                                        )
                                                        .foregroundStyle(.blue)

                                    }
                                    .frame(minHeight: 400)
                                case .Daily:
                                    Text("Temperature and how it feels")
                                        .bold()
                                    Chart(data.hourlyForecast,id:\.date) { hourly in
                                        LineMark(x: .value("Hour", hourly.date.formatted()),
                                                 y: .value("Temperature", hourly.temperature.formatted())
                                        )
                                        .interpolationMethod(.cardinal)
                                        .foregroundStyle(.blue)
                                    }
                                    .frame(minHeight: 400)
                                }
                            }
                            
                            Section {
                                DetailedRowInformation(title: "Wind Speed", information: data.currentWeather.wind.speed.description)
                                DetailedRowInformation(title: "Wind Directions", information: data.currentWeather.wind.direction.description)
                                if let windGust = data.currentWeather.wind.gust {
                                    DetailedRowInformation(title: "Wind Gust", information: windGust.description)
                                }
                                DetailedRowInformation(title: "Cloud Cover", information: (data.currentWeather.cloudCover*100).description)
                            } header: {
                                Text("Wind information")
                            }
                            Section {
                                DetailedRowInformation(title: "UV Index", information: data.currentWeather.uvIndex.category.description)
                                DetailedRowInformation(title: "Visibility", information: data.currentWeather.visibility.description)
                            } header: {
                                Text("Other")
                            }
                        }
                    }
                }
                .frame(maxWidth: UIScreen.main.bounds.size.width * (2/3))
            }
//            ForEach(SuggestedLocation.sampleLocations,id:\.self) { location in
//                if suggestedLocation.flag == location.flag && location != suggestedLocation {
//                    Text("Consider also visiting: \(location.name)")
//                }
//            }
        }
    }
}

struct DetailedInformationSheet_Previews: PreviewProvider {
    static var previews: some View {
        DetailedInformationSheet(suggestedLocation: .sampleLocations[0])
    }
}

struct DetailedRowInformation: View {
    var title: String
    var information: String
    
    var body: some View {
        HStack {
            Text(title)
                .multilineTextAlignment(.leading)
            Spacer()
            Text(information)
                .multilineTextAlignment(.trailing)
        }
    }
    
}
