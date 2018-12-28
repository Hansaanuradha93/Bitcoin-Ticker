//
//  ViewController.swift
//  Bitcoin Ticker
//
//  Created by Hansa Anuradha on 12/26/18.
//  Copyright © 2018 Hansa Anuradha. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let defaultURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCAUD"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""


    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        currencyPicker.delegate = self // Set the UIPickerView delegate
        currencyPicker.dataSource = self // Set the UIPickerView data source
        
        // Get bitcoin price data for AUD (Australian Dollars)
        getBitcoinPriceData(url: defaultURL)
        
    }
    
    //    //MARK: - UIPickerView methods
    //    /***************************************************************/
    
    // Determine how many columns we want in our picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // One column needed
    }
    
    // Determine how many rows we want in our picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    // Fill our picker row titles with the Strings from our currencyArray
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    // Determine what to do when the user select a perticular row - This method will be triggered every time the picker is scrolled
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        finalURL = baseURL + currencyArray[row] // Construct the final URL with selected valued in UIPickerView
        print(finalURL) // Print finalURL
        
        // Get the bitcoin price data related to the selected value in UIPickerView
        getBitcoinPriceData(url: finalURL)

    }
    
    //    //MARK: - Networking
    //    /***************************************************************/
    
    // getWeather method - Fetch weather infromation from the web service
    func getBitcoinPriceData(url : String) {

        // Alamorefire requests data from the server in the backgroud (Asyncronous), once the background process is completed, we will have a response
        Alamofire.request(url, method : .get).responseJSON {
            response in // Now we are trying to tackle with the respond which is a JSON
            if response.result.isSuccess { // Response is successfull
                print("Success! Got the bitcoin data!") // Print that response is successful

                let bitcointJSON : JSON = JSON(response.result.value!) // Get the data in response to a JSON / We have force unwrapped the value, since it has been checked and confirmed that it has a value for sure
                print(bitcointJSON) // Print the JSON
                // Parse JSON
                self.updateBitcoinData(json : bitcointJSON)



            } else { // Responce is failure
                print("Error \(String(describing: response.result.error))") // Print the error
                self.bitcoinPriceLabel.text = "Connection Issues" // Show the User the error
            }
        }
    }
    
    //Mark: -   JSON Parsing
    /*********************************************************************************************************************************************/
    
    // updateBitcoinData method - Parse JSON data then update UI
    func updateBitcoinData(json : JSON) {
        
        // Do an Optional binding to be sure this (json["ask"]) statement has some value (Not a nil value)
        if let bitcoinPriceResult = json["ask"].double { // Capture the bitcoin price data from the json and convert into Double from type JSON
            
            bitcoinPriceLabel.text = "\(bitcoinPriceResult)" // Update UI - bitcoinPriceLabel
            
        } else {
            bitcoinPriceLabel.text = "Bitcoint Price Unavailable"
        }
        
    }


}

