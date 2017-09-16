//
//  MapViewController.swift
//  Salemize
//
//  Created by Ebrahim Tahernejad on 9/15/17.
//  Copyright © 2017 Ebi :). All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, OverlayViewDelegate {
    func overlayCloseSelected() {
        self.navigationController?.setViewControllers([MainViewController(), self], animated: false)
        self.navigationController?.popViewController(animated: true)
    }
    
    func overlayStartSelected(type: OverlayViewValueType, value: Int) {
        UIView.animate(withDuration: 0.2, animations: {
            self.overlayView.alpha = 0
        }) { (myBool) in
            self.overlayView.removeFromSuperview()
            // kara ro bokon azizam
        }
    }
    

    var mapView: GMSMapView!
    var overlayView: OverlayView!
    var taskInfoView: UIView!
    var estimatedTimeTitle: UILabel!
    var estimatedTimeValue: UILabel!
    var seperator: UIView!
    var coinsIcon: UIImageView!
    var coinsValue: UILabel!
    var treasureIcon: UIImageView!
    var treasureValue: UILabel!
    var distanceIcon: UIImageView!
    var distanceValue: UILabel!
    var endTaskButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.endEditing(true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        super.loadView()
        
        self.overlayView = OverlayView()
        self.overlayView.delegate = self
        
        taskInfoView = UIView()
        taskInfoView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 145)
        taskInfoView.backgroundColor = SMColor(name: .white)
        taskInfoView.layer.shadowColor = SMColor(name: .black).cgColor
        taskInfoView.layer.shadowOpacity = 0.08
        taskInfoView.layer.shadowRadius = 19
        taskInfoView.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        estimatedTimeTitle = UILabel()
        estimatedTimeTitle.text = SMLocalized("SM.Map.Titles.EstimatedTime")
        estimatedTimeTitle.textAlignment = .right
        estimatedTimeTitle.textColor = SMColor(name: .gray)
        estimatedTimeTitle.font = SMFont.medium(12)
        estimatedTimeTitle.sizeToFit()
        
        estimatedTimeValue = UILabel()
        estimatedTimeValue.frame.size = CGSize(width: 70, height: 31)
        estimatedTimeValue.text = SMLocalized("SM.Map.Values.EstimatedTime", replaces: "۱۶")
        estimatedTimeValue.textAlignment = .left
        estimatedTimeValue.font = SMFont.medium(14)
        
        seperator = UIView()
        seperator.frame.size = CGSize(width: self.view.frame.size.width, height: 1)
        seperator.backgroundColor = SMColor(name: .separatorColor, alpha: 0.15)
        
        coinsIcon = UIImageView()
        coinsIcon.image = UIImage(named: "coins")
        coinsIcon.frame.size = CGSize(width: 25, height: 22)
        coinsIcon.contentMode = .scaleAspectFit
        
        coinsValue = UILabel()
        coinsValue.text = "۷۸/۱۵۰"
        coinsValue.textAlignment = .right
        coinsValue.font = SMFont.medium(14)
        coinsValue.textColor = SMColor(name: .black)
        coinsValue.sizeToFit()
        
        treasureIcon = UIImageView()
        treasureIcon.image = UIImage(named: "treasure")
        treasureIcon.frame.size = CGSize(width: 28, height: 30)
        treasureIcon.contentMode = .scaleAspectFit
        
        treasureValue = UILabel()
        treasureValue.text = "۱/۲"
        treasureValue.textAlignment = .right
        treasureValue.font = SMFont.medium(14)
        treasureValue.textColor = SMColor(name: .black)
        treasureValue.sizeToFit()
        
        distanceIcon = UIImageView()
        distanceIcon.image = UIImage(named: "distance")
        distanceIcon.frame.size = CGSize(width: 21, height: 30)
        distanceIcon.contentMode = .scaleAspectFit
        
        distanceValue = UILabel()
        distanceValue.text = "۵۱۵/۱۰۱۳ متر"
        distanceValue.textAlignment = .right
        distanceValue.font = SMFont.medium(14)
        distanceValue.textColor = SMColor(name: .black)
        distanceValue.sizeToFit()
        
        endTaskButton = UIButton()
        endTaskButton.layer.cornerRadius = 8
        endTaskButton.backgroundColor = SMColor(name: .endTaskColor)
        endTaskButton.frame.size = CGSize(width: 235, height: 50)
        endTaskButton.setTitle(SMLocalized("SM.Map.Titles.EndTask"), for: .normal)
        endTaskButton.titleLabel?.font = SMFont.medium(16)
        endTaskButton.setTitleColor(SMColor(name: .white), for: .normal)
        endTaskButton.addTarget(self, action: #selector(buttonActions(_:)), for: .touchUpInside)
        endTaskButton.tag = 1
        
        initMap()
        
        self.view.addSubview(taskInfoView)
        self.view.addSubview(estimatedTimeTitle)
        self.view.addSubview(estimatedTimeValue)
        self.view.addSubview(seperator)
        self.view.addSubview(coinsIcon)
        self.view.addSubview(coinsValue)
        self.view.addSubview(treasureIcon)
        self.view.addSubview(treasureValue)
        self.view.addSubview(distanceIcon)
        self.view.addSubview(distanceValue)
        self.view.addSubview(endTaskButton)
        self.view.addSubview(overlayView)
    }
    
    func initMap(){
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
    }
    
    override func viewDidLayoutSubviews() {
        if isViewLoaded && mapView != nil {
            mapView.frame = self.view.bounds
        }
        self.overlayView.frame = self.view.bounds
        self.seperator.frame.origin.y = 89
        self.estimatedTimeTitle.frame.origin = .init(x: self.view.frame.size.width - self.estimatedTimeTitle.frame.size.width - 10, y: 60)
        self.estimatedTimeValue.frame.origin = .init(x: 10, y: 51)
        self.coinsIcon.frame.origin = .init(x: self.view.frame.size.width - 10 - coinsIcon.frame.size.width, y: 106)
        self.coinsValue.frame.origin = .init(x: self.view.frame.size.width - 45 - coinsValue.frame.size.width, y: 110)
        self.treasureIcon.frame.origin = .init(x: self.view.frame.size.width - 140 - treasureIcon.frame.size.width, y: 102)
        self.treasureValue.frame.origin = .init(x: self.view.frame.size.width - 178 - treasureValue.frame.size.width, y: 109)
        self.distanceIcon.frame.origin = .init(x: 110, y: 102)
        self.distanceValue.frame.origin = .init(x: 23, y: 109)
        
        self.endTaskButton.center.x = self.view.center.x
        self.endTaskButton.frame.origin.y = self.view.frame.size.height - endTaskButton.frame.size.height - 20
    }
    
    @objc func buttonActions(_ sender: UIButton) {
        switch sender.tag {
        case 1: // go Back !
            self.navigationController?.setViewControllers([MainViewController(), self], animated: false)
            self.navigationController?.popViewController(animated: true)
            break
        default:
            break
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIApplication.shared.statusBarStyle = .default
        
    }
    
}
