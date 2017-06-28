//
//  SLPSearch.swift
//  SLP
//
//  Created by Hardik Davda on 6/1/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit
import SDWebImage

class SLPSearch: UIViewController {
    @IBOutlet var table: UITableView!
    @IBOutlet var viewSave : UIView!
    @IBOutlet var txtSave : UITextField!
    @IBOutlet var txtSearch : UITextField!

    @IBOutlet var sscroll: UIScrollView!
    @IBOutlet var lblTotalrecords : UILabel!
    var Load = NSString()
    var pageNumber = Int()
    var PARAMETER = NSString()
    var isSearch = Bool()
 
    var SearchScreenList = [SearchDataList]()

    var arrayImage = [#imageLiteral(resourceName: "gallery_placeholder1"),#imageLiteral(resourceName: "gallery_placeholder2"),#imageLiteral(resourceName: "gallery_placeholder3"),#imageLiteral(resourceName: "gallery_placeholder4"),#imageLiteral(resourceName: "gallery_placeholder5"),#imageLiteral(resourceName: "gallery_placeholder6"),#imageLiteral(resourceName: "gallery_placeholder7"),#imageLiteral(resourceName: "gallery_placeholder8"),#imageLiteral(resourceName: "gallery_placeholder9"),#imageLiteral(resourceName: "gallery_placeholder10"),#imageLiteral(resourceName: "gallery_placeholder6"),#imageLiteral(resourceName: "gallery_placeholder9")]

    var arrayString = ["http://wallpaper-gallery.net/images/full-hd-wallpapercom/full-hd-wallpapercom-0.jpg",
                         "http://wallpaper-gallery.net/images/full-hd-wallpapercom/full-hd-wallpapercom-10.jpg",
                         "http://wallpaper-gallery.net/images/full-hd-wallpapercom/full-hd-wallpapercom-6.jpg",
                         "http://wallpaper-gallery.net/images/full-hd-wallpapercom/full-hd-wallpapercom-5.jpg",
                         "http://wallpaper-gallery.net/images/full-hd-wallpapercom/full-hd-wallpapercom-3.jpg",
                         "http://wallpaper-gallery.net/images/full-hd-wallpapercom/full-hd-wallpapercom-2.jpg",
                         "http://wallpaper-gallery.net/images/full-hd-wallpapercom/full-hd-wallpapercom-1.jpg",
                         "http://wallpaper-gallery.net/images/full-hd-wallpapercom/full-hd-wallpapercom-13.jpg",
                         "http://wallpaper-gallery.net/images/full-hd-wallpapercom/full-hd-wallpapercom-14.jpg",
                         "http://wallpaper-gallery.net/images/full-hd-wallpapercom/full-hd-wallpapercom-17.jpg",
                         "http://wallpaper-gallery.net/images/full-hd-wallpapercom/full-hd-wallpapercom-18.jpg",
                         "http://wallpaper-gallery.net/images/full-hd-wallpapercom/full-hd-wallpapercom-0.jpg",
                         "http://wallpaper-gallery.net/images/full-hd-wallpapercom/full-hd-wallpapercom-10.jpg",
                         "http://wallpaper-gallery.net/images/full-hd-wallpapercom/full-hd-wallpapercom-6.jpg",
                         "http://wallpaper-gallery.net/images/full-hd-wallpapercom/full-hd-wallpapercom-5.jpg",
                         "http://wallpaper-gallery.net/images/full-hd-wallpapercom/full-hd-wallpapercom-3.jpg",
                         "http://wallpaper-gallery.net/images/full-hd-wallpapercom/full-hd-wallpapercom-2.jpg",
                         "http://wallpaper-gallery.net/images/full-hd-wallpapercom/full-hd-wallpapercom-1.jpg",
                         "http://wallpaper-gallery.net/images/full-hd-wallpapercom/full-hd-wallpapercom-13.jpg",
                         "http://wallpaper-gallery.net/images/full-hd-wallpapercom/full-hd-wallpapercom-14.jpg",
                         "http://wallpaper-gallery.net/images/full-hd-wallpapercom/full-hd-wallpapercom-17.jpg",
                         "http://wallpaper-gallery.net/images/full-hd-wallpapercom/full-hd-wallpapercom-18.jpg"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(appDelegate.SelectedData)
        UIApplication.shared.statusBarStyle = .lightContent
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        sscroll.isHidden = true
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk()
        
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
        
 
//        SLPAllWebservices().SearchDashboardList(with: "", API: "", completion: {(ListData,count,message) in
//            self.SearchScreenList = [SearchDataList]()
//            self.SearchScreenList = ListData
//            let printCount = ("Showing ").appending(String(self.SearchScreenList.count)).appending(" of ").appending(count).appending(" resultes")
//            self.lblTotalrecords.text = printCount
//            print("Record Count \(count)")
//            self.table.reloadData()
//        })
    }
   override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        viewSave.isHidden = true
        txtSearch.text = appDelegate.FILTERSUBURBS as String
      if appDelegate.SEARCh == "YES"{
        print ("Is Search work")
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk()
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
        appDelegate.SEARCh = "NO"
        }
        
//    print(appDelegate.SHORTINGVALUE)
        let json = JSONSerializer.toJson(appDelegate.SelectedData)
//        json = (json).appending("]")
        print("Joson data = : = = \(json)")
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor().orangColor()
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor().orangColor()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor().orangColor()
        
    }
    func setScroll() {
        let scrollViewWidth:CGFloat = self.view.frame.width
        let j = 0
        for i in 0..<10{
            if i==0{
                let imageView = UIImageView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:300))
                let url =  URL(string: arrayString[i])
                imageView.sd_setImage(with: url, placeholderImage: arrayImage[i])
                sscroll.addSubview(imageView)
            }else{
             
                let url =  URL(string: arrayString[i])
                let imageView = UIImageView(frame: CGRect(x:scrollViewWidth*CGFloat(i), y:0,width:scrollViewWidth, height:300))
                imageView.frame.size.width = scrollViewWidth
                imageView.sd_setImage(with: url, placeholderImage: arrayImage[j])
                sscroll.addSubview(imageView)
            }
        }
        sscroll.contentSize = CGSize(width:sscroll.frame.width * 10, height:sscroll.frame.height)
        sscroll.delegate = self
    }
    func someAction(_ sender: Any)  {
        print("tAp\((sender as AnyObject).tag)")
//        let VC1 = self.storyboard?.instantiateViewController(withIdentifier: "SLPDetailProperty") as! SLPDetailProperty
//        let navController = UINavigationController(rootViewController: VC1)
//        self.present(navController, animated:false, completion: nil)
        
//        sscroll.isHidden = false
//        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPDetailProperty") as! SLPDetailProperty
//        self.navigationController?.pushViewController(secondViewController, animated: false)
    }
    
    // MARK: - IBAction Methods (BUtton Click Events)
    @IBAction func SaveSearch(_ sender: Any) {
        viewSave.isHidden = false
    }

    @IBAction func Save(_ sender: Any) {
        if txtSave.text!.isEmpty {
            self.ShowAlertMessage(title: "", message: "Search name is not empty", buttonText: "OK")
        }else{
            let json = JSONSerializer.toJson(appDelegate.SelectedData)
            print("Joson data = : = = \(json)")
            let parameter = "user_id=".appending((appDelegate.USERID as String) as String).appending("&name=").appending(txtSave.text!).appending("&filter_string=").appending(json)
            SLPAllWebservices().SearchDashboardList(with: parameter, API: "", completion: {(ListData,count,message) in
                print(message)
                self.ShowAlertMessage(title: "", message: message, buttonText: "OK")
                self.viewSave.isHidden = true
            })
        }
    }

    @IBAction func Cancel(_ sender: Any) {
        viewSave.isHidden = true
    }
    
    @IBAction func Search(_ sender: Any) {
//        sscroll.isHidden = true
   
        let storyBoard : UIStoryboard = UIStoryboard(name: "SEARCH", bundle:nil)
        let VC1 = storyBoard.instantiateViewController(withIdentifier: "SLPAdvanceSearch") as! SLPAdvanceSearch
        let navController = UINavigationController(rootViewController: VC1) // Creating a navigation controller with VC1 at the root of the navigation stack.
        self.present(navController, animated:true, completion: nil)

        
        //        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SLPAdvanceSearch") as! SLPAdvanceSearch
        //        self.navigationController?.present(nextViewController, animated: true, completion: nil)
        
//        [self.navigationController presentViewController:navigationController animated:YES completion:nil];
//        self.navigationController?.pushViewController(secondViewController, animated: true)
//        self.present(nextViewController, animated:true, completion:nil)
    }
    @IBAction func searchSuburb(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "SEARCH", bundle:nil)
        let VC1 = storyBoard.instantiateViewController(withIdentifier: "SLPSuburb") as! SLPSuburb
        let navController = UINavigationController(rootViewController: VC1)
        self.present(navController, animated:true, completion: nil)
    }
    @IBAction func CancelSuburb(_ sender: UIButton) {
    if appDelegate.SelectedData.strSuburbsId != "" && appDelegate.SelectedData.strSuburbsId != "Any"{
        appDelegate.SelectedData.strSuburbsId = ""
        appDelegate.SelectedData.strSuburbs = ""
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
    }
    
    @IBAction func Sort(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "SEARCH", bundle:nil)
        
//        let second = storyBoard.instantiateViewController(withIdentifier: "SLPShortListingBy") as! SLPShortListingBy
        
        let VC1 = storyBoard.instantiateViewController(withIdentifier: "SLPShortListingBy") as! SLPShortListingBy
        VC1.isSearch = true
        
        let navController = UINavigationController(rootViewController: VC1)
        
        self.present(navController, animated:true, completion: nil)
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        print(currentPage,scrollView.tag)
        
        var frame: CGRect = self.sscroll.frame
        frame.origin.x = frame.size.width * CGFloat(currentPage);
//        frame.origin.y = 0;
        self.sscroll.scrollRectToVisible(frame, animated: true)
        
//        // Change the indicator
//        self.pageControl.currentPage = Int(currentPage);
//        // Change the text accordingly
//        if Int(currentPage) == 0{
//            textView.text = "Sweettutos.com is your blog of choice for Mobile tutorials"
//        }else if Int(currentPage) == 1{
//            textView.text = "I write mobile tutorials mainly targeting iOS"
//        }else if Int(currentPage) == 2{
//            textView.text = "And sometimes I write games tutorials about Unity"
//        }else{
//            textView.text = "Keep visiting sweettutos.com for new coming tutorials, and don't forget to subscribe to be notified by email :)"
//            // Show the "Let's Start" button in the last slide (with a fade in animation)
//            UIView.animate(withDuration: 1.0, animations: { () -> Void in
//                self.startButton.alpha = 1.0
//            })
//        }
    }
    func favorits( parameter : String){
        SLPAllWebservices().FavoritProperty(with: parameter, API: "", completion: {(message,status)in
          print(message)
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
  
    func GetSearchList(parameter :NSString){
        
        var parameter = ""
        if appDelegate.SelectedData.strKeyword != "" && appDelegate.SelectedData.strKeyword != "Any"{
            parameter = (parameter.appending("&global_search=").appending(appDelegate.SelectedData.strKeyword!) as NSString) as String
        }
         if appDelegate.SelectedData.strInspectionSchedule != "" && appDelegate.SelectedData.strInspectionSchedule != "Any"{
        parameter = (parameter.appending("&custom_search_inspection_scheduled=").appending(appDelegate.SelectedData.strInspectionSchedule!) as NSString) as String
        }
         if appDelegate.SelectedData.strSuburbsId != "" && appDelegate.SelectedData.strSuburbsId != "Any"{
            parameter = (parameter.appending("&custom_search_suburb_id=").appending(appDelegate.SelectedData.strSuburbsId!) as NSString) as String
        }
         if appDelegate.SelectedData.strPropertyTypeId != "" && appDelegate.SelectedData.strPropertyTypeId != "Any"{
            parameter = (parameter.appending("&custom_search_property_type_id=").appending(appDelegate.SelectedData.strPropertyTypeId!) as NSString) as String
        }
         if appDelegate.SelectedData.strPriceMin != "" && appDelegate.SelectedData.strPriceMin != "Any"{
            var price = appDelegate.SelectedData.strPriceMin!.replacingOccurrences(of: "$", with: "")
            price = price.replacingOccurrences(of: ",", with: "")
            print(price)
            parameter = (parameter.appending("&custom_search_property_price_from=").appending(price) as NSString) as String
        }
         if appDelegate.SelectedData.strPriceMax != "" && appDelegate.SelectedData.strPriceMax != "Any"{
            var price = appDelegate.SelectedData.strPriceMax!.replacingOccurrences(of: "$", with: "")
            price = price.replacingOccurrences(of: ",", with: "")
            
            parameter = (parameter.appending("&custom_search_property_price_to=").appending(price) as NSString) as String
        }
         if appDelegate.SelectedData.strGarage != "" && appDelegate.SelectedData.strGarage != "Any"{
            parameter = (parameter.appending("&custom_search_garage=").appending(appDelegate.SelectedData.strGarage!) as NSString) as String
        }
         if appDelegate.SelectedData.boolSurroundingSuburb!{
                parameter = (parameter.appending("&custom_search_surrounding=").appending("1") as NSString) as String
        }
         if appDelegate.SelectedData.strBedroomsMin != "" && appDelegate.SelectedData.strBedroomsMin != "Any"{
            parameter = (parameter.appending("&custom_search_minbedrooms=").appending(appDelegate.SelectedData.strBedroomsMin!) as NSString) as String
        }
         if appDelegate.SelectedData.strBedroomsMax != "" && appDelegate.SelectedData.strBedroomsMax != "Any"{
            parameter = (parameter.appending("&custom_search_maxbedrooms=").appending(appDelegate.SelectedData.strBedroomsMax!) as NSString) as String
        }
         if appDelegate.SelectedData.strBathroomsMin != "" && appDelegate.SelectedData.strBathroomsMin != "Any"{
            parameter = (parameter.appending("&custom_search_minbathrooms=").appending(appDelegate.SelectedData.strBathroomsMin!) as NSString) as String
        }
         if appDelegate.SelectedData.strLandSizeMin != "" && appDelegate.SelectedData.strLandSizeMin != "Any"{
            let land = appDelegate.SelectedData.strLandSizeMin!.replacingOccurrences(of: "m2", with: "")
            print(land)

            parameter = (parameter.appending("&custom_search_minlandsize=").appending(land) as NSString) as String
        }
         if appDelegate.SelectedData.strLandSizeMax != "" && appDelegate.SelectedData.strLandSizeMax != "Any"{
            let land = appDelegate.SelectedData.strLandSizeMax!.replacingOccurrences(of: "m2", with: "")
            print(land)
            
            parameter = (parameter.appending("&custom_search_maxlandsize=").appending(land) as NSString) as String
        }
         if appDelegate.SelectedData.boolExcludeUnderOffer!{
            parameter = (parameter.appending("&is_excluding_offer=").appending("1") as NSString) as String
        }
         if appDelegate.SelectedData.strSort != "" && appDelegate.SelectedData.strSort != "Any"{
            parameter = (parameter.appending("&sort=").appending(appDelegate.SelectedData.strSort!) as NSString) as String
        }
        //        parameter = (parameter.appending("").appending("") as NSString) as String
         self.PARAMETER =  self.PARAMETER.appending(parameter) as NSString
        print(self.PARAMETER)
        
        SLPAllWebservices().SearchDashboardList(with: self.PARAMETER as String, API: "", completion: {(ListData,count,message) in
           print(message)
            
            if message == "No Records Found."{
                self.Load = "NO"
                self.hideProgressHUD()
                self.table.reloadData()
                if self.SearchScreenList.count == 0{
                    self.lblTotalrecords.text = "No property Available."
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
            self.lblTotalrecords.text = printCount
                print("Record Count \(count)")
                self.table.reloadData()
                self.hideProgressHUD()
            }
        })
        
//        AllMethods().callDetail(with: parameter as String, Page: pageNumber, completion: { (dashboardData) in
//            if self.DashboardData.count == dashboardData.count && dashboardData.count != 15 {
//                self.Load = "NO"
//            }
//            self.DashboardData = dashboardData
//            self.viewAdvanceSearch.isHidden = true
//            self.NoData = "No Data Available"
//            self.table.reloadData()
//        })
    }

    
    func ShowAlertMessage(title : String, message: String, buttonText : String)  {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension SLPSearch :UITableViewDelegate,UITableViewDataSource{
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
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPDetailProperty") as! SLPDetailProperty
            secondViewController.getPropertyId = self.SearchScreenList[ip.row].strId
            //        secondViewController.getPropertId = ""
            self.navigationController?.pushViewController(secondViewController, animated: false)
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
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?{
//        sscroll.isHidden = false
        
//        let VC1 = self.storyboard?.instantiateViewController(withIdentifier: "SLPDetailProperty") as! SLPDetailProperty
//        let navController = UINavigationController(rootViewController: VC1)
//        
//        self.present(navController, animated:false, completion: nil)
////        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPDetailProperty") as! SLPDetailProperty
        secondViewController.getPropertyId = SearchScreenList[indexPath.row].strId
//        secondViewController.getPropertId = ""
        self.navigationController?.pushViewController(secondViewController, animated: false)
        return indexPath
    }
}

extension SLPSearch : UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    // called when 'return' key pressed. return NO to ignore.
}
