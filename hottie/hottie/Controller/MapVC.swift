//
//  ViewController.swift
//  hottie
//
//  Created by Louis Régis on 19.03.18.
//  Copyright © 2018 Louro. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController {

    @IBOutlet weak var communityMap: MKMapView!
    
    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 500

    
    override func viewDidLoad() {
        super.viewDidLoad()
        communityMap.delegate = self
        locationManager.delegate = self
        communityMap.showsUserLocation = true
        configureLocationServices()
    }

    @IBAction func profileView(_ sender: Any) {
    }
    
    @IBAction func communityView(_ sender: Any) {
    }
    
    @IBAction func cameraBtnWasPressed(_ sender: Any) {
        performSegue(withIdentifier: "segueToCamera", sender: self)
    }
    
}

extension MapVC: MKMapViewDelegate {
    func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, regionRadius * 2.0, regionRadius * 2.0)
        communityMap.setRegion(coordinateRegion, animated: true)
    }
}

extension MapVC: CLLocationManagerDelegate {
    func configureLocationServices() {
        if authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapOnUserLocation()
    }
}
