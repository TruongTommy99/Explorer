//
//  VisualEffectView.swift
//  Explorer
//
//  Created by Tommy Phat Nhu Truong on 4/14/23.
//

import SwiftUI

struct VisualEffectView: UIViewRepresentable {
    
    let effect : UIVisualEffect?
    
    init(_ effect: UIVisualEffect){
        self.effect = effect
    }
    
    init(_ style: UIBlurEffect.Style) {
        self.init(UIBlurEffect(style: style))
    }
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView()
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = self.effect
    }
}
