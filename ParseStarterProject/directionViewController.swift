//
//  directionViewController.swift
//  Food Saver
//
//  Created by Manash Taunk on 12/14/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import MapKit



class directionViewController: UIViewController, CLLocationManagerDelegate  {

    
    var locationmanager : CLLocationManager  = CLLocationManager()
    
    @IBOutlet var directionMap: MKMapView!
    
    @IBOutlet var directionText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.tintColor = UIColor(colorLiteralRed: 255, green: 247, blue: 233, alpha: 100)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor(colorLiteralRed: 255, green: 247, blue: 233, alpha: 100),
            NSFontAttributeName : UIFont(name: "Futura", size: 20)!
        ]
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        
        let imgView = UIImageView(frame: CGRectMake(0, 0, width, height))
        imgView.image = UIImage(named: "fbg1.png")!
        imgView.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(imgView)
        self.view.sendSubviewToBack(imgView)
        /* destination
        var alllatitude = [CLLocationDegrees]()
        var alllongitude = [CLLocationDegrees]()
        */
        
        /* user location
        userLatitude
        userLongitude
        */
        
        
        //self.directionMap.delegate = self
        
        
        

        let srcloc:CLLocationCoordinate2D = CLLocationCoordinate2DMake(userLatitude, userLongitude)
        let srcplcmrk = MKPlacemark(coordinate: srcloc, addressDictionary: nil)
        //var sourceMapItem = MKMapItem(placemark: srcplcmrk)
        
        print(userLatitude)
        print(userLongitude)
        let destloc:CLLocationCoordinate2D = CLLocationCoordinate2DMake(alllatitude[currentIndex], alllongitude[currentIndex])
        let destplcmrk = MKPlacemark(coordinate: destloc, addressDictionary: nil)
        let destMapItem = MKMapItem(placemark: destplcmrk)
        
        
        
        let request:MKDirectionsRequest = MKDirectionsRequest()
        request.source = MKMapItem.mapItemForCurrentLocation()
        request.destination = destMapItem
        request.transportType = .Automobile
        request.requestsAlternateRoutes = false
        
        var directionSteps = ""
        let directions:MKDirections = MKDirections(request: request)
        directions.calculateDirectionsWithCompletionHandler { (response, error ) -> Void in
            
            if error != nil {
                print(error)
            }else {
                
                
                
                let latitudeDelta:CLLocationDegrees = 0.2
                let longtitudeDelta:CLLocationDegrees = 0.2
                let span:MKCoordinateSpan = MKCoordinateSpanMake(latitudeDelta, longtitudeDelta)
                let region:MKCoordinateRegion = MKCoordinateRegionMake(srcloc, span)
                
                self.directionMap.setRegion(region, animated: true)
                
                var annotation = MKPointAnnotation()
                annotation.coordinate = srcloc
                annotation.title = "My Location"
                self.directionMap.addAnnotation(annotation)
                
                
                var annot = MKPointAnnotation()
                annot.coordinate = destloc
                annot.title = "Destination"
                self.directionMap.addAnnotation(annot)
                
                //let overlays = self.directionMap.overlays
               // self.directionMap.removeOverlay(overlays)
                for route in (response?.routes)! {
                    
                    self.directionMap.addOverlay(route.polyline, level: MKOverlayLevel.AboveRoads)
                    
                    for next in route.steps{
                        
                       // self.directionText.text = self.directionText.text) + String(next.instructions)
                        
                        
                        var eachline = "-> " + next.instructions
                        
                        directionSteps = directionSteps + " " + eachline + "\n"

                        //print(next.instructions)
                        //print(directionSteps)
                    }
                }
                print(directionSteps)
                self.directionText.text = directionSteps
            }
        }
        
        
    
    
        
        
        
        // Do any additional setup after loading the view.
    }

    
    func showRoute(response : MKDirectionsResponse) {
        for route in response.routes as! [MKRoute] {
            
            self.directionMap.showsUserLocation = true
            directionMap.addOverlay(route.polyline,level: MKOverlayLevel.AboveRoads)
        }
        
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay
        overlay: MKOverlay!) -> MKOverlayRenderer! {
            let renderer = MKPolylineRenderer(overlay: overlay)
            
            renderer.strokeColor = UIColor.purpleColor()
            renderer.lineWidth = 3.0
            return renderer
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
