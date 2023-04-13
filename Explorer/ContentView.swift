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
    
    @State var currentMapViewConfiguration: MapViewConfigurationEnum
    
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
            ZStack(alignment: .bottomTrailing) {
                if let currentSuggestedLocation {
                    MapView(currentLocation: self.$currentSuggestedLocation.coordinate,
                            mapConfiguration: self.$currentMapViewConfiguration)
                        .ignoresSafeArea()
                    
                    VStack() {
                        Button("Get information"){
                            self.toggleInformationSheet.toggle()
                        }
                        Spacer()
                        Button("Realistic"){
                            self.currentMapViewConfiguration = .realistic
                        }
                        Button("Standard"){
                            self.currentMapViewConfiguration = .standard
                        }
                        .pickerStyle(.segmented)
                        LookAroundView(suggestedLocation: self.$currentSuggestedLocation, hasLookAroundScene: self.$hasLookAroundScene)
                            .frame(width: 125,height: 125)
                            .cornerRadius(8)
                            .shadow(radius: 8)

                    }
                    .padding()
                }
            }
        }
        .sheet(isPresented: self.$toggleInformationSheet) {
            InformationSheet(currentSuggestedLocation: self.currentSuggestedLocation)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(currentSuggestedLocation: SuggestedLocation.sampleLocations[0], hasLookAroundScene: false, currentMapViewConfiguration: .realistic)
    }
}
