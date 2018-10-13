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
    @IBOutlet weak var searchForLocationTextField: UITextField!
    @IBOutlet weak var navigateToDestinationTextField: UITextField!
    var currentLatitude : Double = 0;
    var currentLongitude : Double = 0;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.locationManagerInit();
        self.mapInit();
        self.addAnnotaions();
        
        self.locationManager.requestWhenInUseAuthorization();
        
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            locationManager.startUpdatingLocation();
        }
        
        mapView.delegate = self
    }
    
    @IBAction func searchForLocationButton(_ sender: UIButton) {
        print("Search Button Pressed!");
        mapView.removeOverlays(mapView.overlays);
        //Search request
        let searchRequest = MKLocalSearchRequest();
        if(searchForLocationTextField.text != ""){
            print("Search Text: \(String(describing: searchForLocationTextField.text))");
            searchRequest.naturalLanguageQuery = searchForLocationTextField.text;
            let activeSearch = MKLocalSearch(request: searchRequest);
            activeSearch.start{
                (response, error) in
                if (response == nil){
                    print("Error");
                    let alert = UIAlertController(title: "Error!", message: "Your Address Cannot Be Found!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }else{
                    //Getting Data
                    let latitude = response?.boundingRegion.center.latitude;
                    let longitude = response?.boundingRegion.center.longitude;
                    
                    print("Latitude: \(String(describing: latitude!)), Longitude: \(String(describing: longitude!))");
                    
                    let searchLocation = Location(name: "\(String(describing: self.searchForLocationTextField.text!))", information: "Search Result for: \(String(describing: self.searchForLocationTextField.text!))", latitude: latitude!, longitude: longitude!, color: UIColor.red)
                    Locations.append(searchLocation);
                    self.snapToNewLocation(searchLocation)
                }
            }
        }else{
            let alert = UIAlertController(title: "Insufficient Information!", message: "Please enter a search address before continuing!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func navigateToDestinationButton(_ sender: UIButton) {
        print("Navigate Button Pressed!");
        mapView.removeOverlays(mapView.overlays);
        //Search request
        let searchRequest = MKLocalSearchRequest();
        if(navigateToDestinationTextField.text != ""){
            print("Search Text: \(String(describing: navigateToDestinationTextField.text))");
            searchRequest.naturalLanguageQuery = navigateToDestinationTextField.text;
            let activeSearch = MKLocalSearch(request: searchRequest);
            activeSearch.start{
                (response, error) in
                if (response == nil){
                    print("Error");
                    let alert = UIAlertController(title: "Error!", message: "Your Destination Address Cannot Be Found!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }else{
                    //Getting Data
                    let latitude = response?.boundingRegion.center.latitude;
                    let longitude = response?.boundingRegion.center.longitude;
                    
                    print("Latitude: \(String(describing: latitude!)), Longitude: \(String(describing: longitude!))");
                    
                    let destinationLocation = Location(name: "\(String(describing: self.navigateToDestinationTextField.text!))", information: "Destination: \(String(describing: self.navigateToDestinationTextField.text!))", latitude: latitude!, longitude: longitude!, color: UIColor.red)
                    Locations.append(destinationLocation);
                    self.snapToNewLocation(destinationLocation)
                    if(self.searchForLocationTextField.text == ""){
                        
                        let alert = UIAlertController(title: "Information", message: "There is no address in the search location bar, will use your current GPS location to plot a route!", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                        
                        let currentLocation = Location(name: "\(String(describing: self.navigateToDestinationTextField.text!))", information: "Destination: \(String(describing: self.navigateToDestinationTextField.text!))", latitude: self.currentLatitude, longitude: self.currentLongitude, color: UIColor.red)
                        
                        self.getDirections(departureLocation: currentLocation, destinationLocation: destinationLocation);
                        
                    }else{
                        let searchRequest = MKLocalSearchRequest();
                        if(self.searchForLocationTextField.text != ""){
                            print("Search Text: \(String(describing: self.searchForLocationTextField.text))");
                            searchRequest.naturalLanguageQuery = self.searchForLocationTextField.text;
                            let activeSearch = MKLocalSearch(request: searchRequest);
                            activeSearch.start{
                                (response, error) in
                                if (response == nil){
                                    print("Error");
                                    let alert = UIAlertController(title: "Error!", message: "Your Departure Address Cannot Be Found!", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                    self.present(alert, animated: true)
                                }else{
                                    //Getting Data
                                    let latitude = response?.boundingRegion.center.latitude;
                                    let longitude = response?.boundingRegion.center.longitude;
                                    
                                    print("Latitude: \(String(describing: latitude!)), Longitude: \(String(describing: longitude!))");
                                    
                                    let searchLocation = Location(name: "\(String(describing: self.searchForLocationTextField.text!))", information: "Search Result for: \(String(describing: self.searchForLocationTextField.text!))", latitude: latitude!, longitude: longitude!, color: UIColor.red)
                                    Locations.append(searchLocation);
                                    
                                    self.getDirections(departureLocation: searchLocation, destinationLocation: destinationLocation);
                                    
                                }
                            }
                        }
                    }
                }
            }
        }else{
            let alert = UIAlertController(title: "Insufficient Information!", message: "Please enter a destination address before continuing!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
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

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationValue:CLLocationCoordinate2D = manager.location!.coordinate
        //print("User's current location: \(locationValue.latitude),\(locationValue.longitude)");
        currentLatitude = locationValue.latitude;
        currentLongitude = locationValue.longitude;
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
        var center = CLLocationCoordinate2D(latitude: -26.2049385, longitude: 28.040159);
        if (currentLatitude != 0 || currentLongitude != 0){
            center = CLLocationCoordinate2D(latitude: currentLatitude, longitude: currentLongitude);
        }
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
    
    func snapToNewLocation(_ location: Location) {
        addNewAnnotations(pinData: location)
        let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude);
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01));
        mapView.setRegion(region, animated: false);
        mapView.showsCompass = true;
        mapView.showsScale = true;
        mapView.showsUserLocation = true;
    }
    
    func addNewAnnotations(pinData: Location) {
        let pin = MKPointAnnotation();
        pin.coordinate = CLLocationCoordinate2D(latitude: pinData.latitude, longitude: pinData.longitude);
        pin.title = pinData.name;
        pin.subtitle = pinData.information;
        mapView.addAnnotation(pin);
    }
    
    func getDirections(departureLocation: Location, destinationLocation: Location){
        print("Departure location: \(departureLocation.latitude),\(departureLocation.longitude)");
        print("Destination location: \(destinationLocation.latitude),\(destinationLocation.longitude)");
        
        let sourceLocation = CLLocationCoordinate2D(latitude: departureLocation.latitude, longitude: departureLocation.longitude)
        let destinationLocation = CLLocationCoordinate2D(latitude: destinationLocation.latitude, longitude: destinationLocation.longitude)
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: destinationLocation)
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let directionResonse = response else {
                if let error = error {
                    print("we have error getting directions==\(error.localizedDescription)")
                    let alert = UIAlertController(title: "Error!", message: "No Direct Route To Your Destination Address Can Be Found!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                return
            }
            
            let route = directionResonse.routes[0]
            self.mapView.add(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
    }
    
    //MARK:- MapKit delegates
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

