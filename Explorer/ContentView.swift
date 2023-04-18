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
                List(SuggestedLocation.sampleLocations, id:\.name) { place in
                        Button {
                            withAnimation(.default){
                                self.currentSuggestedLocation = place
                            }
                        } label: {
                            HStack {
                                Text(place.name)
                                Spacer()
                                Text(place.flag)
                            }
                        }
                    .listRowBackground(self.currentSuggestedLocation == place ? Color.blue.cornerRadius(8) : Color.white.cornerRadius(0))
                }
                .navigationTitle("Locations")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        Button("Surprise me!"){
                            self.currentSuggestedLocation = SuggestedLocation.sampleLocations.randomElement()!
                        }
                    }
                }
        } detail: {
            ZStack {
                MapView(currentLocation: self.$currentSuggestedLocation)
                    .ignoresSafeArea()
                    .environmentObject(mapConfigurations)
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    VStack {
                        Button {
                            self.currentSuggestedLocation = SuggestedLocation.initialGlobe
                        } label: {
                            Group {
                                Image(systemName: "arrowshape.backward.fill")
                                    .resizable()
                                    .aspectRatio(1,contentMode: .fit)
                                    .opacity(0.5)
                                .frame(width: 25)
                            }
                            .frame(width: 45, height: 45)
                        }
                    }
                    .background(
                        VisualEffectView(.systemThickMaterial)
                            .cornerRadius(10)
                            .shadow(radius: 8)
                    )
                    .frame(width: 45)
                }
            })
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
                            self.toggleConfigurationSheet.toggle()
                        } label: {
                            Group {
                                Image(systemName: "map.fill")
                                    .resizable()
                                    .aspectRatio(1,contentMode: .fit)
                                    .opacity(0.5)
                                .frame(width: 25)
                            }
                            .frame(width: 45, height: 45)
                        }
                    }
                    .background(
                        VisualEffectView(.systemThickMaterial)
                            .cornerRadius(10)
                            .shadow(radius: 8)
                    )
                    .frame(width: 45)
                    
                    Spacer()
                    
                    if self.currentSuggestedLocation != SuggestedLocation.initialGlobe {
                        LookAroundView(suggestedLocation: self.$currentSuggestedLocation, hasLookAroundScene: self.$hasLookAroundScene)
                            .frame(width: 150,height: 150)
                            .cornerRadius(8)
                            .shadow(radius: 8)
                            .padding(.trailing,10)
                    }
                }
                .padding()
            }
        }
        .sheet(isPresented: self.$toggleInformationSheet) {
            InformationSheet(currentSuggestedLocation: self.currentSuggestedLocation)
        }
        .sheet(isPresented: self.$toggleConfigurationSheet) {
            MapConfigurationsView(mapConfiguration: mapConfigurations)
                .environmentObject(mapConfigurations)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(currentSuggestedLocation: SuggestedLocation.sampleLocations[0], hasLookAroundScene: false, mapConfigurations: MapConfigurations())
    }
}
