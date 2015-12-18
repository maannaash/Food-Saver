//
//  MapViewController.swift
//  Food Saver
//
//  Created by Manash Taunk on 12/8/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        self.map.delegate = self
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor(colorLiteralRed: 255, green: 247, blue: 233, alpha: 100),
            NSFontAttributeName : UIFont(name: "Futura", size: 20)!
        ]
        
        self.navigationController?.navigationBar.tintColor = UIColor(colorLiteralRed: 255, green: 247, blue: 233, alpha: 100)
       
        let latitude:CLLocationDegrees = userLatitude
        let longitude:CLLocationDegrees = userLongitude
        let latitudeDelta:CLLocationDegrees = 0.2
        let longtitudeDelta:CLLocationDegrees = 0.2
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latitudeDelta, longtitudeDelta)
        let userlocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(userlocation, span)
        
        map.setRegion(region, animated: true)
        
        var annotation = ColorPointAnnotation(pinColor: UIColor.blueColor())
        
        annotation.coordinate = userlocation
        annotation.title = "My Location"
    
      
        map.addAnnotation(annotation)
        
        var allLocations = [CLLocationCoordinate2D]()
        var fdtitle = [String]()
        var fstatus = [String]()
        
        allLocations.removeAll(keepCapacity: true)
        fdtitle.removeAll(keepCapacity: true)
        
        for var i = 0; i < alllatitude.count; i++ {
            print(i)
            print("locaions count - " + String(alllatitude.count))
            print("foodname count - " + String(foodname.count))
            
            allLocations.append(CLLocationCoordinate2DMake(alllatitude[i], alllongitude[i]))
            fdtitle.append(foodname[i])
            fstatus.append(foodstatus[i])
            
            //fdtitle.setValue(foodname[i], forKey: String(alllatitude[i]))
            
        }
       
        if allLocations.count > 0{
            for xlocation in allLocations {
         //    var annot = ColorPointAnnotation(pinColor: UIColor.redColor())
                var annot = MKPointAnnotation()
                
                
                for var m = 0; m < allLocations.count; m++ {

                if String(allLocations[m]) == String(xlocation){
                    
                    if fstatus[m] == "Available"{
                        annot = ColorPointAnnotation(pinColor: UIColor.greenColor())
                    }else{
                        annot = ColorPointAnnotation(pinColor: UIColor.orangeColor())
                    }
                    annot.title = fdtitle[m]
                    annot.subtitle = "Status: " + fstatus[m]
                    }
                }
                annot.coordinate = xlocation
                
               // annot.title = String(fdtitle.objectForKey(sloc))
                
                
                map.addAnnotation(annot)
                
            }
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            //return nil so map view draws "blue dot" for standard user location
            return nil
        }
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            let colorPointAnnotation = annotation as! ColorPointAnnotation
            pinView?.pinTintColor = colorPointAnnotation.pinColor
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    class ColorPointAnnotation: MKPointAnnotation {
        var pinColor: UIColor
        
        init(pinColor: UIColor) {
            self.pinColor = pinColor
            super.init()
        }
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
