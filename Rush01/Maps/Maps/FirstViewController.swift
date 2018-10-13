//
//  FirstViewController.swift
//  Maps
//
//  Created by Kuzivakwashe MUVEZWA on 2018/10/09.
//  Copyright © 2018 Kuzivakwashe MUVEZWA. All rights reserved.
//

import UIKit
import Foundation

var Locations: [Location] = [
    Location(name: "Ecole42", information: "A Programming School", latitude: 48.8952827, longitude: 2.3173602, color: UIColor.red),
    Location(name: "We Think Code", information: "A Programming School", latitude: -26.2049385, longitude: 28.040159, color: UIColor.red),
    Location(name: "StructureIt", information: "First Internship", latitude: -26.0405276, longitude: 28.0090836, color: UIColor.purple),
    Location(name: "Home", information: "Where the heart is.", latitude: -26.2044128, longitude: 28.0412104, color: UIColor.blue),
    Location(name: "Gold Reef", information: "Casino and Amusement Park", latitude: -26.2360327, longitude: 28.010978, color: UIColor.green)
];

struct Location {
    var name: String;
    var latitude: Double;
    var longitude: Double;
    var information: String;
    var color: UIColor;
    
    init(name: String, information: String, latitude: Double, longitude: Double, color: UIColor) {
        self.name = name;
        self.latitude = latitude;
        self.longitude = longitude;
        self.information = information;
        self.color = color;
    }
}

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var locationsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationsTable.delegate = self
        locationsTable.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ locationsTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (Locations.count);
    }
    
    func tableView(_ locationsTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = locationsTable.dequeueReusableCell(withIdentifier: "listCell");
        cell?.textLabel?.text = Locations[indexPath.row].name;
        print(Locations[indexPath.row].name);
        return (cell!);
    }
    
    func tableView(_ locationsTable: UITableView, didSelectRowAt indexPath: IndexPath) {
        locationsTable.deselectRow(at: indexPath, animated: true);
        let SecondViewController = self.tabBarController?.viewControllers![0] as! SecondViewController;
        let actualLocationName = locationsTable.cellForRow(at: indexPath)?.textLabel?.text;
        for locationData in Locations {
            if (locationData.name == actualLocationName) {
                SecondViewController.snapToListLocation(locationData, locationName: locationData.name)
            }
        }
        self.tabBarController?.selectedViewController = SecondViewController;
    }
    
    /*
    func tableView(_ locationsTable: UITableView, didSelectRowAt indexPath: IndexPath) {
        locationsTable.deselectRow(at: indexPath, animated: true);
        let SecondViewController = self.tabBarController?.viewControllers![1] as! SecondViewController;
        SecondViewController.actualLocationName = locationsTable.cellForRow(at: indexPath)?.textLabel?.text;
        self.tabBarController?.selectedViewController = SecondViewController;
    }
    */
}

