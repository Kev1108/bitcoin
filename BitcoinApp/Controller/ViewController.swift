//
//  ViewController.swift
//  BitcoinApp
//
//  Created by MA SHAO I on 2022/3/23.
//

import UIKit


class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencySelector.dataSource = self
        currencySelector.delegate = self
        coinManager.delegate = self
        currencySelector.selectRow(93, inComponent: 0, animated: true)
        // Do any additional setup after loading the view.
    }
    
     var coinManager = CoinManager()

    @IBOutlet weak var exchangeRateLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencySelector: UIPickerView!
    
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate  {
    func errorHandler(_ error: Error?) {
        print(error!)
    }
    
    func didUpdateCoin(_ coinManager: CoinManager, coin: ExchangeRateModel
    ) {
        DispatchQueue.main.async {
            self.exchangeRateLabel.text = coin.rateString
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
     
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyLabel.text = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for:  currencyLabel.text!)
        
        }
}

