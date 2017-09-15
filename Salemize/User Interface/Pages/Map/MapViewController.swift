//
//  MapViewController.swift
//  Salemize
//
//  Created by Ebrahim Tahernejad on 9/15/17.
//  Copyright © 2017 Ebi :). All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    var mapView: GMSMapView!
    var overlayView: OverlayView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        super.loadView()
        
        self.overlayView = OverlayView()
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        do {
            mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: URL.init(fileURLWithPath: Bundle.main.path(forResource: "GMStyle", ofType: "json")!))
            self.view.addSubview(mapView)
            mapView.frame = self.view.bounds
            
            let location1 = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
            let location2 = CLLocationCoordinate2D(latitude: -32.84, longitude: 149.21)
            
            let marker1 = GMSMarker()
            marker1.position = location1
            marker1.title = "Sydney"
            marker1.snippet = "Australia"
            marker1.icon = UIImage.init(named: "marker-end")
            marker1.groundAnchor = .init(x: 0.5, y: 0.5)
            marker1.map = mapView
            
            let marker2 = GMSMarker()
            marker2.position = location2
            marker2.title = "Sydney"
            marker2.snippet = "Australia"
            marker2.icon = UIImage.init(named: "marker-me")
            marker2.groundAnchor = .init(x: 0.5, y: 0.5)
            marker2.map = mapView
            
            let polyline = GMSPolyline()
            let path = GMSMutablePath()
            
            path.add(location1)
            path.add(location2)
            polyline.spans = [GMSStyleSpan.init(style: GMSStrokeStyle.gradient(from: UIColor.init(hex: "FF005B"), to: UIColor.init(hex: "00DCFF")))]
            polyline.strokeWidth = 3.5
            
            polyline.path = path
            polyline.map = mapView
        } catch {
            
        }
        
        self.view.addSubview(overlayView)
        
    }
    
    override func viewDidLayoutSubviews() {
        if isViewLoaded && mapView != nil {
            mapView.frame = self.view.bounds
        }
        self.overlayView.frame = self.view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIApplication.shared.statusBarStyle = .default
        
    }
    
}
