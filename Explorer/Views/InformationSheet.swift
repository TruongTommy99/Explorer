//
//  InformationSheet.swift
//  Explorer
//
//  Created by Tommy Phat Nhu Truong on 4/12/23.
//

import SwiftUI
import CoreLocation
import WebKit

struct InformationSheet: View {
    @State var currentSuggestedLocation: SuggestedLocation
    
    @StateObject var weatherViewModel = WeatherViewModel()
    
    @State private var showWebView = false
    private let urlString = "https://www.google.com/search?q=flights+to+" 
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue,.blue,.cyan]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Text(currentSuggestedLocation.name)
                    .font(.largeTitle)
                if let data = weatherViewModel.data {
                    Text(data.currentWeather.temperature.formatted())
                        .font(.title2)
                    Text(data.currentWeather.condition.description)
                    
                    // Daily Forecast
                    VStack(alignment: .leading) {
                        Label("Hourly Forecast", systemImage: "clock")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(8)
                        Divider()
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(weatherViewModel.hourlyForecast,id :\.date) { forecast in
                                    VStack() {
                                        Text( (forecast == weatherViewModel.hourlyForecast[0]) ? "Now" : DateFormatter.localizedString(from: forecast.date, dateStyle: .none, timeStyle: .short))
                                            .font(.caption)
                                        Image(systemName: "\(forecast.symbolName)")
                                            .scaledToFit()
                                            .symbolRenderingMode(.monochrome)
                                            .frame(height: 40)
                                        Text(forecast.temperature.formatted())
                                            .fontWeight(.medium)
                                    }
                                    .padding(6)
                                }
                            }
                        }
                        // Weekly Forecast
                    }
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8,style: .circular))
                    .padding(6)
                    
                    NavigationLink("See more information") {
                        DetailedInformationSheet()
                    }
                    
                    Button("Look for a flight") {
                        self.showWebView.toggle()
                    }
                    
                    Link("Go to ", destination: URL(string: "https://www.google.com/search?q=" + currentSuggestedLocation.flag)!)
                }
                else {
                    ProgressView()
                    }
                }
            .foregroundColor(.white)
        }
        .onAppear {
            weatherViewModel.getWeather(for: CLLocation(latitude: currentSuggestedLocation.coordinate.latitude, longitude: currentSuggestedLocation.coordinate.longitude))
        }
        .sheet(isPresented: self.$showWebView) {
            WebView(url: URL(string: urlString)!)
        }
    }
}

struct InformationSheet_Previews: PreviewProvider {
    static var previews: some View {
        InformationSheet(currentSuggestedLocation: SuggestedLocation.sampleLocations[0])
    }
}

struct WebView: UIViewRepresentable {
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let urlRequest = URLRequest(url: url)
        uiView.load(urlRequest)
    }
}
