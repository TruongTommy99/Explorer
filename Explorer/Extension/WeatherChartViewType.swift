//
//  WeatherChartViewType.swift
//  Explorer
//
//  Created by Tommy Truong on 4/18/23.
//

import Foundation
import SwiftUI

enum WeatherChartViewType: String,Equatable, CaseIterable {
    case Minute
    case Hourly
    case Daily
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}
