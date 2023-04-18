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
                
                Link("Want to visit this location? Book a flight now!", destination: URL(string: (urlString + currentSuggestedLocation.name.replacingOccurrences(of: " ", with: "+")).trimmingCharacters(in: .whitespaces))!)
                    .padding()
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

