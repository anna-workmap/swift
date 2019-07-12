//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    //Set up UI
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var weatherIconImage: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!

    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "1f9699aa40602d112658182ca9282e63"
    /***Get your own App ID at https://openweathermap.org/appid ****/
    var locationManager = CLLocationManager()
    

    //override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //determine user's current location
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        
    }
    
    // didupdate locations and determine coordinate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationCurrent = locations.last! as CLLocation
        let longitude = locationCurrent.coordinate.longitude
        let latitude = locationCurrent.coordinate.latitude
        print("\(longitude), \(latitude)")
        locationManager.stopUpdatingLocation()
        
        //get weather data from website (https request)
        let params : [String : String] = ["lat" : "\(latitude)", "lon" : "\(longitude)", "appid" : APP_ID]
        Alamofire.request(WEATHER_URL, method: .get ,parameters: params).responseJSON { response in
            if response.result.isSuccess {
                print("Succeess! got the data")
                let weatherResult : JSON = JSON(response.result.value!)
                print(weatherResult)
                self.updateWeatherData(jsonValue: weatherResult)
            }
        }
    }
    
    // didfail locations
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityNameLabel.text = "Connection Issue"
    }
   
    //update weather data
    func updateWeatherData (jsonValue: JSON) {
        let tempResult = String(jsonValue["main"]["temp"].intValue - 275)
        let cityResutlt = jsonValue["name"].stringValue
        let weatherCondition = jsonValue["weather"][0]["id"].intValue
        print(weatherCondition)
        updateUIInfo(updateTemp: tempResult, updateCity: cityResutlt, updateCondition: weatherCondition)
    }
    
    //update UI
    func updateUIInfo (updateTemp: String, updateCity: String, updateCondition: Int) {
        degreeLabel.text = updateTemp
        cityNameLabel.text = updateCity
        let weatherDataModel = WeatherDataModel()
        let iconName = weatherDataModel.getWeatherIconName(condition: updateCondition)
        weatherIconImage.image = UIImage(named: iconName)
        
    }
    
    //segue method: change viewcontroller
    @IBAction func changeViewButton(_ sender: Any) {
        performSegue(withIdentifier: "ChangeViewController", sender: self)
    }
    
    //prepare segue is a func from performSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChangeViewController" {
            let ChangeCityVCL = segue.destination as! ChangeCityViewController
            ChangeCityVCL.delegate = self
        }
    }
    
    //conform to protocol to get weather data of new city entered
    func userEnteredANewCityName(cityEntered: String) {
        let paramsCity : [String : String] = ["q" : cityEntered, "appid" : APP_ID]
        Alamofire.request(WEATHER_URL, method: .get ,parameters: paramsCity).responseJSON { response in
            if response.result.isSuccess {
                print("Got city weather!")
                let cityWeatherResult : JSON = JSON(response.result.value!)
                print(cityWeatherResult)
                self.updateWeatherData(jsonValue: cityWeatherResult)
            }
        
        }
    
        
    }
    
    
    

    
    

    
    
    
    
    
    
}
