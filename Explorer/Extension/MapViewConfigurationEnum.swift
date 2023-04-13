//
//  MapViewConfigurationEnum.swift
//  Explorer
//
//  Created by Tommy Phat Nhu Truong on 4/13/23.
//

import Foundation
import SwiftUI

enum MapViewConfigurationEnum: String,Equatable, CaseIterable {
    case standard
    case realistic
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}
