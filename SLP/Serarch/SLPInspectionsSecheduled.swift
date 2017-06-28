//
//  SLPInspectionsSecheduled.swift
//  SLP
//
//  Created by Hardik Davda on 6/2/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class SLPInspectionsSecheduled: UIViewController {
    @IBOutlet var table: UITableView!
    var NoData: NSString!
    var SCHEDULE = NSString()
    var PrintListData = [AdvanceSearchDataList]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        SCHEDULE = appDelegate.FILTERINSPECTIONSCHEDULE
        SLPAllWebservices().InspectionScheduled(with: "", API: "", completion: {(ListData) in
            self.PrintListData = [AdvanceSearchDataList]()
            self.PrintListData = ListData
            self.NoData = "No Data Available"
            self.table.reloadData()
            self.PreSelected()
        })

        // Do any additional setup after loading the view.
    }
    func PreSelected() {
        for i in 0..<PrintListData.count{
            if PrintListData[i].strTitle == appDelegate.SelectedData.strInspectionSchedule{
                PrintListData[i].isSelect = true
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.PreSelected()
    }
    @IBAction func Done(_ sender: Any) {
       appDelegate.FILTERINSPECTIONSCHEDULE = SCHEDULE

      self.navigationController?.popViewController(animated: true)
   
        //        dismiss(animated: true, completion: nil)
    }
    
}

extension SLPInspectionsSecheduled : UITableViewDataSource,UITableViewDelegate{
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
            SCHEDULE = "At any time"
//            appDelegate.SelectedData.strInspectionSchedule = "At any time"
        }else{
            self.PrintListData[indexPath.row].isSelect = true
            SCHEDULE = self.PrintListData[indexPath.row].strTitle as! NSString
//            appDelegate.SelectedData.strInspectionSchedule = self.PrintListData[indexPath.row].strTitle
        }
        table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
        return indexPath
    }
}
