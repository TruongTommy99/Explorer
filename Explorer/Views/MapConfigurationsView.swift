//
//  MapConfigurationsView.swift
//  Explorer
//
//  Created by Tommy Phat Nhu Truong on 4/14/23.
//

import SwiftUI

struct MapConfigurationsView: View {
    @EnvironmentObject var mapConfiguration: MapConfigurations
        
    var body: some View {
        VStack {
            Button("Map: standard") {
                mapConfiguration.mapType = .Standard
            }
            Button("Map: image") {
                mapConfiguration.mapType = .Image
            }
            Button("Map: hybrid") {
                mapConfiguration.mapType = .Hybrid
            }
        }
    }
}

//struct MapConfigurationsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapConfigurationsView(mapConfigurations: .constant(.init()))
//    }
//}
