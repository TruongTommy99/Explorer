//
//  MapConfigurations.swift
//  Explorer
//
//  Created by Tommy Phat Nhu Truong on 4/13/23.
//

import Foundation
import SwiftUI

final class MapConfigurations: ObservableObject {
    @Published var mapType: MapType = .Standard
    @Published var mapElevation: MapElevation = .Realistic
    @Published var mapEmphasis: MapElevationStyle = .Default
}
