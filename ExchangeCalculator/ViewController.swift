//
//  ViewController.swift
//  ExchangeCalculator
//
//  Created by Américo Rio on 26/04/2018.
//  Copyright © 2018 Américo Rio. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var original_txt: UITextField!
    
    @IBOutlet weak var coin_sc: UISegmentedControl!
    
    @IBOutlet weak var result_lbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        original_txt.delegate = self
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ original_txt: UITextField) -> Bool {
        
        // Hide the keyboard.
        original_txt.resignFirstResponder()
        return true
    }
    

    @IBAction func convert_btn_click(_ sender: Any) {
        
        let original_value = Double(original_txt.text!)
        
        let coin = coin_sc.titleForSegment(at: coin_sc.selectedSegmentIndex)!
        
        let url = "http://free.currencyconverterapi.com/api/v3/convert?q="+coin+"_EUR&compact=ultra";
        
        Alamofire.request(url).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let ra = JSON(responseData.result.value!)
                let rate = ra[coin + "_EUR"].doubleValue
                
                let result = rate * original_value!
                
                self.result_lbl.text = String(result) + " €"
                
                // debug only
                print(ra)
                print (rate)
                
            }
        }
        
        
        
    }
    
    

}

