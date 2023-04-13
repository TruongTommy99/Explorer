//
//  ContentView.swift
//  Explorer
//
//  Created by Tommy Truong on 4/10/23.
//

import SwiftUI
import CoreLocation
import MapKit

struct ContentView: View {
    @State private var toggleInformationSheet = false
        
    @State var currentSuggestedLocation: SuggestedLocation
    
    @State var hasLookAroundScene: Bool
    
    @ObservedObject var mapConfigurations: MapConfigurations
    
    var body: some View {
        NavigationSplitView {
            Group {
                List(SuggestedLocation.sampleLocations,id:\.name) { place in
                    HStack {
                        Text(place.name)
                        Spacer()
                        Button {
                            self.currentSuggestedLocation = place
                        } label: {
                            Image(systemName: "info.circle")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        } detail: {
            ZStack {
                if let currentSuggestedLocation {
                    MapView(currentLocation: self.$currentSuggestedLocation.coordinate)
                        .ignoresSafeArea()
                        .environmentObject(mapConfigurations)
                }
            }
            .overlay(alignment: .trailing) {
                VStack {
                    Button("Get information"){
                        self.toggleInformationSheet.toggle()
                    }

                    Button("Standard"){
                        self.mapConfigurations.mapType = .Standard
                    }
                    Button("Hybrid"){
                        self.mapConfigurations.mapType = .Hybrid
                    }
                    Button("Image"){
                        self.mapConfigurations.mapType = .Image
                    }
                    Button("realistic"){
                        self.mapConfigurations.mapElevation = .Realistic
                    }
                    Button("flat"){
                        self.mapConfigurations.mapElevation = .Flat
                    }
                    
                    Spacer()
                    LookAroundView(suggestedLocation: self.$currentSuggestedLocation, hasLookAroundScene: self.$hasLookAroundScene)
                        .frame(width: 125,height: 125)
                        .cornerRadius(8)
                        .shadow(radius: 8)
                }
                .padding()
            }
        }
        .sheet(isPresented: self.$toggleInformationSheet) {
            InformationSheet(currentSuggestedLocation: self.currentSuggestedLocation)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(currentSuggestedLocation: SuggestedLocation.sampleLocations[0], hasLookAroundScene: false, mapConfigurations: MapConfigurations())
    }
}
