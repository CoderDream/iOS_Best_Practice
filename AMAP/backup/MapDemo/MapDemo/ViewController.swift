//
//  ViewController.swift
//  MapDemo
//
//  Created by CoderDream on 2019/3/7.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MAMapViewDelegate, AMapSearchDelegate {

    var mapView: MAMapView!
    var search: AMapSearchAPI!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Swift Demo"
        
        AMapServices.shared().apiKey = "6560fba37fc52d7e16bd3399ae4b89ca" // APIKey
        initMapView()
        initSearch()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = MAUserTrackingMode.follow
    }
    
    func initMapView() {
        mapView = MAMapView(frame: self.view.bounds)
        mapView.delegate = self
        self.view.addSubview(mapView!)
    }
    
    func initSearch() {
        //        AMap
        search = AMapSearchAPI()
        search.delegate = self // as! AMapSearchDelegate // as! AMapSearchDelegate
    }
}

