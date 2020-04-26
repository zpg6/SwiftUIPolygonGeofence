//
//  HelperDisplayViews.swift
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

struct MapButton: View {
    
    var title: String
    var icon: String
    var action: ()->Void
    
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            HStack (spacing: 8) {
                Text(title).foregroundColor(.primary)
                Image(systemName: icon)
                .resizable()
                .frame(width:20, height:22.5, alignment: .center)
                .foregroundColor(.primary)
            }
            .padding(15)
        }.background(
            Color(.systemBackground)
                .opacity(0.3)
                .clipShape(Capsule())
        )
        .padding(15)
    }
}


struct PointView: View {
    
    @Binding var points: [CGPoint]
    @Binding var locations: [MKMapPoint]
    @Binding var map: MKMapView
    
    var body: some View {
        ForEach(0..<self.points.count, id: \.self) { point in
            ZStack {
                Color.red
                    .frame(width:50, height:50, alignment: .center)
                    .clipShape(Circle())
                Image(systemName: "\(point+1).circle")
                    .resizable()
                    .frame(width:40, height:40, alignment: .center)
                    .foregroundColor(.white)
                    
            }.position(x: self.points[point].x, y: self.points[point].y)
            .gesture(DragGesture().onChanged({ value in
                self.points[point] = value.location
                self.locations[point] = MKMapPoint(  self.map.convert(value.location, toCoordinateFrom: self.map)  )
            }))
            .onLongPressGesture {
                self.points.remove(at: point)
                self.locations.remove(at: point)
            }
            .onTapGesture (count: 2) {
                self.points.remove(at: point)
                self.locations.remove(at: point)
            }
        }
    }
    
    
}

struct PathView: View {
    
    @Binding var points: [CGPoint]
    
    var body: some View {
        ZStack (alignment: .center) {
            if self.points.count >= 2 {
                Path { path in
                    path.move(to: self.points.first!)
                    for pnt in 1..<self.points.count {
                        path.addLine(to: points[pnt])
                    }
                }
                .fill(Color.green.opacity(0.4))
                
                Path { path in
                    path.move(to: self.points.first!)
                    for pnt in 1..<self.points.count {
                        path.addLine(to: points[pnt])
                        if pnt == self.points.count - 1 {
                            path.addLine(to: points[0])
                        }
                    }
                }
                .stroke(Color.green, lineWidth: 3)
            }
        }
    }
    
    
}

