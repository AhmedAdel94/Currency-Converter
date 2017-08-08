//
//  ViewController.swift
//  Currency Converter
//
//  Created by Ahmed Adel on 8/8/17.
//  Copyright © 2017 Ahmed Adel. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var myCurrency:[String] = []
    var myValues:[Double] = []
    
    var activeCurrency:Double = 0
    
    // Outlets
    
    @IBOutlet var input: UITextField!
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var output: UILabel!
    
    
    
    // Create the picker view
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myCurrency.count
       
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myCurrency[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activeCurrency = myValues[row]
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
        let url = URL(string: "http://api.fixer.io/latest")
        
        let task = URLSession.shared.dataTask(with: url!) { (data,response,error) in
            
            if error != nil
            {
                print("Error")
            }else
            {
                if let content = data
                {
                    do
                    {
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        if let rates = myJson["rates"] as? NSDictionary
                        {
                            for (key, value) in rates
                            {
                                self.myCurrency.append((key as! String))
                                self.myValues.append((value as! Double))
                            }
                            
                            print(self.myCurrency)
                            print(self.myValues)
                        }
                    }
                    catch
                    {
                        
                    }
                }
            }
            self.pickerView.reloadAllComponents()
        }
        
        task.resume()
    }
    
    
    

    @IBAction func convertTapped(_ sender: UIButton) {
        
        if input.text != nil
        {
            output.text = String(Double(input.text!)! * activeCurrency)
        }
    }
    
}

