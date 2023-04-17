//
//  SuggestLocations.swift
//  Explorer
//
//  Created by Tommy Truong on 4/11/23.
//

import Foundation
import MapKit

struct SuggestedLocation {
    let name: String
    let flag: String
    var coordinate: CLLocationCoordinate2D
}

extension SuggestedLocation: Hashable {
    static func == (lhs: SuggestedLocation, rhs: SuggestedLocation) -> Bool {
        lhs.name == rhs.name
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}


