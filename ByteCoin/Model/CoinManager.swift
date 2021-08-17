//
//  CoinManager.swift
//  NecroCoin
//
//  Created by Necro on 16/08/2021.
//  Copyright © 2021 qNecro. All rights reserved.
//

import Foundation
import Dispatch

protocol CoinManagerDelegate {
    func didFailedWithError(error: Error)
    func didUpdatePriceBTC(price: String, currency: String)
    func didUpdatePriceDASH(price: String, currency: String)
    func didUpdatePriceDOGE(price: String, currency: String)
    func didUpdatePriceETH(price: String, currency: String)
    func didUpdatePriceXRP(price: String, currency: String)
}


struct CoinManager {
    
//    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
//    let apiKey = "YOUR_API_KEY"
    
    
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCryptoPrices(for currency: String) {
        
        let group = DispatchGroup()
        
        let urls = [
            URL(string: "https://rest.coinapi.io/v1/exchangerate/BTC/\(currency)?apikey=YOUR_API_KEY"),
            URL(string: "https://rest.coinapi.io/v1/exchangerate/DASH/\(currency)?apikey=YOUR_API_KEY"),
            URL(string: "https://rest.coinapi.io/v1/exchangerate/DOGE/\(currency)?apikey=YOUR_API_KEY"),
            URL(string: "https://rest.coinapi.io/v1/exchangerate/ETH/\(currency)?apikey=YOUR_API_KEY"),
            URL(string: "https://rest.coinapi.io/v1/exchangerate/XRP/\(currency)?apikey=YOUR_API_KEY"),
        ]
        
        //MARK: - BTC
        
        group.enter()
        if let url = urls[0]{
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let btcPrice = self.parseJSON(safeData){
                    
                    let priceString = String(format: "%.2f", btcPrice)
                    self.delegate?.didUpdatePriceBTC(price: priceString, currency: currency)
                    }}
            }
            task.resume()
            group.leave()
        }
        //MARK: - DASH
        
        group.enter()
        if let url = urls[1]{
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let dashPrice = self.parseJSON(safeData){
                    
                    let priceString = String(format: "%.2f", dashPrice)
                    self.delegate?.didUpdatePriceDASH(price: priceString, currency: currency)
                    }}
            }
            task.resume()
            group.leave()
        }
        
        //MARK: - DOGE
        
        group.enter()
        if let url = urls[2]{
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let dogePrice = self.parseJSON(safeData){
                    
                    let priceString = String(format: "%.2f", dogePrice)
                    self.delegate?.didUpdatePriceDOGE(price: priceString, currency: currency)
                    }}
            }
            task.resume()
            group.leave()
        }
        
        //MARK: - ETH
        
        group.enter()
        if let url = urls[3]{
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let ethPrice = self.parseJSON(safeData){
                    
                    let priceString = String(format: "%.2f", ethPrice)
                    self.delegate?.didUpdatePriceETH(price: priceString, currency: currency)
                }}
            }
            task.resume()
            group.leave()
        }
        
        //MARK: - RIPPLE
        
        group.enter()
        if let url = urls[4]{
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let xrpPrice = self.parseJSON(safeData){
                    
                    let priceString = String(format: "%.2f", xrpPrice)
                    self.delegate?.didUpdatePriceXRP(price: priceString, currency: currency)
                    }}
            }
            task.resume()
            group.leave()
        }
        
        
    }
    
//    func getCoinPrice(for currency: String) {
//        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
//        if let url = URL(string: urlString) {
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if error != nil {
//                    print(error!)
//                    return
//                }
//
//                if let safeData = data {
//                    let bitcoinPrice = self.parseJSON(safeData)
//
//                    let priceString = String(format: "%.2f", bitcoinPrice!)
//                    self.delegate?.didUpdatePrice(price: priceString, currency: currency)
//                }
//            }
//            task.resume()
//        }
//    }
    
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            print(lastPrice)
            return lastPrice
        } catch {
            delegate?.didFailedWithError(error: error)
            return nil
        }
    }
    
    
}
