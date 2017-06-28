//
//  SLPAdvanceSearch.swift
//  SLP
//
//  Created by Hardik Davda on 6/1/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class SLPAdvanceSearch: UIViewController {
var PrintListData = [AdvanceSearchDataList]()
    @IBOutlet var table: UITableView!
    
    @IBOutlet var viewFirst: UIView!
    @IBOutlet var viewSecond: UIView!
    @IBOutlet var viewThird: UIView!

    @IBOutlet var scroll: UIScrollView!
    @IBOutlet var switchSegment: UISegmentedControl!
    @IBOutlet var lblSwitchSelect: UILabel!
    @IBOutlet var btnSecondView: UIButton!

    @IBOutlet var lblSelected: UILabel!
    @IBOutlet var txtKeywords : UITextField!
    @IBOutlet var lblLocationSelected: UILabel!
    @IBOutlet var lblPriceSelected: UILabel!
    @IBOutlet var lblPropertyTypeSelected: UILabel!
    @IBOutlet var lblInpectionScheduleSelected: UILabel!
    @IBOutlet var SwitchSurrounding: UISwitch!
    @IBOutlet var SwitchExclude: UISwitch!
    @IBOutlet var ScrollBottom: NSLayoutConstraint!
    
    
    
    var NoData: NSString!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSecondView.tag = 1;
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        viewFirst.frame = (CGRect(x: 0, y: 40, width: self.view.frame.width, height: 220))
        self.scroll.addSubview(viewFirst)
        
        viewSecond.frame = (CGRect(x: 0, y: 260, width: self.view.frame.width, height: 200))
        self.scroll.addSubview(viewSecond)
        
        viewThird.frame = (CGRect(x: 0, y: 460, width: self.view.frame.width, height: 210))
        self.scroll.addSubview(viewThird)
        scroll.contentSize = CGSize(width:self.view.frame.size.width, height:viewThird.frame.height+viewThird.frame.origin.y)

        NoData = "NO DATA"
        SLPAllWebservices().SearchListDate(with: "", API: "", completion: {(ListData) in
            self.PrintListData = [AdvanceSearchDataList]()
            self.PrintListData = ListData
            self.NoData = "No Data Available"
            self.table.reloadData()
        })
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(keyboardWillShow(notification:)),
                           name: .UIKeyboardWillShow,
                           object: nil)
        
        center.addObserver(self,
                           selector: #selector(keyboardWillHide(notification:) ),
                           name: .UIKeyboardWillHide,
                           object: nil)
        

        self.initialise()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(switchSegment.selectedSegmentIndex)
        
        self.InitialData()
    }
    func clear() {
    
        lblSelected.text = "Any"
        txtKeywords .text = ""
        lblLocationSelected.text = "Any"
        lblPriceSelected.text = "Any"
        lblPropertyTypeSelected.text = "Any"
        lblInpectionScheduleSelected.text = "Any"
        SwitchSurrounding.isOn = false
        SwitchExclude.isOn = false
        
        appDelegate.FILTERPRICEMIN = "Any"
        appDelegate.FILTERPRICEMAX = "Any"
        appDelegate.FILTERPROPERTYTYPE = "Any"
        appDelegate.FILTERINSPECTIONSCHEDULE = "Any"
        appDelegate.FILTERBEDROOMSMIN = "Any"
        appDelegate.FILTERBEDROOMSMAX = "Any"
        appDelegate.FILTERBATHROOMMIN = "Any"
        appDelegate.FILTERBATHROOMMAX = "Any"
        appDelegate.FILTERLANDMIN = "Any"
        appDelegate.FILTERLANDMAX = "Any"
        appDelegate.FILTERSORT = "Any"
        appDelegate.FILTERSUBURBS = "Any"
        appDelegate.FILTERSUBURBSID = "Any"
        appDelegate.FILTERPROPERTYTYPEID = "Any"
        appDelegate.FILTERGARAGE = "Any"
        appDelegate.FILTERKEYWORD = "Any"
        appDelegate.FILTERSURROUNDING = false
        appDelegate.FILTEREXCLUDE = false
    }
    
    func initialise (){
        appDelegate.FILTERPRICEMIN = appDelegate.SelectedData.strPriceMin! as NSString
        appDelegate.FILTERPRICEMAX = appDelegate.SelectedData.strPriceMax! as NSString
        appDelegate.FILTERPROPERTYTYPE = appDelegate.SelectedData.strPropertyType! as NSString
        appDelegate.FILTERINSPECTIONSCHEDULE = appDelegate.SelectedData.strInspectionSchedule! as NSString
        appDelegate.FILTERBEDROOMSMIN = appDelegate.SelectedData.strBedroomsMin! as NSString
        appDelegate.FILTERBEDROOMSMAX = appDelegate.SelectedData.strBedroomsMax! as NSString
        appDelegate.FILTERBATHROOMMIN = appDelegate.SelectedData.strBathroomsMin! as NSString
        appDelegate.FILTERBATHROOMMAX = appDelegate.SelectedData.strBathroomsMax! as NSString
        appDelegate.FILTERLANDMIN = appDelegate.SelectedData.strLandSizeMin! as NSString
        appDelegate.FILTERLANDMAX = appDelegate.SelectedData.strLandSizeMax! as NSString
        appDelegate.FILTERSORT = appDelegate.SelectedData.strSort! as NSString
        appDelegate.FILTERSUBURBS = appDelegate.SelectedData.strSuburbs! as NSString
        appDelegate.FILTERSUBURBSID = appDelegate.SelectedData.strSuburbsId! as NSString
        appDelegate.FILTERPROPERTYTYPEID = appDelegate.SelectedData.strPropertyTypeId! as NSString
        appDelegate.FILTERGARAGE = appDelegate.SelectedData.strGarage! as NSString
        appDelegate.FILTERKEYWORD = appDelegate.SelectedData.strKeyword! as NSString
        appDelegate.FILTERSURROUNDING = appDelegate.SelectedData.boolSurroundingSuburb!
        appDelegate.FILTEREXCLUDE = appDelegate.SelectedData.boolExcludeUnderOffer!
        
        
        
    }
   
    @IBAction func firstViewClick(_ sender: UIButton) {
        switch sender.tag {
        case 1: //Location
            
            break
            
        case 2: //Price
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPPrice") as! SLPPrice
            self.navigationController?.pushViewController(secondViewController, animated: true)
          
            break
            
        case 3: // PropertyType
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPPropertyType") as! SLPPropertyType
            self.navigationController?.pushViewController(secondViewController, animated: true)
            break
            
        case 4: // Inspection Schedule
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPInspectionsSecheduled") as! SLPInspectionsSecheduled
            self.navigationController?.pushViewController(secondViewController, animated: true)

            break
            
        default:
            break
        }

    }
    
    @IBAction func secondViewClick(_ sender: UIButton) {
//        appDelegate.SelectedData.strLocation = "Surrounding Data"
        switch sender.tag {
        case 1: // Bedrooms
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPBedrooms") as! SLPBedrooms
            self.navigationController?.pushViewController(secondViewController, animated: true)
            break
            
        case 2: // Bathrooms
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPBathrooms") as! SLPBathrooms
            self.navigationController?.pushViewController(secondViewController, animated: true)

            break
       
        case 3: // Garage
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPGarage") as! SLPGarage
            self.navigationController?.pushViewController(secondViewController, animated: true)
            break
       
        case 4: // Land
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPLand") as! SLPLand
            self.navigationController?.pushViewController(secondViewController, animated: true)
            
            break
            
        default:
            break
        }
    }
    @IBAction func thidViewClick(_ sender: UIButton) {
        
    }
    
    @IBAction func switchSurrounding(_ sender: UISwitch) {
        if sender.isOn{
            
        }
    }
    
    @IBAction func switchExclude(_ sender: UISwitch) {
   
    }
    
    @IBAction func switchData(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            lblSwitchSelect.text = "Bedrooms"
            lblSelected.text = (appDelegate.FILTERBEDROOMSMIN as String ).appending(" to ").appending(appDelegate.FILTERBATHROOMMAX as String)
            btnSecondView.tag = 1;
        }else  if sender.selectedSegmentIndex == 1 {
            lblSwitchSelect.text = "Bathrooms"
              lblSelected.text = (appDelegate.FILTERBATHROOMMIN as String).appending(" to ").appending(appDelegate.FILTERBATHROOMMAX as String)
            btnSecondView.tag = 2;
        }else  if sender.selectedSegmentIndex == 2 {
            lblSwitchSelect.text = "Garage"
            lblSelected.text = appDelegate.FILTERGARAGE as String
        btnSecondView.tag = 3;
        }else  if sender.selectedSegmentIndex == 3 {
            lblSwitchSelect.text = "Land"
             lblSelected.text = (appDelegate.FILTERLANDMIN as String).appending(" to ").appending(appDelegate.FILTERLANDMAX as String)
            btnSecondView.tag = 4;
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        UIView.animate(withDuration: 1, animations: { () -> Void in
            self.ScrollBottom.constant = keyboardFrame.size.height
            print("Keyboar will appear\(keyboardFrame.size.height)")
            //self.scroll.constraints = keyboardFrame.size.height + 20
        })
    }
    
    func keyboardWillHide(notification: NSNotification) {
        //        print("keyboarhide")
        self.ScrollBottom.constant = 44
    }

    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  
    @IBAction func clearFilter(_ sender: Any) {
        self.clear()
    }
    
    @IBAction func Search(_ sender: Any) {
        appDelegate.SelectedData.strPriceMin = appDelegate.FILTERPRICEMIN as String
        appDelegate.SelectedData.strPriceMax = appDelegate.FILTERPRICEMAX as String
        appDelegate.SelectedData.strPropertyType = appDelegate.FILTERPROPERTYTYPE as String
        appDelegate.SelectedData.strInspectionSchedule = appDelegate.FILTERINSPECTIONSCHEDULE as String
        appDelegate.SelectedData.strBedroomsMin = appDelegate.FILTERBEDROOMSMIN as String
        appDelegate.SelectedData.strBedroomsMax = appDelegate.FILTERBEDROOMSMAX as String
        appDelegate.SelectedData.strBathroomsMin = appDelegate.FILTERBATHROOMMIN as String
        appDelegate.SelectedData.strBathroomsMax = appDelegate.FILTERBATHROOMMAX as String
        appDelegate.SelectedData.strLandSizeMin = appDelegate.FILTERLANDMIN as String
        appDelegate.SelectedData.strLandSizeMax = appDelegate.FILTERLANDMAX as String
        appDelegate.SelectedData.strSort = appDelegate.FILTERSORT as String
        appDelegate.SelectedData.strSuburbs = appDelegate.FILTERSUBURBS as String
        appDelegate.SelectedData.strSuburbsId = appDelegate.FILTERSUBURBSID as String
        appDelegate.SelectedData.strPropertyTypeId = appDelegate.FILTERPROPERTYTYPEID as String
        appDelegate.SelectedData.strGarage = appDelegate.FILTERGARAGE as String
        appDelegate.SelectedData.strKeyword = appDelegate.FILTERKEYWORD as String
        appDelegate.SelectedData.boolSurroundingSuburb = SwitchSurrounding.isOn
        appDelegate.SelectedData.boolExcludeUnderOffer = appDelegate.FILTEREXCLUDE
        appDelegate.SEARCh = "YES"
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func Timer(_ sender: Any) {
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPPropertyType") as! SLPPropertyType
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func InitialData() {
        lblLocationSelected.text = appDelegate.FILTERSUBURBS as String
        lblPriceSelected.text = (appDelegate.FILTERPRICEMIN as String)+" To "+(appDelegate.FILTERPRICEMAX as String)
        lblPropertyTypeSelected.text = appDelegate.FILTERPROPERTYTYPE as String
        lblInpectionScheduleSelected.text = appDelegate.FILTERINSPECTIONSCHEDULE as String
        SwitchSurrounding.isOn = appDelegate.FILTERSURROUNDING
        SwitchExclude.isOn = appDelegate.FILTEREXCLUDE
        
        if switchSegment.selectedSegmentIndex == 0{
             lblSelected.text = (appDelegate.FILTERBEDROOMSMIN as String).appending(" to ").appending(appDelegate.FILTERBEDROOMSMAX as String)
        }else if switchSegment.selectedSegmentIndex == 1{
            lblSelected.text = (appDelegate.FILTERBATHROOMMIN as String).appending(" to ").appending(appDelegate.FILTERBATHROOMMAX as String)
        }else if switchSegment.selectedSegmentIndex == 2{
            lblSelected.text = appDelegate.FILTERGARAGE as String
        }else if switchSegment.selectedSegmentIndex == 3{
            lblSelected.text = (appDelegate.FILTERLANDMIN as String ).appending(" to ").appending(appDelegate.FILTERLANDMAX as String)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
// MARK: - UITableview Delegate and DataSourse

extension SLPAdvanceSearch : UITableViewDataSource,UITableViewDelegate{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.PrintListData.count > 0 {
                    TableViewHelper.EmptyMessage(message: "", viewController: self.table)
            return self.PrintListData.count
        } else {
            TableViewHelper.EmptyMessage(message: NoData as String, viewController: self.table)
            return 0
        }
    }
    
    // create a cell for each table view row
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SLPCustomCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell! as! SLPCustomCell
        let printData = self.PrintListData[indexPath.row]
        cell.lblTitle.text = printData.strTitle
        cell.lblSelected.text = printData.strData
        
        cell.backgroundColor = UIColor.white
        return cell
    }
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?{
        if indexPath.row == 2{
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPPrice") as! SLPPrice
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
        if indexPath.row == 3{
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPPropertyType") as! SLPPropertyType
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
        if indexPath.row == 4{
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPInspectionsSecheduled") as! SLPInspectionsSecheduled
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
        if indexPath.row == 5{
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPBedrooms") as! SLPBedrooms
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
        if indexPath.row == 6{
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPBathrooms") as! SLPBathrooms
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
        if indexPath.row == 7{
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPGarage") as! SLPGarage
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
        return indexPath
    }
}

extension SLPAdvanceSearch : UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }// called when 'return' key pressed. return NO to ignore.
}


