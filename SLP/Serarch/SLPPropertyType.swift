//
//  SLPPropertyType.swift
//  SLP
//
//  Created by Hardik Davda on 6/2/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class SLPPropertyType: UIViewController {
    @IBOutlet var table: UITableView!
    var NoData: NSString!
    var PrintListData = [PropertyType]()
    var place : Int = 0
    var PROPERTY = NSString()
    var PROPERTYID = NSString()
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
        self.showProgressHUD()

        SLPAllWebservices().SearchPropertyType(with: "", API: "", completion: {(ListData,message,status) in
            self.PrintListData = [PropertyType]()
            self.PrintListData = ListData
            self.NoData = "No Data Available"
            self.table.reloadData()
            self.Selected()
            self.hideProgressHUD()
        })
        }
    }
    
    func Selected() {
        DispatchQueue.main.async {
            
            let points = appDelegate.FILTERPROPERTYTYPE
            self.PROPERTY = appDelegate.FILTERPROPERTYTYPE
            self.PROPERTYID = appDelegate.FILTERPROPERTYTYPEID

            let fullNameArr : Array<String>
            fullNameArr = (points.components(separatedBy: ","))
            print(fullNameArr[0])
            
            for i in 0..<self.PrintListData.count{
                for j in 0..<fullNameArr.count{
                    if self.PrintListData[i].strPropertyType == fullNameArr[j]{
                        self.PrintListData[i].isSelect = true
                    }
                }
            }
            self.table.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.Selected()
        
    }
    
    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func Done(_ sender: Any) {
//        appDelegate.FILTERPRICEMAX = MAX
//        appDelegate.FILTERPRICEMIN = MIN
        appDelegate.FILTERPROPERTYTYPEID = PROPERTYID
        appDelegate.FILTERPROPERTYTYPE = PROPERTY
        self.navigationController?.popViewController(animated: true)
        //        dismiss(animated: true, completion: nil)
    }
}

extension SLPPropertyType : UITableViewDataSource,UITableViewDelegate{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.PrintListData.count > 0 {
//            TableViewHelper.EmptyMessage(message: "", viewController: self.table)
            return self.PrintListData.count
        } else {
//            TableViewHelper.EmptyMessage(message: NoData as String, viewController: self.table)
            return 0
        }
    }
    // create a cell for each table view row
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SLPCustomCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell! as! SLPCustomCell
        let printData = self.PrintListData[indexPath.row]
        cell.lblTitle.text = printData.strPropertyType
        if printData.isSelect{
            cell.imgCheck.isHidden = false
        }else{
            cell.imgCheck.isHidden = true
        }
        cell.backgroundColor = UIColor.white
        return cell
    }
     public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?{
//        if(indexPath.row == 0){
//            if (self.PrintListData[indexPath.row].isSelect){
//                self.PrintListData[indexPath.row].isSelect = false
//                table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
//                appDelegate.FILTERPROPERTYTYPE = ""
//            }else{
//                self.PrintListData[indexPath.row].isSelect = true
//                for i in 1..<PrintListData.count{
//                    self.PrintListData[i].isSelect = false
//                }
//                appDelegate.FILTERPROPERTYTYPE = "Any"
//                table.reloadData()
//            }
//        }else{
            self.PrintListData[0].isSelect = false
            let indexPath1 = NSIndexPath(row: 0, section: 0)
            table.reloadRows(at: [indexPath1 as IndexPath], with: UITableViewRowAnimation.fade)
        if (self.PrintListData[indexPath.row].isSelect){
            self.PrintListData[indexPath.row].isSelect = false
        }else{
            self.PrintListData[indexPath.row].isSelect = true
        }
            var strString = "Any"
            var strStringId = "Any"
            for i in 0..<PrintListData.count{
                if self.PrintListData[i].isSelect == true{
                    if strString == "Any"{
                        strString = self.PrintListData[i].strPropertyType
                        strStringId = self.PrintListData[i].strId
                    }else{
                        strString = strString.appending(",").appending(self.PrintListData[i].strPropertyType)
                        strStringId = strStringId.appending(",").appending(self.PrintListData[i].strId)
                    }
                }
            }
            PROPERTYID = strStringId as NSString
            PROPERTY = strString as NSString
//            appDelegate.FILTERPROPERTYTYPEID = strStringId as NSString
//            appDelegate.FILTERPROPERTYTYPE = strString as NSString
//            
//        let indexPath = NSIndexPath(row: Index, section: 0)
        table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
//        }
        return indexPath
    }
}

