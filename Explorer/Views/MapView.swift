//
//  MapView.swift
//  Explorer
//
//  Created by Tommy Truong on 4/10/23.
//
import MapKit
import SwiftUI
import WeatherKit

struct MapView: UIViewRepresentable {
    
    @Binding var currentLocation: SuggestedLocation
    
    @EnvironmentObject private var mapConfigurations: MapConfigurations
    
    var lookAroundScene: MKLookAroundScene?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.setRegion(MKCoordinateRegion.init(center: CLLocationCoordinate2D.init(latitude: 90, longitude: 90),
                                                  span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100)),
                          animated: true)
        mapView.camera.heading = .greatestFiniteMagnitude
        mapView.selectableMapFeatures = [.physicalFeatures,.pointsOfInterest,.territories]
        // ADD annotations
        var listAnnotations = [MKPointAnnotation]()
        for i in 0 ..< SuggestedLocation.sampleLocations.count {
            let annotation = MKPointAnnotation()
            annotation.title = SuggestedLocation.sampleLocations[i].name
            annotation.coordinate = SuggestedLocation.sampleLocations[i].coordinate
            listAnnotations.append(annotation)
        }
        mapView.addAnnotations(listAnnotations)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if currentLocation == SuggestedLocation.initialGlobe {
            uiView.setRegion(MKCoordinateRegion.init(center: CLLocationCoordinate2D.init(latitude: 90, longitude: 90),
                                                      span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100)),
                              animated: true)
        }
        uiView.setRegion(MKCoordinateRegion.init(center: CLLocationCoordinate2D.init(latitude: self.currentLocation.coordinate.latitude,
                                                                                     longitude: self.currentLocation.coordinate.longitude),
                                                 span: MKCoordinateSpan.init(latitudeDelta: 0.04, longitudeDelta: 0.04)),
                         animated: true)
                    
        updateMap(uiView)
    }
    
    func updateMap(_ uiView: MKMapView){
        switch mapConfigurations.mapType {
        case .Standard:
            uiView.preferredConfiguration = MKStandardMapConfiguration(elevationStyle: elevationStyle(),emphasisStyle: emphasisStyle())
        case .Image:
            uiView.preferredConfiguration = MKImageryMapConfiguration(elevationStyle: elevationStyle())
        case .Hybrid:
            uiView.preferredConfiguration = MKHybridMapConfiguration(elevationStyle: elevationStyle())
        }
    }
    
}

extension MapView {
    private func elevationStyle() -> MKStandardMapConfiguration.ElevationStyle{
        switch mapConfigurations.mapElevation {
        case .Realistic:
            return MKMapConfiguration.ElevationStyle.realistic
        case .Flat:
            return MKMapConfiguration.ElevationStyle.flat
        }
    }
    
    private func emphasisStyle() -> MKStandardMapConfiguration.EmphasisStyle {
        switch mapConfigurations.mapEmphasis {
        case .Default:
            return MKStandardMapConfiguration.EmphasisStyle.default
        case .Muted:
            return MKStandardMapConfiguration.EmphasisStyle.muted
        }
    }
}

