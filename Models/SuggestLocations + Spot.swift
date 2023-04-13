//
//  SuggestLocations.swift
//  Explorer
//
//  Created by Tommy Truong on 4/11/23.
//

import Foundation
import MapKit

struct SuggestedLocations {
    let name: String
    let coordinate: Double
    let spots: [Spot]
}

struct Spot {
    let title:String
    let longitude: Double
    let latitute: Double
}
