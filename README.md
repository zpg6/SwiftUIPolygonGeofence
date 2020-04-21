# SwiftUIPolygonGeofence

After struggling through the documentation on this one, I thought I'd share my attempt to bring Geofencing to SwiftUI.
*Excuse a less than perfect Swift Package.* It's my first, but gotta start somewhere!

### Accepting new Issues with this package from anyone looking to contribute.


SwiftUIPolygonGeofence V1.0.0
----------

![SwiftUIPolygonGeofence](https://raw.githubusercontent.com/zpg6/SwiftUIPolygonGeofence/master/src/screen1.png)

![SwiftUIPolygonGeofence](https://raw.githubusercontent.com/zpg6/SwiftUIPolygonGeofence/master/src/screen2.png)



Features
----------
- Geofencing with complex polygons.
- Draw a geofence similar to how you would use the photoshop pen tool.
- Double tap or long press points to remove them.
- Switch between zooming/panning the map and drawing points.
- The resulting polygon can be checked to see if a User's location lies within the fence
- No dependencies (Only CoreGraphics, MapKit, SwiftUI, & Foundation)


Usage
----------

See Sources/Views/ExampleView.swift


Installation
----------

### Swift Package Manager

Xcode 11 includes support for Swift Package Manager. In order to add Connectivity to your project in Xcode 11, from the File menu select Swift Packages and then select Add Package Dependency.

A dialogue will request the package repository URL which is:

```
https://github.com/zpg6/SwiftUIPolygonGeofence
```

After verifying the URL, Xcode will prompt you to select whether to pull a specific branch, commit or versioned release into your project.



Bugs in V1.0.0
----------

Would love some help getting the inside/outside detection more accurate. 
Using a built in method with CGPoint because MKPolygons and MKOverlays are just the worst. 

