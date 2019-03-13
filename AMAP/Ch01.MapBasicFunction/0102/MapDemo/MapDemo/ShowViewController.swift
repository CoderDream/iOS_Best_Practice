//
//  ShowViewController.swift
//  MapDemo
//
//  Created by CoderDream on 2019/3/13.
//  Copyright © 2019 CoderDream. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController ,MAMapViewDelegate{
    
    var latitude = 0.0;
    var longitude = 0.0;
    
    var mapView: MAMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView = MAMapView(frame: self.view.bounds);
        self.mapView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth , UIView.AutoresizingMask.flexibleHeight];
        self.view.addSubview(mapView);
        
        //改变地图中心点
        self.mapView.centerCoordinate = CLLocationCoordinate2D.init(latitude: latitude, longitude: longitude);
        
        // Do any additional setup after loading the view.
    }
    
    
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
