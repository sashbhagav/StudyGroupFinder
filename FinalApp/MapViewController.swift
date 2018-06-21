//
//  MapViewController.swift
//  FinalApp
//
//  Created by Sashreek Bhagavatula on 5/8/18.
//  Copyright © 2018 Sashreek Bhagavatula. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase
import GeoFire

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    

    @IBOutlet var mapViewKit: MKMapView!
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var dbReference: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dbReference = Database.database().reference()
        let geoFire = GeoFire(firebaseRef: dbReference!)
        mapViewKit.delegate = self
        mapViewKit.showsScale = true
        mapViewKit.showsUserLocation = true
        mapViewKit.showsPointsOfInterest = true
        mapViewKit.isZoomEnabled = true
        
        
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            print(location.coordinate)
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied){
            
        }
    }
    
    func showLocationDisabledPopUp(){
        let alertController = UIAlertController(title: "Location is Disable", message: "To start a study group we need your location", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default){ (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        self.present(alertController, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
