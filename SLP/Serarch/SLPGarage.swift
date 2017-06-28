//
//  SLPGarage.swift
//  SLP
//
//  Created by Hardik Davda on 6/5/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class SLPGarage: UIViewController {
    var arrayGarage = Array<String>()
    var GARAGE = NSString()
    var recievedString: String = ""

    @IBOutlet var pickerViewData: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GARAGE = appDelegate.FILTERGARAGE
        self.declareArray()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for  i in 1..<arrayGarage.count{
            if arrayGarage[i] == appDelegate.FILTERGARAGE as String{
                self.pickerViewData.selectRow(i, inComponent: 0, animated: true)
            }
        }
    }
    func declareArray(){
        arrayGarage.append("Any")
        arrayGarage.append("No Parking")
        for  i in 1..<6{
            var str = String(i)
            str.append("+")
            arrayGarage.append(str)
        }
    }
    @IBAction func Done(_ sender: Any) {
      appDelegate.FILTERGARAGE = GARAGE
        self.navigationController?.popViewController(animated: true)
        
        //        dismiss(animated: true, completion: nil)
    }
    
}

extension SLPGarage : UIPickerViewDataSource,UIPickerViewDelegate{
    @available(iOS 2.0, *)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //row = [repeatPickerView selectedRowInComponent:0];
        let row = pickerView.selectedRow(inComponent: 0)
        print("this is the pickerView\(row)")
            return arrayGarage.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(describing: arrayGarage[row])
        
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
        label.text =  String(describing: arrayGarage[row])
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        print(arrayGarage[row])
        GARAGE = arrayGarage[row] as NSString
//        appDelegate.FILTERGARAGE = arrayGarage[row] as NSString
    }
}
