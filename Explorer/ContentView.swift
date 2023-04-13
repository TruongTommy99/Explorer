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
        
    @State var currentSuggestedLocation: SuggestedLocation
    
    @State var hasLookAroundScene: Bool
    
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
                    
                    VStack {
                        Button("Get information"){
                            self.toggleInformationSheet.toggle()
                        }
                        LookAroundView(suggestedLocation: self.$currentSuggestedLocation, hasLookAroundScene: self.$hasLookAroundScene)
                            .frame(width: 100,height: 100)
                            .cornerRadius(8)
                            .shadow(radius: 8)
                    }
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
        ContentView(currentSuggestedLocation: SuggestedLocation.sampleLocations[0], hasLookAroundScene: false)
    }
}
