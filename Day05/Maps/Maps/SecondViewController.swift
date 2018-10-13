//
//  SecondViewController.swift
//  Maps
//
//  Created by Kuzivakwashe MUVEZWA on 2018/10/09.
//  Copyright © 2018 Kuzivakwashe MUVEZWA. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class SecondViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    private func mapInit() {
        let center = CLLocationCoordinate2D(latitude: 48.8952827, longitude: 2.3173602); //Ecole 42
        //let center = CLLocationCoordinate2D(latitude: -26.2049385, longitude: 28.040159); //WeThinkCode
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01));
        mapView.setRegion(region, animated: false);
        mapView.mapType = MKMapType.standard;
        mapView.showsCompass = true;
        mapView.showsScale = true;
        mapView.showsUserLocation = true;
    }
    
    private func locationManagerInit() {
        locationManager.delegate = self;
        locationManager.requestWhenInUseAuthorization();
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        locationManager.distanceFilter = 10;
        locationManager.startUpdatingLocation();
        //if (CLLocationManager.authorizationStatus() != .authorizedWhenInUse) {
            //localisationButton.isHidden = true;
        //}
    }
    
    private func addAnnotaions() {
        for pinData in Locations {
            let pin = MKPointAnnotation();
            pin.coordinate = CLLocationCoordinate2D(latitude: pinData.latitude, longitude: pinData.longitude);
            pin.title = pinData.name;
            pin.subtitle = pinData.information;
            mapView.addAnnotation(pin);
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.locationManagerInit();
        self.mapInit();
        self.addAnnotaions();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var locationManager = CLLocationManager();
    var pinAnnotationView: MKAnnotationView?;
    var actualLocationName: String? {
        didSet {
            for locationData in Locations {
                if (locationData.name == actualLocationName) {
                    let center = CLLocationCoordinate2D(latitude: locationData.latitude, longitude: locationData.longitude);
                    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01));
                    mapView.setRegion(region, animated: false);
                }
            }
        }
    }
    
    @IBAction func mapType(_ sender: UISegmentedControl) {
        switch sender.titleForSegment(at: sender.selectedSegmentIndex)! {
        case "Standard":
            mapView.mapType = MKMapType.standard;
        case "Satellite":
            mapView.mapType = MKMapType.satellite;
        case "Hybrid":
            mapView.mapType = MKMapType.hybrid;
        default:
            break;
        }
    }
    
    @IBAction func snapToLocation(_ sender: UIButton) {
        let center = CLLocationCoordinate2D(latitude: -26.2049385, longitude: 28.040159);
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01));
        mapView.setRegion(region, animated: false);
        mapView.showsCompass = true;
        mapView.showsScale = true;
        mapView.showsUserLocation = true;
    }
    
    func snapToListLocation(_ location: Location, locationName: String) {
        print(locationName);
        let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude);
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01));
        mapView.setRegion(region, animated: false);
        mapView.showsCompass = true;
        mapView.showsScale = true;
        mapView.showsUserLocation = true;
    }

}

