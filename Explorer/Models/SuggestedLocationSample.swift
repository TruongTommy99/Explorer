//
//  SuggestedLocationSample.swift
//  Explorer
//
//  Created by Tommy Phat Nhu Truong on 4/12/23.
//

import Foundation
import CoreLocation

extension SuggestedLocation {
    static var sampleLocations: [SuggestedLocation] = [
        SuggestedLocation(name: "Empire State Building", flag: "🇺🇸", coordinate: CLLocationCoordinate2D.init(latitude: 40.7484, longitude: -73.9857)),
        SuggestedLocation(name: "TeamLabs Planet", flag: "🇯🇵", coordinate: CLLocationCoordinate2D.init(latitude: 35.64923398, longitude: 139.7897846)),
        SuggestedLocation(name: "Parthenon", flag: "🇬🇷", coordinate: CLLocationCoordinate2D.init(latitude: 37.9715, longitude: 23.7266)),
        SuggestedLocation(name: "Golden Gate Bridge", flag: "🇺🇸", coordinate: CLLocationCoordinate2D.init(latitude: 37.81847, longitude: -122.47843)),
        SuggestedLocation(name: "Eiffel Tower", flag: "🇫🇷", coordinate: .init(latitude: 48.85845477618573, longitude: 2.2944491112155156))
    ]
    
    static var initialGlobe: SuggestedLocation = SuggestedLocation(name: "", flag: "", coordinate: .init(latitude: 90, longitude: 90))
}
