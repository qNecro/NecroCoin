//
//  ViewController.swift
//  NecroCoin
//
//  Created by Necro on 16/08/2021.
//  Copyright © 2021 qNecro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate {
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var dashLabel: UILabel!
    @IBOutlet weak var dogeLabel: UILabel!
    @IBOutlet weak var ethLabel: UILabel!
    @IBOutlet weak var rippleLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var dashCurrency: UILabel!
    @IBOutlet weak var dogeCurrency: UILabel!
    @IBOutlet weak var ethCurrency: UILabel!
    @IBOutlet weak var rippleCurrency: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    let coins = ["BTC", "DOGE"]
    var coinManager = CoinManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
    
    func didUpdatePriceBTC(price: String, currency: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = price
            self.currencyLabel.text = currency
        }
    }
    func didUpdatePriceDASH(price: String, currency: String) {
        DispatchQueue.main.async {
            self.dashLabel.text = price
            self.dashCurrency.text = currency
        }
    }
    func didUpdatePriceDOGE(price: String, currency: String) {
        DispatchQueue.main.async {
            self.dogeLabel.text = price
            self.dogeCurrency.text = currency
        }
    }
    func didUpdatePriceETH(price: String, currency: String) {
        DispatchQueue.main.async {
            self.ethLabel.text = price
            self.ethCurrency.text = currency
        }
    }

    func didUpdatePriceXRP(price: String, currency: String) {
        DispatchQueue.main.async {
            self.rippleLabel.text = price
            self.rippleCurrency.text = currency
        }
    }
    
    

    func didFailedWithError(error: Error) {
        print(error)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCryptoPrices(for: selectedCurrency)
        
        
    }
    


}
