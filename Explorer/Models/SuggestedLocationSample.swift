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
        SuggestedLocation(name: "Golden Gate Bridge", flag: "🇺🇸", coordinate: CLLocationCoordinate2D.init(latitude: 37.81847, longitude: -122.47843)),
        SuggestedLocation(name: "TeamLabs Planet", flag: "🇯🇵", coordinate: CLLocationCoordinate2D.init(latitude: 35.64923398, longitude: 139.7897846)),
        SuggestedLocation(name: "Marina Bay Sands", flag: "🇸🇬", coordinate: CLLocationCoordinate2D.init(latitude: 1.2843581639329786, longitude: 103.85979314548977)),
        SuggestedLocation(name: "Buckingham Palace", flag: "🇬🇧", coordinate: CLLocationCoordinate2D.init(latitude: 51.50194930662975, longitude: -0.14196052420452218)),
        SuggestedLocation(name: "Champs-Elysees", flag: "🇫🇷", coordinate: .init(latitude: 48.87310855952586, longitude: 2.2977683666833904)),
        SuggestedLocation(name: "Louvre Museum", flag: "🇫🇷", coordinate: .init(latitude: 48.86166644999687, longitude: 2.3386432626956237)),
        SuggestedLocation(name: "Bradenburg Gate", flag: "🇩🇪", coordinate: .init(latitude: 52.51636597633361, longitude: 13.377757742069402)),
        SuggestedLocation(name: "Piazza San Marco", flag: "🇮🇹", coordinate: .init(latitude:  45.43455829250173, longitude:12.338815022744887)),
        SuggestedLocation(name: "Lincoln Memorial", flag: "🇺🇸", coordinate: .init(latitude:  38.88933101428776, longitude: -77.05005075332554)),
        SuggestedLocation(name: "Sky Tower", flag: "🇳🇿", coordinate: .init(latitude:  -36.84779550088824, longitude: 174.7623197460293))
        
    ]
    
    static var initialGlobe: SuggestedLocation = SuggestedLocation(name: "", flag: "", coordinate: .init(latitude: 90, longitude: 90))
}
