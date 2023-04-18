//
//  WeatherWeeklyView.swift
//  Explorer
//
//  Created by Tommy Truong on 4/18/23.
//

import SwiftUI

struct WeatherWeeklyView: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    
    @State var currentSuggestedLocation: SuggestedLocation
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.5),.cyan.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                if let _ = weatherViewModel.data {
                VStack(alignment: .leading) {
                    Label("10-day forecast".uppercased(), systemImage: "calendar")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(8)
                    Divider()
                        VStack {
                            ForEach(weatherViewModel.tenDayForecast,id :\.date) { forecast in
                                HStack {
                                    Text(forecast.date.formatted(date: .numeric, time: .omitted))
                                    Image(systemName: "\(forecast.symbolName).fill")
                                        .font(.title2)
                                        .padding(.horizontal)
                                        .symbolRenderingMode(.multicolor)
                                    Text(forecast.lowTemperature.formatted())
                                    ZStack{
                                        Capsule()
                                        LinearGradient(gradient: Gradient(colors: [.blue,.yellow]), startPoint: .top, endPoint: .bottom)
                                            .ignoresSafeArea()
                                    }
                                    Text(forecast.highTemperature.formatted())
                                }
                            }
                        }
                }
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8,style: .circular))
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

//struct WeatherWeeklyView_Previews: PreviewProvider {
//    static var previews: some View {
//        WeatherWeeklyView()
//    }
//}
