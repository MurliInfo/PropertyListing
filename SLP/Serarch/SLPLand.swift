//
//  SLPLand.swift
//  SLP
//
//  Created by Hardik Davda on 6/23/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class SLPLand: UIViewController {
    var arrayMinBedroom = Array<String>()
    var arrayMaxBedroom = Array<String>()
    var recievedString: String = ""
    var min : Int = 0
    var max : Int = 0
    var MAX = NSString()
    var MIN = NSString()
    @IBOutlet var pickerViewData: UIPickerView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        MAX = appDelegate.FILTERLANDMAX
        MIN = appDelegate.FILTERLANDMIN
        self.declareArray()
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if appDelegate.FILTERLANDMIN != "Any"{
            for  i in 0..<arrayMinBedroom.count{
                if appDelegate.FILTERLANDMIN as String == arrayMinBedroom[i]{
                    min = i
                }
            }
            self.pickerViewData.selectRow(min, inComponent: 0, animated: true)
        }
        if appDelegate.FILTERLANDMAX != "Any"{
            for  i in 0..<arrayMinBedroom.count{
                if appDelegate.FILTERLANDMAX as String == arrayMaxBedroom[i]{
                    max = i
                }
            }
            self.pickerViewData.selectRow(max, inComponent: 2, animated: true)
        }
    }

    func declareArray(){
        arrayMaxBedroom.append("Any")
        arrayMinBedroom.append("Any")
//        for  i in 1..<6{
            arrayMinBedroom.append("50m2")
            arrayMinBedroom.append("75m2")
            arrayMinBedroom.append("100m2")
            arrayMinBedroom.append("200m2")
            arrayMinBedroom.append("300m2")
            arrayMinBedroom.append("400m2")
            arrayMinBedroom.append("500m2")
            arrayMinBedroom.append("600m2")
            arrayMinBedroom.append("700m2")
            arrayMinBedroom.append("800m2")
            arrayMinBedroom.append("900m2")
            arrayMinBedroom.append("1000m2")
            arrayMinBedroom.append("1200m2")
            arrayMinBedroom.append("1500m2")
            arrayMinBedroom.append("1750m2")
            arrayMinBedroom.append("2000m2")
            arrayMinBedroom.append("3000m2")
            arrayMinBedroom.append("4000m2")
            arrayMinBedroom.append("5000m2")
            arrayMinBedroom.append("10000m2")

            
            arrayMaxBedroom.append("50m2")
            arrayMaxBedroom.append("75m2")
            arrayMaxBedroom.append("100m2")
            arrayMaxBedroom.append("200m2")
            arrayMaxBedroom.append("300m2")
            arrayMaxBedroom.append("400m2")
            arrayMaxBedroom.append("500m2")
            arrayMaxBedroom.append("600m2")
            arrayMaxBedroom.append("700m2")
            arrayMaxBedroom.append("800m2")
            arrayMaxBedroom.append("900m2")
            arrayMaxBedroom.append("1000m2")
            arrayMaxBedroom.append("1200m2")
            arrayMaxBedroom.append("1500m2")
            arrayMaxBedroom.append("1750m2")
            arrayMaxBedroom.append("2000m2")
            arrayMaxBedroom.append("3000m2")
            arrayMaxBedroom.append("4000m2")
            arrayMaxBedroom.append("5000m2")
            arrayMaxBedroom.append("10000m2")
            
//            arrayMinBedroom.append(String(i))
//            arrayMaxBedroom.append(String(i))
//        }
        arrayMaxBedroom.append("Any")
        arrayMinBedroom.append("Any")
    }
    @IBAction func Done(_ sender: Any) {
        appDelegate.FILTERLANDMAX = MAX
        appDelegate.FILTERLANDMIN = MIN
        self.navigationController?.popViewController(animated: true)
        
        //        dismiss(animated: true, completion: nil)
    }

    
}

extension SLPLand : UIPickerViewDataSource,UIPickerViewDelegate{
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
            return arrayMinBedroom.count
        }
        else if component == 1 {
            return 1
        }
        else {
            return arrayMaxBedroom.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return String(describing: arrayMinBedroom[row])
        } else  if component == 1 {
            return "TO"
        }
        else {
            return String(arrayMaxBedroom[row])
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
            label.text = String(describing: arrayMinBedroom[row])
        } else  if component == 1 {
            label.text = "To"
        }
        else {
            label.text = String(arrayMaxBedroom[row])
        }
        return label
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if (row == 0 && row == 6){
        }else {
            if component == 0 {
                let min = pickerViewData.selectedRow(inComponent: 0)
                let max = pickerViewData.selectedRow(inComponent: 2)
                if min > max{
                    self.pickerViewData.selectRow(min, inComponent: 2, animated: true)
                }
            } else  if component == 1 {
            }
            else {
                let min = pickerViewData.selectedRow(inComponent: 0)
                let max = pickerViewData.selectedRow(inComponent: 2)
                if min > max{
                    self.pickerViewData.selectRow(max, inComponent: 0, animated: true)
                }
            }
        }
        MAX = arrayMaxBedroom[pickerViewData.selectedRow(inComponent: 2)] as NSString
        MIN = arrayMinBedroom[pickerViewData.selectedRow(inComponent: 0)] as NSString
        
//        appDelegate.FILTERLANDMAX = arrayMaxBedroom[pickerViewData.selectedRow(inComponent: 2)] as NSString
//        appDelegate.FILTERLANDMIN = arrayMinBedroom[pickerViewData.selectedRow(inComponent: 0)] as NSString
    }
}

