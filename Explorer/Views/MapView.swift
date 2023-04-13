//
//  MapView.swift
//  Explorer
//
//  Created by Tommy Truong on 4/10/23.
//
import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    
    @Binding var currentLocation: CLLocationCoordinate2D?
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.setRegion(MKCoordinateRegion.init(center: CLLocationCoordinate2D.init(latitude: self.currentLocation?.latitude ?? 65.0, longitude: self.currentLocation?.longitude ?? 65.0), span: MKCoordinateSpan.init(latitudeDelta: 50, longitudeDelta: 50)), animated: true)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(MKCoordinateRegion.init(center: CLLocationCoordinate2D.init(latitude: self.currentLocation?.latitude ?? 65.0, longitude: self.currentLocation?.longitude ?? 65.0), span: MKCoordinateSpan.init(latitudeDelta: 5, longitudeDelta: 5)), animated: true)
    }
    
}
