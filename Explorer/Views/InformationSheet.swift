//
//  InformationSheet.swift
//  Explorer
//
//  Created by Tommy Phat Nhu Truong on 4/12/23.
//

import SwiftUI

struct InformationSheet: View {
    @State var currentSuggestedLocation: SuggestedLocation
    var body: some View {
        VStack {
            Text(currentSuggestedLocation.name)
                .bold()
                .font(.largeTitle)
            Text(currentSuggestedLocation.coordinate.longitude.description)
            Text(currentSuggestedLocation.coordinate.latitude.description)
        }
    }
}

struct InformationSheet_Previews: PreviewProvider {
    static var previews: some View {
        InformationSheet(currentSuggestedLocation: SuggestedLocation.sampleLocations[0])
    }
}
