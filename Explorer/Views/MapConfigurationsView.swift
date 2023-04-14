//
//  MapConfigurationsView.swift
//  Explorer
//
//  Created by Tommy Phat Nhu Truong on 4/14/23.
//

import SwiftUI

struct MapConfigurationsView: View {
    @EnvironmentObject var mapConfigurations: MapConfigurations
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
}

struct MapConfigurationsView_Previews: PreviewProvider {
    static var previews: some View {
        MapConfigurationsView()
    }
}
