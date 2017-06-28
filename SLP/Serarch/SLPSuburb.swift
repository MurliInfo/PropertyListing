//
//  SLPSuburb.swift
//  SLP
//
//  Created by Hardik Davda on 6/21/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class SLPSuburb: UIViewController {
    @IBOutlet var table : UITableView!
    @IBOutlet var collectionSuburb: UICollectionView!
    @IBOutlet var txtSearch : UITextField!
    
    var suburbList = [SuburbListData]()
    var selectedSuburbList = [SuburbListData]()
    var CCList = Array<Any>()

//    var searchTimer : Timer
    var searchTimer:Timer? = Timer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionSuburb.delegate = self
        collectionSuburb.dataSource = self
        
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        
//        //  let width = UIScreen.main.bounds.width
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        
//        //  layout.itemSize = CGSize(width: width / 2, height: width / 2)
//        layout.minimumInteritemSpacing = 10
//        
//        layout.minimumLineSpacing = 10
//        self.collectionSuburb.collectionViewLayout = layout
        
        // Do any additional setup after loading the view.
    }
    @IBAction func cancelSuburb(_ sender: UIButton) {
        selectedSuburbList.remove(at: sender.tag)
        self.collectionSuburb.reloadData()
    }
    @IBAction func Done(_ sender: Any) {
    
        if selectedSuburbList.count > 0{
            for i in 0..<selectedSuburbList.count{
                if i == 0{
                    appDelegate.FILTERSUBURBS = selectedSuburbList[i].strSuburb!.appending("-").appending(selectedSuburbList[i].strStateName) as NSString
                    
                    appDelegate.FILTERSUBURBSID = selectedSuburbList[i].strId! as NSString
                    appDelegate.SelectedData.strSuburbs = appDelegate.FILTERSUBURBS as String
                    appDelegate.SelectedData.strSuburbsId = appDelegate.FILTERSUBURBSID as String
                    
                }else{
                    appDelegate.FILTERSUBURBS =  appDelegate.FILTERSUBURBS.appending(",").appending(selectedSuburbList[i].strSuburb!).appending("-").appending(selectedSuburbList[i].strStateName) as NSString
                    appDelegate.FILTERSUBURBSID = appDelegate.FILTERSUBURBSID.appending(",").appending( selectedSuburbList[i].strId!) as NSString
                    appDelegate.SelectedData.strSuburbs = appDelegate.FILTERSUBURBS as String
                    appDelegate.SelectedData.strSuburbsId = appDelegate.FILTERSUBURBSID as String
                }
            }
            appDelegate.SEARCh = "YES"
            self.dismiss(animated: true, completion: nil)
        }else{
            appDelegate.FILTERSUBURBS = ""
            appDelegate.FILTERSUBURBSID = ""
            appDelegate.SEARCh = "YES"
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func searchSuburb(_ sender: UITextField) {
        if (self.searchTimer != nil) {
            self.searchTimer?.invalidate()
            self.searchTimer = nil
        }
       self.searchTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.event), userInfo: nil, repeats: false)
    }

    func event(timer: Timer!) {
        self.getSuburbList()
    }

    func getSuburbList()  {
        if txtSearch.text != ""{
            let parameter = "global_search=".appending(txtSearch.text!)
            SLPAllWebservices().suburbDataFilterList(with: parameter, API: "", completion: {(ListData,count,message) in
                self.suburbList = ListData
                self.table.reloadData()
            })
        }
    }
    
    @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
extension SLPSuburb : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suburbList.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SLPCustomCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell! as! SLPCustomCell
        cell.lblTitle.text = suburbList[indexPath.row].strSuburb.appending("-").appending(suburbList[indexPath.row].strStateName)
        return cell
    }
   
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        print(suburbList[indexPath.row].strSuburb)
        
        self.selectedSuburbList.append(suburbList[indexPath.row])
        
        self.collectionSuburb.reloadData()
        
        suburbList.remove(at: indexPath.row)
        self.table.reloadData()
        
        return indexPath
    }
}

extension SLPSuburb : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return selectedSuburbList.count//self.CCList.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        cell.lbltitle.text = selectedSuburbList[indexPath.row].strSuburb.appending("-").appending(selectedSuburbList[indexPath.row].strStateName)
        //"12vvgfsg gvdfsg 1 fdsf fsfg dsf"
        cell.btnCancel.tag = indexPath.row
        // cell.myLabel.sizeToFit()
        return cell
    }
       
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let originalString: String = selectedSuburbList[indexPath.row].strSuburb.appending("-").appending(selectedSuburbList[indexPath.row].strStateName)
        let myString: NSString = originalString as NSString
        let size: CGSize = myString.size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14.0)])
        
        var width = size.width+55
        
        if (size.width+55)>69{
            width = size.width+55
        }else{
            width = 70
        }
        print(width)
        return CGSize(width: width , height: 36);
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 5, height: 5);
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    

}
extension SLPSuburb : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
        return true
    }

}

