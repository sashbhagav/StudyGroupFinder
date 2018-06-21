//
//  CreateViewController.swift
//  FinalApp
//
//  Created by Sashreek Bhagavatula on 5/15/18.
//  Copyright © 2018 Sashreek Bhagavatula. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MapKit
import GeoFire

class CreateViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var nameField: UITextField!
    @IBOutlet var subjectField: UITextField!
    @IBOutlet var campusField: UITextField!
    @IBOutlet var buildingField: UITextField!
    @IBOutlet var findName: UITextField!
    @IBOutlet var findSubject: UITextField!
    
    var dbReference: DatabaseReference?
    var dbHandle: DatabaseHandle?
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }
    
    @IBAction func createButtonPressed(_ sender: Any) {
        let name = nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let subject = subjectField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let campus = campusField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let building = buildingField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
    
        dbReference = Database.database().reference().child("users").childByAutoId()
        
        dbReference?.child("Name").setValue(name)
        dbReference?.child("Subject").setValue(subject)
        dbReference?.child("On Campus?").setValue(campus)
        dbReference?.child("Which building?").setValue(building)
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            let geoFire = GeoFire(firebaseRef: dbReference!)
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            currentLocation = locationManager.location
            let longitude = currentLocation.coordinate.longitude
            let latitude = currentLocation.coordinate.latitude
            let longitudeCreate = String(longitude)
            let latitudeCreate = String(latitude)
            //dbReference = Database.database().reference().childByAutoId()
            dbReference?.child("Longitude").setValue(longitudeCreate)
            dbReference?.child("Latitude").setValue(latitudeCreate)
           
            
        }
        
  


       
    }
    
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
