//
//  MainViewController.swift
//  Weather
//
//  Created by John Stuart on 6/11/16.
//  Copyright © 2016 John Stuart. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON
import Alamofire
import ChameleonFramework

var hours = [Hour]()

class MainViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: Properties
    var json : JSON = [:]
    var latitude = 0.0
    var longitude = 0.0
    var cityName = ""
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    // This constant controls the number of furture temperatures shown, 48 max
    let numberOfHoursShown = 12
    
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = FlatWhite()
        
        self.cityLabel.text = "--"
        self.descriptionLabel.lineBreakMode = .ByWordWrapping
        self.descriptionLabel.numberOfLines = 3
        self.descriptionLabel.text = "--"
        self.temperatureLabel.text = "--"
        
        self.locationManager.requestWhenInUseAuthorization()
        
        // Get current location
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    // MARK: - Location Delegate Methods
    // Deals with location intialization
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        latitude = locValue.latitude
        longitude = locValue.longitude
        
        print(latitude)
        print(longitude)
        
        // Get name of city
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location) {
            (placemarks, error) -> Void in
            let placeArray = placemarks as [CLPlacemark]!
            var placeMark: CLPlacemark!
            placeMark = placeArray?[0]
            if let city = placeMark.addressDictionary?["City"] as? NSString {
                self.cityName = city as String
                self.cityLabel.text = self.cityName
                self.cityLabel.sizeToFit()
            }
        }
        locationManager.stopUpdatingLocation()
        
        // Access API now that we have location
        makeRequest()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: " + error.localizedDescription)
    }
    
    // MARK: - API
    func makeRequest() {
        let url = "https://api.forecast.io/forecast/948744fd76394360ac1deae26e0fa67c/\(latitude),\(longitude)"
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    self.completionHandler(JSON(value))
                }
            case .Failure(let error):
                print(error)
            }
        }
        print("requesting")
    }
    
    func completionHandler(value : JSON) {
        json = value
        
        // Get data for next hours
        if hours.count == 0 {
            for index in 0...self.numberOfHoursShown {
                let time = NSDate(timeIntervalSince1970: Double(self.json["hourly"]["data"][index]["time"].stringValue)!)
                let temperature = self.json["hourly"]["data"][index]["temperature"].stringValue
                let icon = self.json["hourly"]["data"][index]["icon"].stringValue
                
                if let hour = Hour(time: time, temperature: temperature, icon: icon) {
                    hours += [hour]
                }
            }
        }
        
        // Show data in table view
        (self.childViewControllers[0] as! UITableViewController).tableView.reloadData()
        
        // Fill in top portion of main view
        descriptionLabel.text = self.json["hourly"]["summary"].stringValue
        let index = hours[0].temperature.startIndex
        var temperatureString = hours[0].temperature.substringToIndex(index.advancedBy(2))
        temperatureString.append("\u{00B0}" as Character)
        temperatureLabel.text = temperatureString
        
    }

}

