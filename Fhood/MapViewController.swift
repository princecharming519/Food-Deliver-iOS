//
//  MapViewController.swift
//  Fhood
//
//  Created by Young-hu Kim on 5/17/15.
//  Copyright (c) 2015 Fhood LLC. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var Map: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var latitude : CLLocationDegrees!
    var longitude : CLLocationDegrees!
    var latDelta : CLLocationDegrees!
    var lonDelta : CLLocationDegrees!
    var span : MKCoordinateSpan!
    var location : CLLocationCoordinate2D!
    var region : MKCoordinateRegion!

    
//    @IBOutlet weak var cancelInfo: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        self.locationManager.delegate = self
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        self.locationManager.requestWhenInUseAuthorization()
//        self.locationManager.startUpdatingLocation()
        self.Map.showsUserLocation = true
        
        // Map location (San Francisco)
        self.latitude = 37.787212
        self.longitude = -122.419415
        self.latDelta = 0.06
        self.lonDelta = 0.06
        
        self.span = MKCoordinateSpanMake(latDelta, lonDelta)
        self.location = CLLocationCoordinate2DMake(latitude, longitude)
        self.region = MKCoordinateRegionMake(location, span)
        self.Map.setRegion(region, animated: true)
        
        
        
        Map.delegate = self
        
        let obj = AnnotationObject(title: "Say Cheese", subtitle: "Sandwich", coordinate: CLLocationCoordinate2D(latitude: 37.777212, longitude: -122.429415), countReviews: 101, image: UIImage(named: "fhooder1")!, price: 10, rating: 5, imageRating: UIImage(named: "4-Spoon")!)
        
        
        Map.addAnnotation(obj)
        
        
        // When Fhooder button pressed, you can tap anywhere to disable the info window
//        self.cancelInfo.enabled = false
//        self.cancelInfo.addTarget(self, action: "cancelPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    
    
    
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?{
        
        
        let reuseIdentifier = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier)
        
        if pinView == nil {
            
            pinView = BubbleView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            pinView!.canShowCallout = false
            
        }
        else {
            pinView!.annotation = annotation
        }
        //Set custom pin image there
        pinView!.image = UIImage(named: "FhooderOn")
        
        //NSLog("Salary = %d", 123)
        return pinView
    }
    
//    func mapView(mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        
//            performSegueWithIdentifier("fhooderOne", sender: self)
//        
//        
//    }
    

    //333&&&&&&&&&&&&&&
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView){
        
        
        
//        let bubbleView = NSBundle.mainBundle().loadNibNamed("BubbleView", owner: self, options: nil)[0] as? BubbleView
//        let annotationObj = view.annotation as! AnnotationObject
//        bubbleView?.SetUpView(annotationObj)
//        bubbleView?.layer.cornerRadius = 15
//        view.addSubview(bubbleView!)
//        
//        bubbleView?.center = CGPointMake(bubbleView!.bounds.size.width*0.1, -bubbleView!.bounds.size.height*0.53)
        
        if view.annotation.isKindOfClass(MKUserLocation){
            return
        }
        
        var bubbleView = (NSBundle.mainBundle().loadNibNamed("BubbleView", owner: self, options: nil))[0] as! BubbleView
        var calloutViewFrame = bubbleView.frame;
        calloutViewFrame.origin = CGPointMake(-calloutViewFrame.size.width/2+15, -calloutViewFrame.size.height);
        bubbleView.frame = calloutViewFrame;
        
        let cpa = view.annotation as! AnnotationObject
        
        view.addSubview(bubbleView)
        
        let spanX = 0.01
        let spanY = 0.01
        
        var newRegion = MKCoordinateRegion(center: cpa.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        self.Map?.setRegion(newRegion, animated: true)
        
    }
    
    @IBAction func find(sender: AnyObject) {
        

        self.Map?.setRegion(region, animated: true)
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        fhooderOne()
        performSegueWithIdentifier("fhooderOne", sender: self)
    }
    
    
    func mapView(mapView: MKMapView, didDeselectAnnotationView view: MKAnnotationView) {
        
        for v in view.subviews
        {
            v.removeFromSuperview()
        }

    }

    @IBAction func NextView_btn(sender: AnyObject) {
        
        self.performSegueWithIdentifier("segue", sender: nil)
        
        
    }
    
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
    }
    
//    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if let controller = (segue.destinationViewController as? ResultViewController) {
//            controller.resultString = result
//        }

    
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if let controller = (segue.destinationViewController as? FhooderViewController){
            
            
            if segue.identifier == "fhooderOne" {
                fhooderOne()
            }
            else if segue.identifier == "fhooderTwo" {
                fhooderTwo()
            }
//            else if segue.identifier == "fhooderThree" {
//                fhooderThree()
//            }
//            else if segue.identifier == "fhooderFour" {
//                fhooderFour()
//            }
//            else if segue.identifier == "fhooderFive" {
//                fhooderFive()
//            }
//            else if segue.identifier == "fhooderSix" {
//                fhooderSix()
//            }
//            else if segue.identifier == "fhooderSeven" {
//                fhooderSeven()
//            }
//            else if segue.identifier == "fhooderEight" {
//                -----()
//            }
//            else if segue.identifier == "fhooderNine" {
//                fhooderNine()
//            }
//            else if segue.identifier == "fhooderTen" {
//                fhooderTen()
//            }

        }
    
        
    }

    
    override func viewDidAppear(animated: Bool) {
        

    }
/*
    func filterAction(sender: AnyObject) {
        if filterMenu == nil
        {
            let sections = [FilterMenuSectionInfo(titles: ["Less than $5", "$5 ~ $10", "More than $10"]),
                FilterMenuSectionInfo(titles: ["Highest rated", "Most reviewed"]),
                FilterMenuSectionInfo(titles: ["Open now", "Reserve"]),
                FilterMenuSectionInfo(titles: ["Pick up", "Eat in", "Delivery"])]
            
            filterMenu = FilterMenu(navigationController: self.navigationController!, sections: sections, delegate: self)
        }
        
        if filterShown {
            filterMenu?.hide()
        } else {
            filterMenu?.show()
        }
        
        filterShown = !filterShown
    }
    
    func filterMenuViewDidSelect(section: Int, subMenu: Int) {
        
        print("Did select: \nsection: \(section)\nsubMenu:\(subMenu)")
        
        if (section == 1 && subMenu == 1) {
            
            self.fhooder2Button.hidden = true
            self.fhooder4Button.hidden = true
            self.fhooder5Button.hidden = true
            self.fhooder9Button.hidden = true
            self.fhooder10Button.hidden = true
        }
        else if (section == 1 && subMenu == 2) {
            
            self.fhooder2Button.hidden = true
        }
    }
    
    func filterShowAll() {
        self.fhooder1Button.hidden = false
        self.fhooder2Button.hidden = false
        self.fhooder3Button.hidden = false
        self.fhooder4Button.hidden = false
        self.fhooder5Button.hidden = false
        self.fhooder6Button.hidden = false
        self.fhooder7Button.hidden = false
        self.fhooder8Button.hidden = false
        self.fhooder9Button.hidden = false
        self.fhooder10Button.hidden = false
    }

    
    func fhooderInfoViewDisappear() {
        self.fhooder1InfoView.alpha = 0
        self.fhooder2InfoView.alpha = 0
        self.fhooder3InfoView.alpha = 0
        self.fhooder4InfoView.alpha = 0
        self.fhooder5InfoView.alpha = 0
        self.fhooder6InfoView.alpha = 0
        self.fhooder7InfoView.alpha = 0
        self.fhooder8InfoView.alpha = 0
        self.fhooder9InfoView.alpha = 0
        self.fhooder10InfoView.alpha = 0
    }
*/

    func cancelPressed(sender: UIButton)  {
        //       self.cancelInfo.enabled = false
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}


