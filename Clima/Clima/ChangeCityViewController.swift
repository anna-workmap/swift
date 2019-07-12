//
//  ChangeCityViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

//Write the protocol declaration here:
protocol ChangeCityDelegate {
    func userEnteredANewCityName (cityEntered: String)
}

class ChangeCityViewController: UIViewController {
    
    var delegate : ChangeCityDelegate?
    
    
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBAction func cityEnteredButton(_ sender: Any) {
        delegate?.userEnteredANewCityName(cityEntered: cityNameTextField.text!)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    
    
    
    
    
    
    
  }
