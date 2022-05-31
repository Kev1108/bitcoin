//
//  CoinManager.swift
//  BitcoinApp
//
//  Created by MA SHAO I on 2022/3/25.
//

import Foundation

protocol CoinManagerDelegate{
    func didUpdateCoin(_ coinManager: CoinManager, coin:ExchangeRateModel)
    func errorHandler(_ error:Error?)
}

struct CoinManager {
    
    var delegate:CoinManagerDelegate?
    let currencyArray = ["CAD","CZK","DKK","DOP","EUR","GBP","GEL","HKD","JPY","MXN","NZD","SGD","USD"]
    
    let coinURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "1A0B6D5F-8086-40A7-AAEF-0338E9F6D7DB"
    
    
    func  getCoinPrice(for currency:String){
        let urlString = "\(coinURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString:String){
        if   let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.errorHandler(error)
                }
                if let  safeData = data{
                    if let exchangeRates =  parseJson(safeData){
                        self.delegate?.didUpdateCoin(self, coin: exchangeRates)
                    }
                }
            }
            task.resume()
        }
        
    }
    
    func parseJson(_ data:Data)-> ExchangeRateModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(ExchangeRate.self, from: data)
            let bitcoinRate = ExchangeRateModel(rate: decodedData.rate)
            return bitcoinRate
        } catch{
            delegate?.errorHandler(error)
            return nil
        }
    }
}
