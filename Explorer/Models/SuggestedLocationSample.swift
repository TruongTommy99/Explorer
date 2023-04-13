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
        SuggestedLocation(name: "Paris", coordinate: CLLocationCoordinate2D.init(latitude: 75.0, longitude: 75.0), spots: [.init(title: "Tour Eiffel", longitude: 74.0, latitute: 74.0)]),
        SuggestedLocation(name: "New York", coordinate: CLLocationCoordinate2D.init(latitude: 40.7484, longitude: -73.9857), spots: [.init(title: "Tour Eiffel", longitude: 74.0, latitute: 74.0)]),
        SuggestedLocation(name: "Tokyo", coordinate: CLLocationCoordinate2D.init(latitude: 65.0, longitude: 65.0), spots: [.init(title: "Tour Eiffel", longitude: 74.0, latitute: 74.0)]),
        SuggestedLocation(name: "Golden Gate Bridge", coordinate: CLLocationCoordinate2D.init(latitude: 37.81847, longitude: -122.47843), spots: [.init(title: "Tour Eiffel", longitude: 74.0, latitute: 74.0)]),
        SuggestedLocation(name: "2151 13th Street", coordinate: CLLocationCoordinate2D.init(latitude: 42.733652886884315, longitude: -73.67866401349434), spots: [.init(title: "Tour Eiffel", longitude: 74.0, latitute: 74.0)])
    ]
    
}
