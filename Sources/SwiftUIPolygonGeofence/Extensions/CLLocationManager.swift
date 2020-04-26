//
//  CLLocationManager.swift
//  
//
//  Created by Zachary Grimaldi on 4/21/20.
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

extension CLLocationManager {
    func isInsideFence(points: Binding<[CGPoint]>, locations: Binding<[MKMapPoint]>, map: MKMapView) -> Bool {
        let coor = self.location?.coordinate ?? nil
        if coor != nil && locations.wrappedValue.count > 0 {
            let polygon = MKPolygon(coordinates: locations.wrappedValue.map({$0.coordinate}), count: locations.wrappedValue.count)
            return polygon.containsCoor(coor: coor!)
        }
        else {
            return false
        }
    }
}
