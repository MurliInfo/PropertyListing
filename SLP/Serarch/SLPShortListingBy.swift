//
//  SLPShortListingBy.swift
//  SLP
//
//  Created by Hardik Davda on 6/7/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class SLPShortListingBy: UIViewController {
    @IBOutlet var table : UITableView!
    var PrintListData = [AdvanceSearchDataList]()
    var isSearch = Bool()
    var LIST = NSString()
    var savedValue = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        LIST = appDelegate.FILTERSORT
        
        print(isSearch)
        SLPAllWebservices().sortListingByDataList(with: "", API: "", completion: {(ListData) in
            self.PrintListData = [AdvanceSearchDataList]()
            self.PrintListData = ListData
            if self.isSearch{
                self.savedValue = appDelegate.SelectedData.strSort!//appDelegate.SHORTINGVALUESEARCH as String
            }else{
                self.savedValue = appDelegate.SelectedData.strSort!
            }
            for i in 0..<self.PrintListData.count{
                if self.PrintListData[i].strTitle == self.savedValue{
                    self.PrintListData[i].isSelect = true
                }
            }
            self.table.reloadData()
        })
    }
    @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func Done(_ sender: Any) {
        appDelegate.FILTERSORT = LIST
        appDelegate.SEARCh = "YES"
//        self.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)

    }
}

extension SLPShortListingBy : UITableViewDataSource,UITableViewDelegate{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.PrintListData.count > 0 {
            return self.PrintListData.count
        } else {
            return 0
        }
    }
    // create a cell for each table view row
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SLPCustomCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell! as! SLPCustomCell
        let printData = self.PrintListData[indexPath.row]
        cell.lblTitle.text = printData.strTitle
        if printData.isSelect{
            cell.imgCheck.isHidden = false
        }else{
            cell.imgCheck.isHidden = true
        }
        cell.backgroundColor = UIColor.white
        return cell
    }
    
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?{
        for i in 0..<PrintListData.count{
            if !(i == indexPath.row){
                self.PrintListData[i].isSelect = false
            }
        }
        table.reloadData()
        if (self.PrintListData[indexPath.row].isSelect){
            self.PrintListData[indexPath.row].isSelect = false
        }else{
            self.PrintListData[indexPath.row].isSelect = true
            if self.isSearch{
//                appDelegate.SelectedData.strSort = self.PrintListData[indexPath.row].strTitle!
                appDelegate.SHORTINGVALUESEARCH = self.PrintListData[indexPath.row].strTitle! as NSString
                LIST = self.PrintListData[indexPath.row].strTitle! as NSString
                //
            }else{
//                appDelegate.SelectedData.strSort = self.PrintListData[indexPath.row].strTitle!
                appDelegate.SHORTINGVALUESHORT = self.PrintListData[indexPath.row].strTitle! as NSString
//                LIST = self.PrintListData[indexPath.row].strTitle! as NSString
            }
        }
        table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
        return indexPath
    }
}
