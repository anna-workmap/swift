//
//  ViewController.swift
//  BitcoinTicker
//
//  Created by Angela Yu on 23/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["None","AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""
    

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        
    }

    
    
    //Determine how many columns we want in picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Determine how many rows we want in picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    //title of each row
    func pickerView(_ pickerView: UIPickerView, titleForRow rowTitle: Int, forComponent component: Int) -> String? {
        return currencyArray[rowTitle]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow rowSelected: Int, inComponent component: Int) {
        print(currencyArray[rowSelected])
        finalURL = baseURL + currencyArray[rowSelected]
        print(finalURL)
        
        let params: [String : String] = ["fiat" :currencyArray[rowSelected]]
        
        //Networking
        Alamofire.request(finalURL, method: .get, parameters: params).responseJSON {response in
            if response.result.isSuccess {
                print("Got data")
                let dataResult : JSON = JSON(response.result.value!)
                self.updateCurrencyPrice(price: dataResult)
            }
            else {
                print("Conneting Issue")
                self.bitcoinPriceLabel.text = "Connecting Issue"
            }
        }
    }

    func updateCurrencyPrice (price : JSON) {
        if  let currencyPrice : Int = price["last"].int {
            bitcoinPriceLabel.text = String(currencyPrice)
        }
        else {
            bitcoinPriceLabel.text = "Price Unavailable"
        }
    }
    



}

