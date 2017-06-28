//
//  SLPPropertyListing.swift
//  SLP
//
//  Created by Hardik Davda on 6/27/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit
import SDWebImage

class SLPPropertyListing: UIViewController {
    @IBOutlet var table: UITableView!
    @IBOutlet var lblTitle: UILabel!
    
    var getCounsultantId = String()
    var getTitle = String()
    var isSold = String()
    var SearchScreenList = [SearchDataList]()

    var Load = NSString()
    var pageNumber = Int()
    var PARAMETER = NSString()
    
    var arrayImage = [#imageLiteral(resourceName: "gallery_placeholder1"),#imageLiteral(resourceName: "gallery_placeholder2"),#imageLiteral(resourceName: "gallery_placeholder3"),#imageLiteral(resourceName: "gallery_placeholder4"),#imageLiteral(resourceName: "gallery_placeholder5"),#imageLiteral(resourceName: "gallery_placeholder6"),#imageLiteral(resourceName: "gallery_placeholder7"),#imageLiteral(resourceName: "gallery_placeholder8"),#imageLiteral(resourceName: "gallery_placeholder9"),#imageLiteral(resourceName: "gallery_placeholder10"),#imageLiteral(resourceName: "gallery_placeholder6"),#imageLiteral(resourceName: "gallery_placeholder9")]
    override func viewDidLoad() {
        super.viewDidLoad()
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk()
        
        lblTitle.text = getTitle
        
        DispatchQueue.main.async {
            var parameter = NSString()
            self.pageNumber = 1;
            self.Load = "YES"
            parameter = "page="
            let Page = self.pageNumber as NSNumber
            parameter = parameter.appending(Page.stringValue as String).appending("&user_id=").appending(appDelegate.USERID as String) as NSString
            self.PARAMETER = parameter
            self.SearchScreenList = [SearchDataList]()
            self.showProgressHUD()
            self.GetSearchList(parameter: parameter)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
  
    @IBAction func Cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func favoritUnfavorit(_ sender: UIButton) {
        
        let proId = SearchScreenList[sender.tag].strId
        DispatchQueue.global(qos: .background).async {
            let param = "user_id=".appending((appDelegate.USERID).appending("&service_token=").appending(appDelegate.USERTOKEN as String).appending("&property_id=").appending(proId!)) as String
            self.favorits(parameter: param)
        }
        if SearchScreenList[sender.tag].strIsFavourite == "1"{
            SearchScreenList[sender.tag].strIsFavourite = "0"
            let ind4 = IndexPath(row: sender.tag, section: 0)                          //Property Info
            let cell4 = self.table.cellForRow(at: ind4) as! SLPCustomeCell1
            cell4.imgStar.image = #imageLiteral(resourceName: "iconeStar")
        }else{
            SearchScreenList[sender.tag].strIsFavourite = "1"
            let ind4 = IndexPath(row: sender.tag, section: 0)                          //Property Info
            let cell4 = self.table.cellForRow(at: ind4) as! SLPCustomeCell1
            cell4.imgStar.image = #imageLiteral(resourceName: "iconFillStar")
        }
        
        //        let indexPath = NSIndexPath(row: sender.tag, section: 0)
        //        table.reloadRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.none)
        
    }
    func favorits( parameter : String){
        SLPAllWebservices().FavoritProperty(with: parameter, API: "", completion: {(message,status)in
            print(message)
        })
    }
    func GetSearchList(parameter :NSString){
        var parameter = "&consultant_id=".appending(getCounsultantId)
        
        if isSold == "YES"{
            parameter = parameter.appending("&is_sold=").appending("1")
        }
        self.PARAMETER =  self.PARAMETER.appending(parameter) as NSString
        print(self.PARAMETER)
        
        SLPAllWebservices().SearchDashboardList(with: self.PARAMETER as String, API: "", completion: {(ListData,count,message) in
            print(message)
            
            if message == "No Records Found."{
                self.Load = "NO"
                self.hideProgressHUD()
                self.table.reloadData()
                if self.SearchScreenList.count == 0{
//                    self.lblTotalrecords.text = "No property Available."
                }
            }else{
                self.Load = "YES"
                print("Print get data")
                self.pageNumber = self.pageNumber+1
                //            self.SearchScreenList = [SearchDataList]()
                //                SearchScreenList.append(ListData)
                var cmd = SearchDataList()
                for i in 0..<ListData.count{
                    cmd = ListData[i]
                    self.SearchScreenList.append(cmd)
                    //
                }
                //              self.SearchScreenList = ListData
                //                self.SearchScreenList.append(cmd)
                let printCount = ("Showing ").appending(String(self.SearchScreenList.count)).appending(" of ").appending(count).appending(" Results")
//                self.lblTotalrecords.text = printCount
                print("Record Count \(count)")
                self.table.reloadData()
                self.hideProgressHUD()
            }
        })
        
        
    }
    func loadMore(){
        DispatchQueue.main.async {
            self.Load = "NO"
            let Page = self.pageNumber as NSNumber
            //            var parameter = self.PARAMETER
            var parameter = "page="
            parameter = (parameter.appending(Page.stringValue as String).appending("&user_id=").appending(appDelegate.USERID as String) as NSString) as String
            self.PARAMETER = parameter as NSString
            self.GetSearchList(parameter: parameter as NSString)
        }
    }
}


extension SLPPropertyListing :UITableViewDelegate,UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print( self.SearchScreenList.count)
        return self.SearchScreenList.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SLPCustomeCell1 = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell! as! SLPCustomeCell1
        print("Row number \(indexPath.row)")
        let printData = SearchScreenList[indexPath.row]
        cell.indPath = indexPath
        cell.scrollViewTapHandler = {ip in
            print("Clicked\(ip.row)")
//            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPDetailProperty") as! SLPDetailProperty
//            secondViewController.getPropertyId = self.SearchScreenList[ip.row].strId
//            //        secondViewController.getPropertId = ""
//            self.navigationController?.pushViewController(secondViewController, animated: false)
        }
        
        //        let gesture = UITapGestureRecognizer(target: self, action: #selector(SLPSearch.someAction))
        //        cell.scroll.addGestureRecognizer(gesture)
        
        cell.btnFavorit.tag = indexPath.row
        let scrollViewWidth:CGFloat = self.view.frame.width
        let scrollViewHeight:CGFloat = cell.scroll.frame.height
        var j = 0
        for i in 0..<printData.arrayPropertyImages.count{
            if i==0{
                let url =  URL(string: printData.arrayPropertyImages[i])
                let imageView = UIImageView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:scrollViewHeight))
                imageView.frame.size.width = scrollViewWidth
                imageView.sd_setImage(with: url, placeholderImage: arrayImage[i])
                cell.scroll.addSubview(imageView)
            }else{
                if j%10 == 0{
                    j = 0
                }
                j += 1
                let url =  URL(string: printData.arrayPropertyImages[i])
                let imageView = UIImageView(frame: CGRect(x:scrollViewWidth*CGFloat(i), y:0,width:scrollViewWidth, height:scrollViewHeight))
                imageView.frame.size.width = scrollViewWidth
                imageView.sd_setImage(with: url, placeholderImage: arrayImage[j])
                cell.scroll.addSubview(imageView)
            }
        }
        //"http://test2.rettest.com/slp_website/storage/app/uploads/public/590/c46/d00/590c46d00a963019050104.jpg"
        
        cell.imgStar.layer.masksToBounds = true
        print(printData.strIsFavourite)
        if printData.strIsFavourite == "1"{
            cell.imgStar.image = #imageLiteral(resourceName: "iconFillStar")
            //            cell.imgStar.tintColor = UIColor.yellow
        }else{
            cell.imgStar.image = #imageLiteral(resourceName: "iconeStar")
            cell.imgStar.tintColor = .white
        }
        //        cell.imgStar.tintColor = .white
        print(printData.strConsultantOneImage)
        let profileURL =  URL(string:  printData.strConsultantOneImage)
        cell.imgConsultantProfile.sd_setImage(with: profileURL, placeholderImage: #imageLiteral(resourceName: "Avtar"))
        cell.imgConsultantProfile.layer.masksToBounds = true
        cell.imgConsultantProfile.layer.cornerRadius = cell.imgConsultantProfile.frame.size.height/2
        cell.scroll.tag = indexPath.row
        cell.scroll.contentSize = CGSize(width:cell.scroll.frame.width * CGFloat(printData.arrayPropertyImages.count), height:cell.scroll.frame.height)
        cell.scroll.delegate = self
        
        let heading = printData.strStreetNo.appending(", ").appending(printData.strStreet)
        if printData.IsNew == "1"{
            cell.lblIsNew.text =  "New    "
        }else{
            cell.lblIsNew.text =  ""
        }
        cell.lblHeading.text = heading//printData.strHeading
        cell.lblSuburb.text = printData.strSuburb
        cell.lblPrice.text = printData.strWebsiteBroachurDisplayPrice
        cell.lblBedrooms.text = printData.strBedrooms
        cell.lblBathrooms.text = printData.strBathrooms
        cell.lblGarage.text = printData.strGarage
        cell.lblConsultantName.text = printData.strConsultantOneName
        if self.Load == "YES"{
            if indexPath.row == self.SearchScreenList.count - 2 {
                self.loadMore()
            }
        }
        return cell
    }

}
