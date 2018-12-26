//
//  ViewController.swift
//  Bitcoin Ticker
//
//  Created by Hansa Anuradha on 12/26/18.
//  Copyright © 2018 Hansa Anuradha. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""


    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        currencyPicker.delegate = self // Set the UIPickerView delegate
        currencyPicker.dataSource = self // Set the UIPickerView data source
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
        print(currencyArray[row])
    }
    


}
