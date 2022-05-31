//
//  ExchangeRateModel.swift
//  BitcoinApp
//
//  Created by MA SHAO I on 2022/3/28.
//

import Foundation
struct ExchangeRateModel{
    var rate: Double
    
    var rateString: String{
        return String(format: "%.3f", rate)
    }

}
