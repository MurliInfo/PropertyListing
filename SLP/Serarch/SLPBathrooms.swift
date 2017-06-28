//
//  SLPBathrooms.swift
//  SLP
//
//  Created by Hardik Davda on 6/5/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class SLPBathrooms: UIViewController {

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
        self.declareArray()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MAX = appDelegate.FILTERBATHROOMMAX
        MIN = appDelegate.FILTERBATHROOMMIN
        if appDelegate.FILTERBATHROOMMIN != "Any"{
            for  i in 0..<arrayMinBedroom.count{
                if appDelegate.FILTERBATHROOMMIN as String == arrayMinBedroom[i]{
                    min = i
                }
            }
            self.pickerViewData.selectRow(min, inComponent: 0, animated: true)
        }
        if appDelegate.FILTERBATHROOMMAX != "Any"{
            for  i in 0..<arrayMinBedroom.count{
                if appDelegate.FILTERBATHROOMMAX as String == arrayMaxBedroom[i]{
                    max = i
                }
            }
            self.pickerViewData.selectRow(max, inComponent: 2, animated: true)
        }
    }
    func declareArray(){
        
        arrayMaxBedroom.append("Any")
        arrayMinBedroom.append("Any")
        
        
        
        for  i in 1..<6{
            arrayMinBedroom.append(String(i))
            arrayMaxBedroom.append(String(i))
        }
        arrayMaxBedroom.append("Any")
        arrayMinBedroom.append("Any")
        
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

extension SLPBathrooms : UIPickerViewDataSource,UIPickerViewDelegate{
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
//        appDelegate.FILTERBATHROOMMAX = arrayMaxBedroom[pickerViewData.selectedRow(inComponent: 2)] as NSString
//        appDelegate.FILTERBATHROOMMIN = arrayMinBedroom[pickerViewData.selectedRow(inComponent: 0)] as NSString
    }
}
