//
//  InformationView.swift
//  Explorer
//
//  Created by Tommy Truong on 4/19/23.
//

import SwiftUI

struct InformationView: View {
    @State var currentSuggestedLocation: SuggestedLocation
    
    @State var weather: MyForecast?
    @State var detailedWeather: DetailedForecast?
    
    var weatherManager = WeatherManager()
    var detailedWeatherManager = DetailedWeatherManager()
    
    private let urlString = "https://www.google.com/search?q=flights+to+"

    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                HStack {
                    Spacer()
                    Text("Informations")
                        .bold()
                        .font(.largeTitle)
                    Spacer()
                }
                // Weather screen
                VStack {
                    if let weather {
                        WeatherView(weather: weather)
                            .frame(maxHeight: 400)
                            .cornerRadius(8)
                            .padding()
                    }
                    else {
                        HStack{
                            Spacer()
                            ProgressView {
                                Text("Fetching data")
                            }
                            Spacer()
                        }
                    }
                }
                
                NavigationLink("See what the weather is going to look like the next few days →") {
                    if let detailedWeather {
                        DetailedWeatherView(data: detailedWeather, currentChartType: .Temperature)
                    } else { ProgressView() }
                }
                .padding()
                
                HStack {
                    Spacer()
                    VStack(spacing: 10) {
                        Text("Travel now")
                            .bold()
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .padding(.top)
                        Text("Found your destination for the summer? Tap below!")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        Link(destination: URL(string: (urlString + currentSuggestedLocation.name.replacingOccurrences(of: " ", with: "+")).trimmingCharacters(in: .whitespaces))!) {
                            ZStack{
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.blue)
                                Text("Book a flight")
                                    .foregroundColor(.white)
                            }
                            .frame(width: 160,height: 40)
                            .padding()
                        }
                    }
                    .background(.gray.opacity(0.15))
                    .cornerRadius(12)
                    .padding()
                    Spacer()
                }
            }
        }
        .onAppear {
            Task {
                do {
                    self.weather = try await weatherManager.getCurrentWeather(latitude: currentSuggestedLocation.coordinate.latitude, longitude: currentSuggestedLocation.coordinate.longitude)
                    self.detailedWeather = try await detailedWeatherManager.getCurrentWeather(latitude: currentSuggestedLocation.coordinate.latitude, longitude: currentSuggestedLocation.coordinate.longitude)
                } catch {
                    print("Error getting weather: \(error)")
                }
            }
        }
    }
}
//
//struct InformationView_Previews: PreviewProvider {
//    static var previews: some View {
//        InformationView()
//    }
//}
