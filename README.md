# SwiftUIPolygonGeofence

[![HitCount](http://hits.dwyl.com/zpg6/SwiftUIPolygonGeofence.svg)](http://hits.dwyl.com/zpg6/SwiftUIPolygonGeofence)

After struggling through the documentation on this one, I thought I'd share my attempt to bring Geofencing to SwiftUI.
*Excuse a less than perfect Swift Package.* It's my first, but gotta start somewhere!

### Accepting new Issues with this package from anyone looking to contribute.


SwiftUIPolygonGeofence V1.0.9
----------

![SwiftUIPolygonGeofence](https://raw.githubusercontent.com/zpg6/SwiftUIPolygonGeofence/master/src/screen1-mockup.png)

![SwiftUIPolygonGeofence](https://raw.githubusercontent.com/zpg6/SwiftUIPolygonGeofence/master/src/screen2-mockup.png)

![SwiftUIPolygonGeofence](https://raw.githubusercontent.com/zpg6/SwiftUIPolygonGeofence/master/src/screen3-mockup.png)



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

```Your App --> Target - Your App --> Signing and Capabilities --> Add Capability --> Background Modes --> Location Updates```

Add key ```Privacy - Location When In Use Usage Description``` (and an actual description as the value) to your Info.plist


For example implementation see ```Sources/Views/ExampleView.swift```


Installation
----------

### Swift Package Manager

Xcode 11 includes support for Swift Package Manager. In order to add SwiftUIPolygonGeofence to your project in Xcode 11, from the File menu select Swift Packages and then select Add Package Dependency.

A dialogue will request the package repository URL which is:

```
https://github.com/zpg6/SwiftUIPolygonGeofence
```

After verifying the URL, Xcode will prompt you to select whether to pull a specific branch, commit or versioned release into your project.



Known
----------

Would love some help getting the inside/outside detection more accurate. 
Using a built in method with CGPoint because MKPolygons and MKOverlays are just the worst. 

