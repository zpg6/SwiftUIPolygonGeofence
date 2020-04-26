//
//  HelperDrawingViews.swift
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

struct PointTapView : View {
    @Binding var points:[CGPoint]
    @Binding var canPlot: Bool
    @Binding var locations: [MKMapPoint]
    @Binding var map: MKMapView
    
    var body: some View {
        ZStack (alignment: .topTrailing) {
            if self.canPlot {
                ZStack(alignment: .topLeading) {
                    Background { location in
                        if self.canPlot && self.points.count < 50 {
                            self.points.append(CGPoint(x: location.x + 25, y: location.y + 25))
                            let newMP = MKMapPoint( self.map.convert(location, toCoordinateFrom: self.map) )
                            self.locations.append(newMP)
                        }
                    }
                    PathView(points: self.$points)
                    PointView(points: self.$points, locations: self.$locations, map: self.$map)
                }
                MapButton(title: "Undo Point", icon: "arrow.counterclockwise") {
                    self.points = self.points.dropLast()
                    self.locations = self.locations.dropLast()
                    NotificationCenter.default.post(name: NSNotification.Name("newNotification"), object: nil)
                }
            }
            else {
                ZStack {
                    if self.points.count > 0 {
                        PathView(points: self.$points)
                    }
                    PointView(points: self.$points, locations: self.$locations, map: self.$map)
                }.opacity(0.3)
            }
        }
    }
}


struct Background : UIViewRepresentable {
    var tappedCallback: ((CGPoint) -> Void)

    func makeUIView(context: UIViewRepresentableContext<Background>) -> UIView {
        let v = UIView(frame: .zero)
        let gesture = UITapGestureRecognizer(target: context.coordinator,
                                             action: #selector(Coordinator.tapped))
        v.addGestureRecognizer(gesture)
        return v
    }

    class Coordinator: NSObject {
        var tappedCallback: ((CGPoint) -> Void)
        init(tappedCallback: @escaping ((CGPoint) -> Void)) {
            self.tappedCallback = tappedCallback
        }
        @objc func tapped(gesture:UITapGestureRecognizer) {
            let point = gesture.location(in: gesture.view)
            self.tappedCallback(point)
        }
    }

    func makeCoordinator() -> Background.Coordinator {
        return Coordinator(tappedCallback:self.tappedCallback)
    }

    func updateUIView(_ uiView: UIView,
                       context: UIViewRepresentableContext<Background>) {
    }

}
