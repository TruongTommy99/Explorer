//
//  MapView.swift
//  Explorer
//
//  Created by Tommy Truong on 4/10/23.
//
import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    
    @Binding var currentLocation: SuggestedLocation
    
    @EnvironmentObject private var mapConfigurations: MapConfigurations
            
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
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
        uiView.setRegion(MKCoordinateRegion.init(center: CLLocationCoordinate2D.init(latitude: self.currentLocation.coordinate.latitude,
                                                                                     longitude: self.currentLocation.coordinate.longitude),
                                                 span: MKCoordinateSpan.init(latitudeDelta: 0.04, longitudeDelta: 0.04)),
                         animated: true)
        if currentLocation == SuggestedLocation.initialGlobe {
            uiView.setRegion(MKCoordinateRegion.init(center: CLLocationCoordinate2D.init(latitude: 90, longitude: 90),
                                                      span: MKCoordinateSpan(latitudeDelta: 100, longitudeDelta: 100)),
                              animated: true)
        }
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
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self,currentLocation)
    }
    
    public class MapViewCoordinator: NSObject, MKMapViewDelegate {
        var mapView: MapView
        var currentLocation: SuggestedLocation
                
        init(_ control: MapView,_ current: SuggestedLocation) {
            self.mapView = control
            self.currentLocation = current
        }

        public func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
            mapView.setRegion(MKCoordinateRegion.init(center: CLLocationCoordinate2D.init(latitude: annotation.coordinate.latitude,
                                                                                          longitude: annotation.coordinate.longitude),
                                                     span: MKCoordinateSpan.init(latitudeDelta: 0.04, longitudeDelta: 0.04)),animated: true)
        }
        
        public func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            mapView.setRegion(MKCoordinateRegion.init(center: CLLocationCoordinate2D.init(latitude: view.annotation!.coordinate.latitude,
                                                                                          longitude: view.annotation!.coordinate.longitude),
                                                     span: MKCoordinateSpan.init(latitudeDelta: 0.04, longitudeDelta: 0.04)),animated: true)
            for i in 0 ..< SuggestedLocation.sampleLocations.count {
                if SuggestedLocation.sampleLocations[i].coordinate.latitude == view.annotation?.coordinate.latitude {
                    self.mapView.currentLocation = SuggestedLocation.sampleLocations[i]
                }
            }
        }
    }
}

// HELPER FUNCTIONS
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

extension MapView {

}

