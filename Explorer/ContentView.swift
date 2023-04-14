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
    @State var currentSuggestedLocation: SuggestedLocation
    
    @State var hasLookAroundScene: Bool
    
    @ObservedObject var mapConfigurations: MapConfigurations
    
    @State private var toggleInformationSheet = false
    @State private var toggleConfigurationSheet = false

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
                MapView(currentLocation: self.$currentSuggestedLocation.coordinate)
                    .ignoresSafeArea()
                    .environmentObject(mapConfigurations)
            }
            .overlay(alignment: .trailing) {
                VStack {
                    
                    VStack(spacing:0)  {
                        Button {
                            self.toggleInformationSheet.toggle()
                        } label: {
                            Group {
                                Image(systemName: "info.circle.fill")
                                    .resizable()
                                    .aspectRatio(1,contentMode: .fit)
                                    .opacity(0.5)
                                .frame(width: 25)
                            }
                            .frame(width: 45, height: 45)
                        }
                        Divider()
                        Button {
                            self.mapConfigurations.mapType = .Hybrid
                        } label: {
                            Group {
                                Image(systemName: "map.fill")
                                    .resizable()
                                    .aspectRatio(1,contentMode: .fit)
                                    .opacity(0.5)
                                .frame(width: 30)
                            }
                            .frame(width: 45, height: 45)
                        }
//
//                        Button("Standard"){
//                            self.mapConfigurations.mapType = .Standard
//                        }
//                        Divider()
//                            .frame(width: 45, height: 0)
//                        Button("Hybrid"){
//                            self.mapConfigurations.mapType = .Hybrid
//                        }
//                        Divider()
//                            .frame(width: 45, height: 0)
//                        Button("Image"){
//                            self.mapConfigurations.mapType = .Image
//                        }
//                        Button("realistic"){
//                            self.mapConfigurations.mapElevation = .Realistic
//                        }
//                        Button("flat"){
//                            self.mapConfigurations.mapElevation = .Flat
//                        }
                    }
                    .background(
                        VisualEffectView(.systemThickMaterial)
                            .cornerRadius(10)
                            .shadow(radius: 8)
                    )
                    .frame(width: 45)
                    
                    Spacer()
                    
                    LookAroundView(suggestedLocation: self.$currentSuggestedLocation, hasLookAroundScene: self.$hasLookAroundScene)
                        .frame(width: 150,height: 150)
                        .cornerRadius(8)
                        .shadow(radius: 8)
                        .padding(.trailing,10)
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
