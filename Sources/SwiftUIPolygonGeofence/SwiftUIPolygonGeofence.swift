//
//  SwiftUIGeofence.swift
//
//  Created by Zachary Grimaldi on 4/20/20.
//  Copyright © 2020 Zachary Grimaldi. All rights reserved.
//

#if canImport(Foundation)
    import Foundation
#endif
#if canImport(SwiftUI)
    import SwiftUI
#endif
#if canImport(MapKit)
    import MapKit
#endif
#if canImport(CoreGraphics)
    import CoreGraphics
#endif


struct SwiftUIPolygonGeofence: View {
    @Binding var show: Bool
    @State var alert = false
    @State var canPlot = true
    @State var canDrag = false
    @Binding var points: [CGPoint]
    @Binding var locations: [MKMapPoint]
    @State var locManager: CLLocationManager = CLLocationManager()
    @State var map = MKMapView()
    
    var body: some View {

        ZStack (alignment: .bottom) {
            ZStack (alignment: .topLeading) {
                ZStack {
                    GeoFenceMapView(alert: $alert, map: self.$map, locManager: self.$locManager, locations: self.$locations).edgesIgnoringSafeArea(.all).alert(isPresented: $alert) {

                        Alert(title: Text("Please Enable Location Access In Settings Pannel !!!"))
                    }
                    PointTapView(points: self.$points, canPlot: self.$canPlot, locations: self.$locations, map: self.$map)
                }
                MapButton(title: self.canPlot ? "Move Map":"Plot Points", icon: self.canPlot ? "map":"skew") {
                    self.canPlot.toggle()
                }
            }
            HStack {
                MapButton(title: self.locManager.isInsideFence(points: self.$points, locations: self.$locations, map: self.map) ? "Inside":"Outside", icon: self.locManager.isInsideFence(points: self.$points, locations: self.$locations, map: self.map) ? "checkmark":"xmark") {}
                MapButton(title: "Done", icon: "checkmark") {
                    print("📍 = \(self.locations.count)")
                    if self.locManager.isInsideFence(points: self.$points, locations: self.$locations, map: self.map) {
                        print("✅ user inside")
                    } else {
                        print("❌ not inside")
                    }
                    self.show.toggle()
                }
            }
        }
    }
}





struct GeoFenceMapView : UIViewRepresentable {

    @Binding var alert : Bool
    @Binding var map: MKMapView
    @Binding var locManager: CLLocationManager
    @Binding var locations: [MKMapPoint]

    func makeCoordinator() -> GeoFenceMapView.Coordinator {
        
        return Coordinator(parent1: self, locations: self.$locations)
    }

    func makeUIView(context: UIViewRepresentableContext<GeoFenceMapView>) -> MKMapView {


        let center = CLLocationCoordinate2D(latitude: 13.086, longitude: 80.2707)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        self.map.region = region
        self.map.showsUserLocation = true
        self.map.showsScale = true
        self.locManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locManager.allowsBackgroundLocationUpdates = true
        self.locManager.pausesLocationUpdatesAutomatically = false
        self.locManager.requestWhenInUseAuthorization()
        self.locManager.delegate = context.coordinator
        self.locManager.startUpdatingLocation()
        
        return self.map
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<GeoFenceMapView>) {}

    
    
    
    class Coordinator : NSObject,CLLocationManagerDelegate, MKMapViewDelegate {

        var parent : GeoFenceMapView
        var regionSet = false
        @Binding var locations: [MKMapPoint]

        init(parent1 : GeoFenceMapView, locations: Binding<[MKMapPoint]>) {
            parent = parent1
            _locations = locations
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

            if status == .denied{
                parent.alert.toggle()
            }
        }

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            if let center: CLLocation = locations.last {
                if !self.regionSet {
                    self.parent.map.region = MKCoordinateRegion(center: center.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                    self.regionSet = true
                }
            }
        }
    }
}



