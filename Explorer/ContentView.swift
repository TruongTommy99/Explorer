//
//  ContentView.swift
//  Explorer
//
//  Created by Tommy Truong on 4/10/23.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @State private var toggleInformationSheet = false
    
    @State private var currentLocation: CLLocationCoordinate2D?
    
    @State var currentSuggestedLocation: SuggestedLocation
    
    var body: some View {
        NavigationSplitView {
            Group {
                List(SuggestedLocation.sampleLocations,id:\.name) { place in
                    HStack {
                        Text(place.name)
                        Spacer()
                        Button {
                            self.currentLocation = place.coordinate
                            print(self.currentLocation!)
                        } label: {
                            Image(systemName: "info.circle")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        } detail: {
            ZStack {
                MapView(currentLocation: self.$currentLocation)
                    .ignoresSafeArea()
                
                if let currentLocation {
                    Button("Get information"){
                        self.toggleInformationSheet.toggle()
                    }
                }
            }
            .sheet(isPresented: self.$toggleInformationSheet) {
                InformationSheet(currentSuggestedLocation: self.currentSuggestedLocation)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(currentSuggestedLocation: SuggestedLocation.sampleLocations[0])
    }
}
