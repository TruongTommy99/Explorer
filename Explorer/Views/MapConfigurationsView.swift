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
            Text("Choose your map configuration")
                .font(.title2)
                .bold()
            Picker("Map type",selection: $mapConfiguration.mapType){
                Text("Standard").tag(MapType.Standard)
                Text("Image").tag(MapType.Image)
                Text("Hybrid").tag(MapType.Hybrid)
            }
            .frame(maxWidth: 300)
            
            Picker("Elevation",selection: $mapConfiguration.mapElevation){
                Text("Realistic").tag(MapElevation.Realistic)
                Text("Flat").tag(MapElevation.Flat)
            }
            .frame(maxWidth: 200)
            
            Picker("Elevation Style",selection: $mapConfiguration.mapEmphasis){
                Text("Default").tag(MapElevationStyle.Default)
                Text("Muted").tag(MapElevationStyle.Muted)
            }
            .frame(maxWidth: 200)
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
