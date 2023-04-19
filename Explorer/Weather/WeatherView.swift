//
//  WeatherView.swift
//  Explorer
//
//  Created by Tommy Truong on 4/19/23.
//

import SwiftUI

struct WeatherView: View {

    var weather: MyForecast
    
    let timeHere = Date()
    @State var timeThere = ""
    @State var index = 0
    @State var timeGap = 0
    var dateFormatter = DateFormatter()
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name)
                        .bold()
                        .font(.title)
                    Text("Local time: \(timeThere)")
                    Text("\(timeGap == 0 ? "You are in the same time zone" : "You are \(timeGap > 0 ? "ahead":"behind") by \(abs(timeGap)) hours." )")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                                
                VStack {
                    HStack {
                        VStack {
                            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.weather[0].icon)@2x.png")!) { image in
                                image
                                    .font(.system(size: 40))
                                    .foregroundColor(.blue.opacity(0.2))
                                    .symbolRenderingMode(.multicolor)
                                    .frame(width: 40)
                            } placeholder: {
                                ProgressView()
                            }

                            Text("\(weather.weather[0].main)")
                        }
                        .frame(width: 80, alignment: .leading)
                        
                        Text(weather.main.feels_like.roundDouble() + "°")
                            .font(.system(size: 60))
                            .fontWeight(.bold)
                            .padding()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.blue.opacity(0.1))
                        
            VStack(alignment: .leading, spacing: 2) {
                Text("Weather now")
                    .bold()
                
                HStack {
                    WeatherRow(logo: "thermometer", name: "Min temp", value: (weather.main.temp_min.roundDouble() + ("°")))
                    Spacer()
                    WeatherRow(logo: "thermometer", name: "Max temp", value: (weather.main.temp_max.roundDouble() + "°"))
                    Spacer()
                    WeatherRow(logo: "wind", name: "Wind speed", value: (weather.wind.speed.description + " m/s"))
                    Spacer()
                    WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.main.humidity.description)%")
                }
            }
                .padding()
                .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
                .background(.blue.opacity(0.2))
                .cornerRadius(8)
        }
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8,style: .circular))
        .onAppear {
            dateFormatter.dateFormat = "LLLL dd, hh:mm a"
            dateFormatter.timeZone = TimeZone(secondsFromGMT: weather.timezone)
            timeThere = dateFormatter.string(from: timeHere)
            index = TimeZone.current.secondsFromGMT()
            timeGap = (index - weather.timezone)/3600
            // Data
//            Detailed
        }
    }
}


//struct WeatherView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherView()
//    }
//}
