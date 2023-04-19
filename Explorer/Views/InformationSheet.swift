//
//  InformationSheet.swift
//  Explorer
//
//  Created by Tommy Phat Nhu Truong on 4/12/23.
//

import SwiftUI
import CoreLocation
import WebKit

struct InformationSheet: View {
    @State var currentSuggestedLocation: SuggestedLocation
    
    @StateObject var weatherViewModel = WeatherViewModel()
    
    private let urlString = "https://www.google.com/search?q=flights+to+"
    @State var currentTime: TimeZone? = TimeZone(identifier: "") ?? nil
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                HStack {
                    Spacer()
                    Text("Informations")
                        .bold()
                        .font(.largeTitle)
                    Spacer()
                }
                // Weather screen
                HStack {
                    if weatherViewModel.data != nil {
                        WeatherDailyView(currentSuggestedLocation: currentSuggestedLocation)
                            .environmentObject(weatherViewModel)
                            .frame(height: 500)
                            .cornerRadius(12)
                            .shadow(radius: 6)
                        WeatherWeeklyView(currentSuggestedLocation: currentSuggestedLocation)
                            .environmentObject(weatherViewModel)
                            .frame(height: 500)
                            .cornerRadius(12)
                            .shadow(radius: 6)
                    }
                    else {
                        Spacer()
                        ProgressView("Fetching data")
                        Spacer()
                    }
                }
                
                NavigationLink("More Information →") {
                    DetailedInformationSheet(suggestedLocation: currentSuggestedLocation)
                        .environmentObject(weatherViewModel)
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
            weatherViewModel.getWeather(for: CLLocation(latitude: currentSuggestedLocation.coordinate.latitude, longitude: currentSuggestedLocation.coordinate.longitude))
            self.getTimeZone(location: currentSuggestedLocation.coordinate) { TimeZone in
                self.currentTime = TimeZone
                print(TimeZone.description)
            }
        }
        .onChange(of: currentSuggestedLocation) { newValue in
            weatherViewModel.getWeather(for: CLLocation(latitude: newValue.coordinate.latitude, longitude: newValue.coordinate.longitude))
        }
    }
    
    func getTimeZone(location: CLLocationCoordinate2D, completion: @escaping ((TimeZone) -> Void)) {
        let cllLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(cllLocation) { placemarks, error in

            if let error = error {
                print(error.localizedDescription)

            } else {
                if let placemarks = placemarks {
                    if let optTime = placemarks.first!.timeZone {
                        completion(optTime)
                    }
                }
            }
        }
    }
}

struct InformationSheet_Previews: PreviewProvider {
    static var previews: some View {
        InformationSheet(currentSuggestedLocation: SuggestedLocation.sampleLocations[0])
    }
}

