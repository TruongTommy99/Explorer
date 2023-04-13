//
//  ViewModifier.swift
//  Explorer
//
//  Created by Tommy Phat Nhu Truong on 4/13/23.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove:Bool = false) -> some View {
        if hidden {
                if !remove {
                    withAnimation {
                        self.hidden()
                    }
                }
            } else {
                withAnimation {
                    self
                }
            }
    }
}
