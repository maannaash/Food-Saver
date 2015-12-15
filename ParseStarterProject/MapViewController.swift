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

        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor(patternImage: UIImage(named: "fbg1.png")!),
            NSFontAttributeName : UIFont(name: "Futura", size: 20)!
        ]
       
        let latitude:CLLocationDegrees = userLatitude
        let longitude:CLLocationDegrees = userLongitude
        let latitudeDelta:CLLocationDegrees = 0.2
        let longtitudeDelta:CLLocationDegrees = 0.2
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latitudeDelta, longtitudeDelta)
        let userlocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(userlocation, span)
        
        map.setRegion(region, animated: true)
        
        var annotation = MKPointAnnotation()
        
        annotation.coordinate = userlocation
        annotation.title = "My Location"
        
        map.addAnnotation(annotation)
        
        
       // var annview:MKAnnotationView = MKAnnotationView()
       // annview.annotation = annotation
       // annview.image = UIImage(named: "home.png")
       // annview.canShowCallout = true
       // annview.enabled = true
        
        var allLocations = [CLLocationCoordinate2D]()
        
        for var i = 0; i < alllatitude.count; i++ {
            
            allLocations.append(CLLocationCoordinate2DMake(alllatitude[i], alllongitude[i]))
            
        }
       
        if allLocations.count > 0{
            for xlocation in allLocations {
             var annot = MKPointAnnotation()
                annot.coordinate = xlocation
                annot.title = "Extra Food"
                map.addAnnotation(annot)
                
            }
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
