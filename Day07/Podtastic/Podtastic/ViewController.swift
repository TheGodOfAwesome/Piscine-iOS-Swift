//
//  ViewController.swift
//  Podtastic
//
//  Created by Kuzivakwashe MUVEZWA on 2018/10/10.
//  Copyright © 2018 Kuzivakwashe MUVEZWA. All rights reserved.
//

import UIKit
import RecastAI
import ForecastIO

struct Location {
    var confidence: String;
    var country: String;
    var formatted: String;
    var lat: String;
    var lng: String;
    var place: String;
    var raw: String;
    var type: String;
}

var weather: String = "";

class ViewController: UIViewController {
    

    var bot : RecastAIClient?
    var requestStarted: Bool = false;
    
    @IBOutlet weak var intentLabel: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    let client = DarkSkyClient(apiKey: "db1ca3319afa7976c8c4c2c1335d84d3")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.bot = RecastAIClient(token : "21ad565d98601676eff7c2e1a731fe72", language: "en");
        self.bot = RecastAIClient(token : "21ad565d98601676eff7c2e1a731fe72");
        client.units = .si;
        client.language = .english;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendButton(_ sender: UIButton) {
        if (!(messageTextField.text?.isEmpty)!)
        {
            print("Making a request!");
            makeRecastRequest();
            
        }
    }
    
    func RequestError(_ error : Error)
    {
        print("Error : \(error)");
    }
    
    
    func makeRecastRequest()
    {
        //Call makeRequest with string parameter to make a text request
        let requestString: String = messageTextField.text!
        print("Request: \(requestString)");
        print(self.bot?.textRequest(requestString, successHandler: newSuccessHandler, failureHandle: newFailureHandler) ?? "No value returned");
    }
  
    func newSuccessHandler(_ response : Response) -> Void
    {
        let intent = response.intent();
        print("Intent: \(String(describing: intent?.slug))");
        print("Entities: \(String(describing: response.entities))");
        print("Timestamp: \(String(describing: response.timestamp))");
        print("Status: \(String(describing: response.status))" );
        print("Intents: \(response.intents as Any)");
        print("Language: \(String(describing: response.language))");
        print("Source: \(String(describing: response.source))");
        print("Response: \(response)");
        
        let locationData = response.all(entity: "location");
        let newIntent = String(describing: intent?.slug);
        print("New Intent: \(newIntent)");
        if (locationData != nil && newIntent == "Optional(\"weather\")"){
            var locate: Location! = Location(confidence: "", country: "", formatted: "", lat: "", lng: "", place: "", raw: "", type: "");
            
            locate.country = cleanString(template: String(describing:locationData![0]["country"]));
            locate.confidence = cleanString(template: String(describing: locationData![0]["confidence"]));
            locate.formatted = cleanString(template: String(describing:locationData![0]["formatted"]));
            locate.lat = cleanString(template: String(describing:locationData![0]["lat"]));
            locate.lng = cleanString(template: String(describing:locationData![0]["lng"]));
            locate.place = cleanString(template: String(describing:locationData![0]["place"]));
            locate.raw = cleanString(template: String(describing:locationData![0]["raw"]));
            locate.type = cleanString(template: String(describing:locationData![0]["type"]));
            
            print("Confidence: \(locate.confidence)");
            print("Country: \(locate.country)");
            print("Formatted: \(locate.formatted)");
            print("Latitude: \(locate.lat)");
            print("Longitude: \(locate.lng)");
            print("Place: \(locate.place)");
            print("Raw: \(locate.raw)");
            print("Type: \(locate.type)");
            print(weatherNowRequest(locations: locate));
            print(weather);
        } else {
            if(newIntent == "Optional(\"weather\")"){
                intentLabel.text = "Please send a location with weather request";
            }else if(newIntent == "Optional(\"greetings\")"){
                intentLabel.text = "Hello! How can I help you?";
            }else if(newIntent == "Optional(\"goodbye\")"){
                intentLabel.text = "Bye. Hope to see you soon.";
            }else{
                print("No Intent!");
                intentLabel.text = "Don't understand. How can I help you?";
            }
        }
    }
    
    func newFailureHandler(_ error : Error) -> Void
    {
        print("Error: \(error)");
        let errorString = error.localizedDescription
        print("Error Localisation String: \(errorString)")
    }
    
    func cleanString(template: String) -> String{
        let newTemplate = template.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range:nil);
        print(newTemplate);
        let indexStartOfText = newTemplate.index(newTemplate.startIndex, offsetBy: 9);
        let indexEndOfText = newTemplate.index(newTemplate.endIndex, offsetBy: -1);
        let result = newTemplate[indexStartOfText..<indexEndOfText];
        return String(result);
    }
    
    func weatherNowRequest(locations: Location) -> String{
        var weather1 = "";
        var weather2 = "";
        var weather3 = "";
        var weather4 = "";
        var weather5 = "";
        var weather6 = "";
        client.getForecast(latitude: Double(locations.lat)!, longitude: Double(locations.lng)!) { result in
            switch result {
                case .success(let currentForecast, let requestMetadata):
                    //  We got the current forecast!
                    //print(currentForecast);
                    print("Coordinates: \(currentForecast.latitude),\(currentForecast.longitude)");
                    print("Temperature: \(currentForecast.currently?.apparentTemperature as Any)");
                    print("High Temp of: \(currentForecast.currently?.apparentTemperatureHigh as Any)");
                    print("Low Temp of: \(currentForecast.currently?.apparentTemperatureLow as Any)");
                    print("Cloud cover: \(currentForecast.currently?.cloudCover as Any)");
                    print("Humidity: \(currentForecast.currently?.humidity as Any)");
                    print("Pressure: \(currentForecast.currently?.pressure as Any)");
                    print("Summary: \(currentForecast.currently?.summary as Any)");
                    
                    weather1 = "Coordinates: \(currentForecast.latitude),\(currentForecast.longitude)";
                    weather2 = "Temperature: \(currentForecast.currently?.apparentTemperature as Any)";
                    weather3 = "Cloud cover: \(currentForecast.currently?.cloudCover as Any)";
                    weather4 = "Humidity: \(currentForecast.currently?.humidity as Any)";
                    weather5 = "Pressure: \(currentForecast.currently?.pressure as Any)";
                    weather6 = "Summary: \(currentForecast.currently?.summary as Any)";
                    weather = "\(weather1) \(weather2) \n \(weather3) \n \(weather4) \n \(weather5) \n \(weather6)";
                    print("The weather is \(weather)");
                    DispatchQueue.main.async {
                        weather = "\(weather1) \n \(weather2) \n \(weather3) \n \(weather4) \n \(weather5) \n \(weather6)";
                        self.intentLabel.text = "The weather in \(locations.formatted) is \(weather)";
                    }
                case .failure(let error):
                    //  Uh-oh. We have an error!
                    print(error);
                break
            }
        }
        return weather1;
    }
    
    func weatherOnRequest(locations: Location, timestamp: Date){
        client.getForecast(latitude: Double(locations.lat)!, longitude: Double(locations.lng)!, time: timestamp) { result in
            switch result {
                case .success(let currentForecast, let requestMetadata):
                        //  We got the current forecast!
                        print(currentForecast);
                        print(requestMetadata);
                case .failure(let error):
                        //  Uh-oh. We have an error!
                        print(error);
                break
            }
        }
    }
}

