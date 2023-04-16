//
//  MapConfigurationsView.swift
//  Explorer
//
//  Created by Tommy Phat Nhu Truong on 4/14/23.
//

import SwiftUI

struct MapConfigurationsView: View {
    @ObservedObject var mapConfiguration: MapConfigurations
        
    var body: some View {
        VStack {
            Picker("Map type",selection: $mapConfiguration.mapType){
                Text("Standard").tag(MapType.Standard)
                Text("Image").tag(MapType.Image)
                Text("Hybrid").tag(MapType.Hybrid)
            }
            
            Picker("Elevation",selection: $mapConfiguration.mapElevation){
                Text("Realistic").tag(MapElevation.Realistic)
                Text("Flat").tag(MapElevation.Flat)
            }
            
            Picker("Elevation Style",selection: $mapConfiguration.mapEmphasis){
                Text("Default").tag(MapElevationStyle.Default)
                Text("Muted").tag(MapElevationStyle.Muted)
            }
        }
        .pickerStyle(.segmented)
        .padding()
    }
}

//struct MapConfigurationsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapConfigurationsView(mapConfigurations: .constant(.init()))
//    }
//}
