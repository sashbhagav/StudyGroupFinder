//
//  FindViewController.swift
//  FinalApp
//
//  Created by Sashreek Bhagavatula on 5/8/18.
//  Copyright © 2018 Sashreek Bhagavatula. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MapKit

class FindViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var dbReference: DatabaseReference?
    var dbHandle: DatabaseHandle?
    let locationManager = CLLocationManager()
    var currentLocationFind: CLLocation!
    
    @IBOutlet var findName: UITextField!
    @IBOutlet var findSubject: UITextField!
    @IBOutlet var findCampus: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    @IBAction func findButton(_ sender: Any) {
        let nameFind =  findName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        findSubject.delegate = self as? UITextFieldDelegate
        let subjectFind: String = findSubject.text!
        findCampus.delegate = self as? UITextFieldDelegate
        let campusFind: String = findCampus.text!
        
        dbReference = Database.database().reference()
        
        dbReference?.child("users").observe(.childAdded, with: { (snapshot) in
            let value = snapshot.value as! [String:Any]
            let subject = value["Subject"] as? String ?? ""
            let name = value["Name"] as? String ?? ""
            let latitude = value["Latitude"] as? String ?? ""
            let longitude = value["Longitude"] as? String ?? ""
            let campus = value["On Campus?"] as? String ?? ""
        
            if(subjectFind==subject) && (campusFind == campus){
                print("Those with the same subject are:  ", name)
                let longitudeFind = Double(longitude)
                let latitudeFind = Double(latitude)
               
                self.locationManager.requestAlwaysAuthorization()
                self.locationManager.requestWhenInUseAuthorization()
                if CLLocationManager.locationServicesEnabled(){
                    self.locationManager.delegate = self
                    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                    self.locationManager.startUpdatingLocation()
                    self.currentLocationFind = self.locationManager.location
                    
                    let latitude:CLLocationDegrees = latitudeFind!
                    let longitude:CLLocationDegrees = longitudeFind!
                    print("long is ", longitude)
                    print("lat is ", latitude)
                    let regionDistance:CLLocationDistance = 1000
                    let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
                    let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
                    
                    let options = [MKLaunchOptionsMapCenterKey:NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
                    let placemark = MKPlacemark(coordinate: coordinates)
                    let mapItem = MKMapItem(placemark: placemark)
                   
                    mapItem.name = "Study Group"
                    mapItem.openInMaps(launchOptions: options)
                    
                    
                }
                
                
            }
        
        
        })
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
