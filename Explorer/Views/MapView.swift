//
//  MapView.swift
//  Explorer
//
//  Created by Tommy Truong on 4/10/23.
//
import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    
    @Binding var currentLocation: CLLocationCoordinate2D
    
    @EnvironmentObject private var mapConfigurations: MapConfigurations
    
    var lookAroundScene: MKLookAroundScene?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.setRegion(MKCoordinateRegion.init(center: CLLocationCoordinate2D.init(latitude: 65.0, longitude: 50.0),
                                                  span: MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)),
                          animated: true)
        mapView.camera.heading = .greatestFiniteMagnitude
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(MKCoordinateRegion.init(center: CLLocationCoordinate2D.init(latitude: self.currentLocation.latitude,
                                                                                     longitude: self.currentLocation.longitude),
                                                 span: MKCoordinateSpan.init(latitudeDelta: 0.3, longitudeDelta: 0.3)),
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

