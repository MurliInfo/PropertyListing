//
//  SLPShortlist.swift
//  SLP
//
//  Created by Hardik Davda on 6/1/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit
import SDWebImage

class SLPShortlist: UIViewController {
    @IBOutlet var table: UITableView!
//    @IBOutlet var sscroll: UIScrollView!
//    @IBOutlet var lblTotalrecords : UILabel!
    var Load = NSString()
    var pageNumber = Int()
    var PARAMETER = NSString()
    
    var SearchScreenList = [SearchDataList]()
    
    var arrayImage = [#imageLiteral(resourceName: "gallery_placeholder1"),#imageLiteral(resourceName: "gallery_placeholder2"),#imageLiteral(resourceName: "gallery_placeholder3"),#imageLiteral(resourceName: "gallery_placeholder4"),#imageLiteral(resourceName: "gallery_placeholder5"),#imageLiteral(resourceName: "gallery_placeholder6"),#imageLiteral(resourceName: "gallery_placeholder7"),#imageLiteral(resourceName: "gallery_placeholder8"),#imageLiteral(resourceName: "gallery_placeholder9"),#imageLiteral(resourceName: "gallery_placeholder10"),#imageLiteral(resourceName: "gallery_placeholder6"),#imageLiteral(resourceName: "gallery_placeholder9")]
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk()
        
        
        
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
        //    print(appDelegate.SHORTINGVALUE)
        
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor().hexStringToUIColor(hex: "F37C2D")
        
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor().hexStringToUIColor(hex: "F37C2D")
        
        DispatchQueue.main.async {
//            var parameter = NSString()
            self.pageNumber = 1;
            self.Load = "YES"
           var parameter = "page="
            let Page = self.pageNumber as NSNumber
            parameter = (parameter.appending(Page.stringValue as String).appending("&user_id=").appending(appDelegate.USERID as String).appending("&listing_type=favourite") as NSString) as String
            self.PARAMETER = parameter as NSString
            self.SearchScreenList = [SearchDataList]()
            self.showProgressHUD()
            self.GetSearchList(parameter: parameter as NSString)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor().hexStringToUIColor(hex: "F37C2D")
        
    }

    func someAction()  {
        print("tAp")
        //        let VC1 = self.storyboard?.instantiateViewController(withIdentifier: "SLPDetailProperty") as! SLPDetailProperty
        //        let navController = UINavigationController(rootViewController: VC1)
        //        self.present(navController, animated:false, completion: nil)
        
        //        sscroll.isHidden = false
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPDetailProperty") as! SLPDetailProperty
        self.navigationController?.pushViewController(secondViewController, animated: false)
        
    }
    // MARK: - IBAction Methods (BUtton Click Events)
    
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
    
    @IBAction func Sort(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "SEARCH", bundle:nil)
        let VC1 = storyBoard.instantiateViewController(withIdentifier: "SLPShortListingBy") as! SLPShortListingBy
        VC1.isSearch = false
        
        let navController = UINavigationController(rootViewController: VC1)
        self.present(navController, animated:true, completion: nil)
    }
  
    func loadMore(){
        DispatchQueue.main.async {
            self.Load = "NO"
            let Page = self.pageNumber as NSNumber
            //            var parameter = self.PARAMETER
            var parameter = "page="
            parameter = (parameter.appending(Page.stringValue as String).appending("&user_id=").appending(appDelegate.USERID as String).appending("&listing_type=favourite") as NSString) as String

//            parameter = (parameter.appending(Page.stringValue as String) as NSString) as String
            self.PARAMETER = parameter as NSString
            self.GetSearchList(parameter: parameter as NSString)
        }
    }
    
    func GetSearchList(parameter :NSString){
        SLPAllWebservices().SearchDashboardList(with: self.PARAMETER as String, API: "", completion: {(ListData,count,message) in
            print(message)
            if message == "No Records Found."{
                self.Load = "NO"
                self.hideProgressHUD()
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
//                let printCount = ("Showing ").appending(String(self.SearchScreenList.count)).appending(" of ").appending(count).appending(" resultes")
//                self.lblTotalrecords.text = printCount
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
    
    
    
}

extension SLPShortlist :UITableViewDelegate,UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print( self.SearchScreenList.count)
        return self.SearchScreenList.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SLPCustomCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell! as! SLPCustomCell
        print("Row number \(indexPath.row)")
        cell.scroll.tag = indexPath.row
        let printData = SearchScreenList[indexPath.row]
        let gesture = UITapGestureRecognizer(target: self, action: #selector(SLPSearch.someAction))
        cell.scroll.addGestureRecognizer(gesture)
        
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
        let profileURL =  URL(string:  printData.strConsultantOneImage)//"http://test2.rettest.com/slp_website/storage/app/uploads/public/590/c46/d00/590c46d00a963019050104.jpg"
        cell.imgConsultantProfile.sd_setImage(with: profileURL, placeholderImage: #imageLiteral(resourceName: "Avtar"))
        
        cell.imgConsultantProfile.layer.masksToBounds = true
        cell.imgStar.layer.masksToBounds = true
        cell.imgStar.tintColor = .white
        cell.imgConsultantProfile.layer.cornerRadius = cell.imgConsultantProfile.frame.size.height/2
        cell.scroll.tag = indexPath.row
        cell.scroll.contentSize = CGSize(width:cell.scroll.frame.width * CGFloat(printData.arrayPropertyImages.count), height:cell.scroll.frame.height)
        cell.scroll.delegate = self
        
        let heading = printData.strStreetNo.appending(", ").appending(printData.strStreet)

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
        self.navigationController?.pushViewController(secondViewController, animated: false)
        return indexPath
    }
}
