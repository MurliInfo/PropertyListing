//
//  SLPSaved.swift
//  SLP
//
//  Created by Hardik Davda on 6/1/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class SLPSaved: UIViewController {
    @IBOutlet var table : UITableView!
    var filterList = [filterSavedList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
      
        table.estimatedRowHeight = 100
        table.rowHeight = UITableViewAutomaticDimension
        
//        var parameter = "user_id="
//        parameter = parameter.appending(appDelegate.USERID as String)
//        SLPAllWebservices().filterDetailList(with: parameter , API: "", completion: {(ListData,message,status) in
//            print(" final list Saved : == \(ListData)")
//            self.filterList = ListData
//            self.table.reloadData()
//        })
        self.getList()
    }
    func getList()  {
        var parameter = "user_id="
        self.filterList = [filterSavedList]()
        parameter = parameter.appending(appDelegate.USERID as String)
        SLPAllWebservices().filterDetailList(with: parameter , API: "", completion: {(ListData,message,status) in
            print(" final list Saved : == \(ListData)")
            self.filterList = ListData
            self.table.reloadData()
        })
    }
    
    func ShowAlertMessage(title : String, message: String, buttonText : String)  {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension SLPSaved : UITableViewDelegate,UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.filterList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SLPCustomCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell! as! SLPCustomCell
        
        let printData =  self.filterList[indexPath.row]
        let printList = printData.strObject

        cell.lblTitle.text = printData.strName
        cell.lblPrice.text = printList?.strPriceMin
        cell.lblBedrooms.text = printList?.strBedroomsMin
        cell.lblBathrooms.text = printList?.strBathroomsMin
        cell.lblGarage.text = printList?.strGarage
        cell.lblPropertyType.text = printList?.strPropertyType

//        cell.lblPropertyType.layer.masksToBounds = true
//        cell.lblPropertyType.layer.cornerRadius = 10

        return cell
    }
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?{
        return indexPath
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            print("Delete")
            var parameter = "user_id="
            parameter = parameter.appending(appDelegate.USERID as String)
            parameter = parameter.appending("&id=").appending(self.filterList[indexPath.row].strId)
            SLPAllWebservices().removeFilterSaved(with: parameter , API: "", completion: {(message,status) in
                self.ShowAlertMessage(title: "", message: message, buttonText: "OK")
                self.getList()
            })
            
        }
    }
}
