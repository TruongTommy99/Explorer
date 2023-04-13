//
//  MapViewConfigurationEnum.swift
//  Explorer
//
//  Created by Tommy Phat Nhu Truong on 4/13/23.
//

import Foundation
import SwiftUI

enum MapType: String,Equatable, CaseIterable {
    case Standard
    case Image
    case Hybrid
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}

enum MapElevation: String, Equatable, CaseIterable {
    case Realistic
    case Flat
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}

enum MapElevationStyle: String, Equatable, CaseIterable {
    case Default
    case Muted
    var localizedName: LocalizedStringKey {
        LocalizedStringKey(rawValue)
    }
}


