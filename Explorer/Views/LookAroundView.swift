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
        
    func makeUIViewController(context: Context) -> MKLookAroundViewController {
        
        let vc = MKLookAroundViewController()
        let sceneRequest = MKLookAroundSceneRequest(coordinate: suggestedLocation.coordinate)
        sceneRequest.getSceneWithCompletionHandler {  scene, error in
            if let error {
                print("NO SCENE")
                print(error.localizedDescription)
            }
            else if let scene {
                print("THERE IS A SCENE")
                vc.scene = scene
            }
         }
        
        return vc
    }
    
    
    func updateUIViewController(_ uiViewController: MKLookAroundViewController, context: Context) {
        let sceneRequest = MKLookAroundSceneRequest(coordinate: suggestedLocation.coordinate)
        sceneRequest.getSceneWithCompletionHandler {  scene, error in
            if let error {
                print("NO SCENE")
                print(error.localizedDescription)
                uiViewController.badgePosition = .topLeading
            }
            else if let scene {
                print("THERE IS A SCENE")
                uiViewController.scene = scene
            }
            else if scene == nil && error == nil {
                print("WELP, nothing")
            }
         }
        
    }
    

}
