//
//  MKPolygon.swift
//  
//
//  Created by Zachary Grimaldi on 4/21/20.
//

import Foundation
import SwiftUI
import MapKit
import CoreGraphics

extension MKPolygon {
    func containsCoor(coor: CLLocationCoordinate2D) -> Bool {
        let polygonRenderer = MKPolygonRenderer(polygon: self)
        let currentMapPoint: MKMapPoint = MKMapPoint(coor)
        let polygonViewPoint: CGPoint = polygonRenderer.point(for: currentMapPoint)
        if polygonRenderer.path == nil {
          return false
        }else{
          return polygonRenderer.path.contains(polygonViewPoint)
        }
    }
}


