//
//  SLPPrice.swift
//  SLP
//
//  Created by Hardik Davda on 6/2/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class SLPPrice: UIViewController {

    let minPrice = Array(0...9)
    let maxPrice = Array(0...59)
    var arrayMinPrice = Array<String>()
    var arrayMaxPrice = Array<String>()
    var recievedString: String = ""
    var min : Int = 0
    var max : Int = 0
    var MIN = NSString()
    var MAX = NSString()
    
    @IBOutlet var pickerViewData: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        var data1 = 0
//        var i = 1
//        for  i in 0..<28{
//           var it = 0;
//            if (i > -1 && i<=20) {
//                data1 = data1 + 50000;
//                it = data1;
//            }else if (i>20 && i<=24) {
//                data1 = data1 + 250000;
//                it = data1;
//            }else if (i>24 && i<=27){
//                data1 = data1 + 1000000;
//                it = data1;
//            }else{
//                data1 = data1+5000000;
//                it = data1;
//            }
            arrayMinPrice.append("Any")
            arrayMinPrice.append("$50,000")
            arrayMinPrice.append("$100,000")
            arrayMinPrice.append("$150,000")
            arrayMinPrice.append("$200,000")
            arrayMinPrice.append("$250,000")
            arrayMinPrice.append("$300,000")
            arrayMinPrice.append("$350,000")
            arrayMinPrice.append("$400,000")
            arrayMinPrice.append("$450,000")
            arrayMinPrice.append("$500,000")
            arrayMinPrice.append("$550,000")
            arrayMinPrice.append("$600,000")
            arrayMinPrice.append("$650,000")
            arrayMinPrice.append("$700,000")
            arrayMinPrice.append("$750,000")
            arrayMinPrice.append("$800,000")
            arrayMinPrice.append("$850,000")
        
            arrayMaxPrice.append("Any")
            arrayMaxPrice.append("$50,000")
            arrayMaxPrice.append("$100,000")
            arrayMaxPrice.append("$150,000")
            arrayMaxPrice.append("$200,000")
            arrayMaxPrice.append("$250,000")
            arrayMaxPrice.append("$300,000")
            arrayMaxPrice.append("$350,000")
            arrayMaxPrice.append("$400,000")
            arrayMaxPrice.append("$450,000")
            arrayMaxPrice.append("$500,000")
            arrayMaxPrice.append("$550,000")
            arrayMaxPrice.append("$600,000")
            arrayMaxPrice.append("$650,000")
            arrayMaxPrice.append("$700,000")
            arrayMaxPrice.append("$750,000")
            arrayMaxPrice.append("$800,000")
            arrayMaxPrice.append("$850,000")
        
            
//            arrayMinPrice.append(self.cleanDollars(String(it)))
//            arrayMaxPrice.append(self.cleanDollars(String(it)))
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MAX = appDelegate.FILTERPRICEMAX
        MIN = appDelegate.FILTERPRICEMIN
        if appDelegate.FILTERPRICEMIN != "Any"{
            for  i in 0..<arrayMinPrice.count{
                if appDelegate.FILTERPRICEMIN as String == arrayMinPrice[i]{
                    min = i
                }
            }
            self.pickerViewData.selectRow(min, inComponent: 0, animated: true)
        }
        if appDelegate.FILTERPRICEMAX != "Any"{
            for  i in 0..<arrayMinPrice.count{
                if appDelegate.FILTERPRICEMAX as String == arrayMaxPrice[i]{
                    max = i
                }
            }
            self.pickerViewData.selectRow(max, inComponent: 2, animated: true)
        }
    }
    
    func cleanDollars(_ value: String?) -> String {
        guard value != nil else { return "$0" }
        let doubleValue = Double(value!) ?? 0.0
        let formatter = NumberFormatter()
        formatter.currencyCode = "USD"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = (value!.contains("")) ? 0 : 0
        formatter.maximumFractionDigits = 0
        if #available(iOS 9.0, *) {
            formatter.numberStyle = .currencyAccounting
        } else {
             formatter.numberStyle = .currency
            // Fallback on earlier versions
        }
        return formatter.string(from: NSNumber(value: doubleValue)) ?? "$\(doubleValue)"
    }
    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
 
    @IBAction func Done(_ sender: Any) {
        appDelegate.FILTERPRICEMAX = MAX
        appDelegate.FILTERPRICEMIN = MIN

        self.navigationController?.popViewController(animated: true)

        //        dismiss(animated: true, completion: nil)
    }

    
}

extension SLPPrice : UIPickerViewDataSource,UIPickerViewDelegate{
    @available(iOS 2.0, *)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 3
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //row = [repeatPickerView selectedRowInComponent:0];
        let row = pickerView.selectedRow(inComponent: 0)
        print("this is the pickerView\(row)")
        
        if component == 0 {
            return arrayMinPrice.count
        }
        else if component == 1 {
            return 1
        }
        else {
            return arrayMaxPrice.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return String(describing: arrayMinPrice[row])
        } else  if component == 1 {
            return "TO"
        }
        else {
            return String(arrayMaxPrice[row])
        }
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "SanFranciscoText-Light", size: 14)

        if component == 0 {
            label.text = String(describing: arrayMinPrice[row])
        } else  if component == 1 {
            label.text = "To"
        }
        else {
            label.text = String(arrayMaxPrice[row])
        }
        return label
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        print("First value \(pickerViewData.selectedRow(inComponent: 0))")
        print("Second  value \(pickerViewData.selectedRow(inComponent: 2))")
            if component == 0 {
            let min1 = pickerViewData.selectedRow(inComponent: 0)
            let max1 = pickerViewData.selectedRow(inComponent: 2)
            print(min1)
            print(max1)
        if min1 != 0 && max1 != 0{
            if min1 > max1{
                self.pickerViewData.selectRow(min1, inComponent: 2, animated: true)
            }
        }
        } else  if component == 1 {
        }
        else {
            let min1 = pickerViewData.selectedRow(inComponent: 0)
            let max1 = pickerViewData.selectedRow(inComponent: 2)
        if min1 != 0 && max1 != 0{
            if min1 > max1{
                self.pickerViewData.selectRow(max1, inComponent: 0, animated: true)
            }
                }
        }
        MAX = arrayMaxPrice[pickerViewData.selectedRow(inComponent: 2)] as NSString
        MIN = arrayMinPrice[pickerViewData.selectedRow(inComponent: 0)] as NSString
//         appDelegate.FILTERPRICEMAX = arrayMaxPrice[pickerViewData.selectedRow(inComponent: 2)] as NSString
//         appDelegate.FILTERPRICEMIN = arrayMinPrice[pickerViewData.selectedRow(inComponent: 0)] as NSString
    }
}


