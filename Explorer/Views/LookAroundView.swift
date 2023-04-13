//
//  LookAroundView.swift
//  Explorer
//
//  Created by Tommy Phat Nhu Truong on 4/13/23.
//

import Foundation
import SwiftUI
import MapKit
import CoreLocation

struct LookAroundView: UIViewControllerRepresentable {
    
    @Binding var suggestedLocation: SuggestedLocation
    @Binding var hasLookAroundScene: Bool
        
    func makeUIViewController(context: Context) -> MKLookAroundViewController {
        let vc = MKLookAroundViewController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: MKLookAroundViewController, context: Context) {
        let sceneRequest = MKLookAroundSceneRequest(coordinate: suggestedLocation.coordinate)
        sceneRequest.getSceneWithCompletionHandler {  scene, error in
            if let error {
                print(error.localizedDescription)
            }
            else if let scene {
                uiViewController.scene = scene
                hasLookAroundScene = true
            }
            else if scene == nil && error == nil {
                hasLookAroundScene = false
            }
         }
        
    }
    

}
