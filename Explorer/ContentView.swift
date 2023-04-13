//
//  ContentView.swift
//  Explorer
//
//  Created by Tommy Truong on 4/10/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            Group {
                Button("HELLO") {
                    
                }
            }
        } detail: {
            MapView()
                .ignoresSafeArea(edges: .bottom)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
