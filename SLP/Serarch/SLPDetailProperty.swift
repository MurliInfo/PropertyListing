//
//  SLPDetailProperty.swift
//  SLP
//
//  Created by Hardik Davda on 6/5/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit
import SDWebImage
import MapKit
import CoreLocation


class SLPDetailProperty: UIViewController,UIScrollViewDelegate {
    // MARK: - Declaration
    @IBOutlet var sscroll: UIScrollView!
    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet var scrollBottom: NSLayoutConstraint!
    // MARK: - UIView
    @IBOutlet var viewPrevie: UIView!
    @IBOutlet var scrollPrive: UIScrollView!
    @IBOutlet var viewPrice: UIView!
    @IBOutlet var viewAboutProperty: UIView!
    @IBOutlet var viewPropertyMap: UIView!
    @IBOutlet var viewOpacityDown: UIView!
    @IBOutlet var viewAgentProfile: UIView!
    @IBOutlet var viewAgentProfileSecond: UIView!
    @IBOutlet var viewInspection: UIView!
    @IBOutlet var viewEmailMe: UIView!
    @IBOutlet var viewNavigation: UIView!
    // MARK: - UILable
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var lblShowPrice: UILabel!
    @IBOutlet var lblSuburb: UILabel!
    @IBOutlet var lblAddress: UILabel!
    @IBOutlet var lblBedrooms: UILabel!
    @IBOutlet var lblBathrooms: UILabel!
    @IBOutlet var lblGarage: UILabel!
    @IBOutlet var lblConsultantOneName: UILabel!
    @IBOutlet var lblConsultantOneType: UILabel!
    @IBOutlet var lblConsultantOneEmail: UILabel!
    @IBOutlet var lblConsultantOnePhoneNumber: UILabel!
    @IBOutlet var lblConsultantTwoName: UILabel!
    @IBOutlet var lblConsultantTwoType: UILabel!
    @IBOutlet var lblConsultantTwoEmail: UILabel!
    @IBOutlet var lblConsultantTwoPhoneNumber: UILabel!

    @IBOutlet var lblOneHomeOpenDate: UILabel!
    @IBOutlet var lblOneHomeOpenTime: UILabel!
    @IBOutlet var btnViewProfile: UIButton!
    @IBOutlet var btnCallMe: UIButton!
    @IBOutlet var imgProfile1: UIImageView!
   
    
    @IBOutlet var lblTwoHomeOpenDate: UILabel!
    @IBOutlet var lblTwoHomeOpenTime: UILabel!

    @IBOutlet var btnCallLeadingConstraint: NSLayoutConstraint!
    
    // MARK: - UIButton
    @IBOutlet var btnReadMore: UIButton!

    // MARK: - UITextField
    @IBOutlet var txtName : UITextField!
    @IBOutlet var txtPhone : UITextField!
    @IBOutlet var txtEmail : UITextField!
    // MARK: - UitextView
    @IBOutlet var txtMessage : UITextView!
    // MARK: - Constarin
    @IBOutlet var slider: NSLayoutConstraint!

    // MARK: - Local declaration
    var DetailScreenList = [SearchDetailsDataList]()
    var lblCount: UILabel!
    var Y : Int = 0
    
    let font = UIFont.systemFont(ofSize: 13)
    var hight : CGFloat = 0.0
  
    var getPropertyId = String()
    
    var location = CLLocationCoordinate2D(latitude: -38.1949627 ,longitude: 146.0048128)
    
    var arrayImage = [#imageLiteral(resourceName: "gallery_placeholder1"),#imageLiteral(resourceName: "gallery_placeholder2"),#imageLiteral(resourceName: "gallery_placeholder3"),#imageLiteral(resourceName: "gallery_placeholder4"),#imageLiteral(resourceName: "gallery_placeholder5"),#imageLiteral(resourceName: "gallery_placeholder6"),#imageLiteral(resourceName: "gallery_placeholder7"),#imageLiteral(resourceName: "gallery_placeholder8"),#imageLiteral(resourceName: "gallery_placeholder9"),#imageLiteral(resourceName: "gallery_placeholder10"),#imageLiteral(resourceName: "gallery_placeholder1"),#imageLiteral(resourceName: "gallery_placeholder2"),#imageLiteral(resourceName: "gallery_placeholder3"),#imageLiteral(resourceName: "gallery_placeholder4"),#imageLiteral(resourceName: "gallery_placeholder5"),#imageLiteral(resourceName: "gallery_placeholder6"),#imageLiteral(resourceName: "gallery_placeholder7"),#imageLiteral(resourceName: "gallery_placeholder8"),#imageLiteral(resourceName: "gallery_placeholder9"),#imageLiteral(resourceName: "gallery_placeholder10"),#imageLiteral(resourceName: "gallery_placeholder1"),#imageLiteral(resourceName: "gallery_placeholder2"),#imageLiteral(resourceName: "gallery_placeholder3"),#imageLiteral(resourceName: "gallery_placeholder4"),#imageLiteral(resourceName: "gallery_placeholder5"),#imageLiteral(resourceName: "gallery_placeholder6"),#imageLiteral(resourceName: "gallery_placeholder7"),#imageLiteral(resourceName: "gallery_placeholder8"),#imageLiteral(resourceName: "gallery_placeholder9"),#imageLiteral(resourceName: "gallery_placeholder10"),#imageLiteral(resourceName: "gallery_placeholder1"),#imageLiteral(resourceName: "gallery_placeholder2"),#imageLiteral(resourceName: "gallery_placeholder3"),#imageLiteral(resourceName: "gallery_placeholder4"),#imageLiteral(resourceName: "gallery_placeholder5"),#imageLiteral(resourceName: "gallery_placeholder6"),#imageLiteral(resourceName: "gallery_placeholder7"),#imageLiteral(resourceName: "gallery_placeholder8"),#imageLiteral(resourceName: "gallery_placeholder9"),#imageLiteral(resourceName: "gallery_placeholder10")]
    
    var arrayString = Array<String>()
    
    var scrollView = UIScrollView(frame: CGRect(x:0, y:0, width:320,height: 300))
    
    var currentPreviewPage: Int = 0

    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
       
        sscroll.delegate = self
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        sscroll.addSubview(scrollView)
        
        scrollPrive.delegate = self
        scrollPrive.isPagingEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(SLPDetailProperty.someAction))
        viewPrevie.addGestureRecognizer(gesture)
        
        viewPrevie.isHidden = true

        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk()
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(keyboardWillShow(notification:)),
                           name: .UIKeyboardWillShow,
                           object: nil)
        
        center.addObserver(self,
                           selector: #selector(keyboardWillHide(notification:) ),
                           name: .UIKeyboardWillHide,
                           object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = UIColor.clear
        DispatchQueue.main.async {
            self.getDetail()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
  
    // MARK: - IBAction Methods (Button Click Events)
    @IBAction func florPlan(_ sender: Any) {
    
    }
    @IBAction func fevorites(_ sender: Any) {
        print("Fevorites")
    }
    @IBAction func shareDetail(_ sender: Any) {
        print("ShareDetails")
    }

    @IBAction func readMore(_ sender: Any) {
        if btnReadMore.tag == 1{
            btnReadMore.tag = 2;
            btnReadMore.titleLabel?.text = ""
            btnReadMore.setTitle("READ LESS",for: .normal)

            viewOpacityDown.isHidden = true
            viewPropertyMap.removeFromSuperview()
            viewPropertyMap.frame = (CGRect(x: 0, y: hight+430-35, width: self.view.frame.width, height:350))
            self.sscroll.addSubview(viewPropertyMap)
            self.manageDesign()
        }else{
            btnReadMore.tag = 1
            btnReadMore.setTitle("READ MORE",for: .normal)
            viewOpacityDown.isHidden = false
            viewPropertyMap.removeFromSuperview()
            viewPropertyMap.frame = (CGRect(x: 0, y: 430+135, width: self.view.frame.width, height:350))
            self.sscroll.addSubview(viewPropertyMap)
            self.manageDesign()
        }
    }
    
    @IBAction func viewProfile(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPViewProfile") as! SLPViewProfile
        secondViewController.getCounsultantId = DetailScreenList[0].strConsultantOneId
        self.present(secondViewController, animated: true, completion: nil)
//        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
  
    @IBAction func callMe(_ sender: Any) {
        let str =  (DetailScreenList[0].strConsultantOneMobile.replacingOccurrences(of: " ", with: ""))
        let mobile = ("tel://").appending(str)
        if let url = URL(string: mobile) {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func sendEnquiry(_ sender: Any) {
        if (txtName.text?.isEmpty)!{
            self.ShowAlertMessage(title: "Please enter valid name.", message: "", buttonText: "OK")
        }else
        if (txtEmail.text?.isEmpty)!{
            self.ShowAlertMessage(title: "Please enter valid email address.", message: "", buttonText: "OK")
        }else
        if (txtPhone.text?.isEmpty)!{
            self.ShowAlertMessage(title: "", message: "Please enter valid phone number.", buttonText: "OK")
        }else
        if (txtMessage.text?.isEmpty)!{
                self.ShowAlertMessage(title: "", message: "Please enter valid message.", buttonText: "OK")
        }else{
            let paramter = "name=".appending(txtName.text!).appending("&from_email=").appending(txtEmail.text!).appending("&to_email=").appending(DetailScreenList[0].strConsultantOneEmail).appending("&phone=").appending(txtPhone.text!).appending("&message=").appending(txtMessage.text!).appending("&consultant_name=").appending(DetailScreenList[0].strConsultantOneName).appending("&property_id=").appending(getPropertyId)
          
            SLPAllWebservices().sendEnquiryDetail(with: paramter, API: "", completion: {(message,status)in
                self.ShowAlertMessage(title: "", message: message, buttonText: "OK")
            })
            
        }
    }

    @IBAction func formSubmit(_ sender: Any) {
        
    }
    
    func someAction()  {
        print("tAp")
        viewPrevie.isHidden = true
        
        //        let VC1 = self.storyboard?.instantiateViewController(withIdentifier: "SLPDetailProperty") as! SLPDetailProperty
        //        let navController = UINavigationController(rootViewController: VC1)
        //        self.present(navController, animated:false, completion: nil)
        
        //        sscroll.isHidden = false
        
    }
    func someAction1()  {
        print("tAp1")
        //viewPrevie.isHidden = false
        let array = self.arrayString
        let imagePreviewer = ImagePreviewController(images: array, placeholderImage: nil, previewIndex: self.currentPreviewPage)
        let navController = UINavigationController(rootViewController: imagePreviewer)
        self.present(navController, animated: true, completion: nil)
        print(array)
        
        //        let VC1 = self.storyboard?.instantiateViewController(withIdentifier: "SLPDetailProperty") as! SLPDetailProperty
        //        let navController = UINavigationController(rootViewController: VC1)
        //        self.present(navController, animated:false, completion: nil)
        
        //        sscroll.isHidden = false
        
    }

    // MARK: - User Define Methods (UDF)
//    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
//        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
//        label.numberOfLines = 0
//        label.lineBreakMode = NSLineBreakMode.byWordWrapping
//        label.font = font
//        label.text = text
//        label.sizeToFit()
//        
//        return label.frame.height
//    }
    
    func setScroll() {
        scrollPrive.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        
        Y = 0
        scrollView = UIScrollView(frame: CGRect(x:0, y:CGFloat(Y), width:self.view.frame.width,height: 300))
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        Y = Int(scrollView.frame.size.height);
        let scrollViewWidth:CGFloat = self.view.frame.width
        viewPrice.frame = (CGRect(x: 0, y: CGFloat(Y), width: self.view.frame.width, height: 130))
        self.sscroll.addSubview(viewPrice)
        
        Y = Int(scrollView.frame.size.height+viewPrice.frame.size.height);

        hight = GlobalMethods().heightForView(text: lblDescription.text!, font: font, width: self.view.frame.size.width-32)+81
        viewAboutProperty.frame = (CGRect(x: 0, y: CGFloat(Y), width: self.view.frame.width, height: hight))
        self.sscroll.addSubview(viewAboutProperty)

        Y = Int(scrollView.frame.size.height+viewPrice.frame.size.height+viewAboutProperty.frame.size.height);
        
        viewPropertyMap.frame = (CGRect(x: 0, y: 430+135, width: self.view.frame.width, height: 400))
        self.sscroll.addSubview(viewPropertyMap)
        
        print(self.view.frame.size.width)
        
        self.manageDesign()
//        let view_1 = UIView(frame: CGRect(x: 0, y: 300, width: self.view.frame.width, height: 700))
//        view_1.backgroundColor = UIColor.blue
//        sscroll.addSubview(view_1)
        
//        viewPrice.frame(forAlignmentRect: CGRect(x: 0, y: 300, width: self.view.frame.width, height: 300))
//        sscroll.addSubview(viewPrice)

//        scrollSlider.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: scrollViewWidth, height: 300))
//        scrollSlider = UIScrollView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:150))
//         sscroll.addSubview(scrollSlider)
        
        //        let scrollViewHeight:CGFloat = sscroll.frame.height
         var j = 0
        
        for i in 0..<arrayString.count{
            if i==0{
                
                let imageView = UIImageView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:300))
                let url =  URL(string: arrayString[i])
                imageView.sd_setImage(with: url, placeholderImage: arrayImage[i])
                scrollView.addSubview(imageView)
                
 //for priview
                let imageView1 = UIImageView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:scrollPrive.frame.size.height))
                imageView1.contentMode = .scaleAspectFit

                let url1 =  URL(string: arrayString[i])
                imageView1.sd_setImage(with: url1, placeholderImage: arrayImage[i])
                scrollPrive.addSubview(imageView1)
            }else{
                if j%10 == 0{
                    j = 0
                }
                j += 1
                let url =  URL(string: arrayString[i])
                let imageView = UIImageView(frame: CGRect(x:scrollViewWidth*CGFloat(i), y:0,width:scrollViewWidth, height:300))
                imageView.frame.size.width = scrollViewWidth
                imageView.sd_setImage(with: url, placeholderImage: arrayImage[j])
                scrollView.addSubview(imageView)

//for priview
                
                let imageView1 = UIImageView(frame: CGRect(x:scrollViewWidth*CGFloat(i), y:0,width:scrollViewWidth, height:scrollPrive.frame.size.height))
                imageView1.contentMode = .scaleAspectFit
                
                let url1 =  URL(string: arrayString[i])
                imageView1.sd_setImage(with: url1, placeholderImage: arrayImage[i])
                scrollPrive.addSubview(imageView1)
            }
        }
        scrollPrive.contentSize = CGSize(width:scrollView.frame.width * CGFloat(arrayString.count), height:scrollView.frame.height)
//        scrollPrive.contentSize = CGSize(width:scrollView.frame.width * CGFloat(arrayString.count), height:scrollView.frame.height)
        
        sscroll.addSubview(scrollView)
        
        let imageView = UIImageView(frame: CGRect(x:scrollViewWidth-120, y:250,width:100, height:35))
        imageView.image = #imageLiteral(resourceName: "bgCount")
        sscroll.addSubview(imageView)
        var count = "1".appending("/")
        count = count.appending(String(arrayString.count))
        lblCount = UILabel(frame: CGRect(x:scrollViewWidth-115, y:250,width:100, height:35))
        lblCount.text = count
        lblCount.textColor = .white
        lblCount.textAlignment = .center
        lblCount.backgroundColor = UIColor.clear
        sscroll.addSubview(lblCount)
        
        scrollView.contentSize = CGSize(width:scrollView.frame.width * CGFloat(arrayString.count), height:scrollView.frame.height)
        self.hideProgressHUD()

        let gesture = UITapGestureRecognizer(target: self, action: #selector(SLPDetailProperty.someAction1))
        scrollView.addGestureRecognizer(gesture)

//        sscroll.contentSize = CGSize(width:self.view.frame.width, height:sscroll.frame.height+700)

//        scrollSlider = UIScrollView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:150))
//
//        sscroll.addSubview(scrollSlider)
//        scrollSlider.delegate = self
    }
    
    
    func manageDesign(){
        
        Y = Int(viewPropertyMap.frame.origin.y+viewPropertyMap.frame.size.height);
        
        viewAgentProfile.frame = (CGRect(x: 0, y: CGFloat(Y), width: self.view.frame.width, height: 218))
        self.sscroll.addSubview(viewAgentProfile)
        
         Y = Int(viewAgentProfile.frame.origin.y+viewAgentProfile.frame.size.height);
        
        print(self.DetailScreenList[0].structHomeOpenData)
        
        if self.DetailScreenList[0].structHomeOpenData.count != 0 {
            viewInspection.frame = (CGRect(x: 0, y: CGFloat(Y), width: self.view.frame.width, height: 180))
            self.sscroll.addSubview(viewInspection)
            Y = Int(viewInspection.frame.origin.y+viewInspection.frame.size.height);
        }
        
        viewEmailMe.frame = (CGRect(x: 0, y: CGFloat(Y), width: self.view.frame.width, height: 382))
        self.sscroll.addSubview(viewEmailMe)
        Y = Int(viewEmailMe.frame.origin.y+viewEmailMe.frame.size.height);
        let profileURL =  URL(string:  DetailScreenList[0].strConsultantOneImage)//"http://test2.rettest.com/slp_website/storage/app/uploads/public/590/c46/d00/590c46d00a963019050104.jpg"
        imgProfile1.sd_setImage(with: profileURL, placeholderImage: nil)
        
        self.btnViewProfile.layer.borderWidth = 1.0
        self.btnViewProfile.layer.borderColor = UIColor().orangColor().cgColor
        
        if(self.view.frame.size.width > CGFloat(325)){
            self.btnViewProfile.setTitle("  VIEW PROFILE  ", for: .normal)
            self.btnCallMe.setTitle("  CALL ME  ", for: .normal)
            self.btnCallMe.contentEdgeInsets = UIEdgeInsetsMake(5,5,5,5)
            btnCallLeadingConstraint.constant = 10
        }else{
            self.btnViewProfile.setTitle("VIEW PROFILE", for: .normal)
            self.btnCallMe.setTitle("CALL ME", for: .normal)
            btnCallLeadingConstraint.constant = 2
        }
        
    // mapview.mapType = .standard
        
//        scrollView.contentSize = CGSize(width:scrollView.frame.width * 10, height:scrollView.frame.height)
        sscroll.contentSize = CGSize(width:self.view.frame.width, height:viewEmailMe.frame.height+viewEmailMe.frame.origin.y)
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as! CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.mapview.setRegion(region, animated: true)
    }
    
    func getDetail()  {
        self.showProgressHUD()
        DispatchQueue.main.async {
            var parameter = String()
            parameter.append(("id=").appending(self.getPropertyId))

            SLPAllWebservices().SearchDashboardDetailList(with: parameter as String, API: "", completion: {(ListData,count,message,status) in
                
                if status{
                    self.DetailScreenList = ListData
                    self.arrayString = self.DetailScreenList[0].arrayPropertyImages
                    self.lblAddress.text = (self.DetailScreenList[0].strStreetNumber).appending(" ").appending(self.DetailScreenList[0].strStreet).appending(" ").appending(self.DetailScreenList[0].strState)
//                street_number": "L4",
//                "street": "Shore Lane",
//                "state": "WA",
                    self.lblSuburb.text = self.DetailScreenList[0].strSuburb
                    self.lblConsultantOneName.text = self.DetailScreenList[0].strConsultantOneName
                    self.lblConsultantOneType.text = self.DetailScreenList[0].strConsultantOnePosition
                    self.lblShowPrice.text = self.DetailScreenList[0].strWebsiteBrochureDisplayPrice
                    self.lblBedrooms.text = self.DetailScreenList[0].strBedrooms
                    self.lblBathrooms.text = self.DetailScreenList[0].strBathrooms
                    self.lblGarage.text = self.DetailScreenList[0].strGarage
                    self.lblTitle.text = self.DetailScreenList[0].strHeading
                    self.lblDescription.text = self.DetailScreenList[0].strDescription
                    self.lblDescription.text = self.DetailScreenList[0].strDescription.removeTag()
                
                    let latitude = self.DetailScreenList[0].strLatitude as String
                    let longitute11 = self.DetailScreenList[0].strLongitude as String
                    
                    let latitudeDegrees : CLLocationDegrees = Double(latitude)!
                    let longitude : CLLocationDegrees = Double(longitute11)!
//                    let longitudeDegrees : CLLocationDegress = Double(longitute)!

                    self.location = CLLocationCoordinate2D(latitude: latitudeDegrees ,longitude: longitude)
                    
                    //
                    self.mapview.showsUserLocation = true
                    //        mapview.showsScale = true
                    //        mapview.showsCompass = true

                    let span = MKCoordinateSpan(latitudeDelta: 0.05,longitudeDelta: 0.05)
                    let region = MKCoordinateRegion(center: self.location, span: span)
                    self.mapview.setRegion(region, animated: true)
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = self.location
                    annotation.title = "Demo"
                    annotation.subtitle = "shdjk"
                    self.mapview.addAnnotation(annotation)
                    //
                    if self.DetailScreenList[0].structHomeOpenData.count != 0 {
                        self.lblOneHomeOpenDate.text = self.DetailScreenList[0].structHomeOpenData[0].strdate
                        self.lblOneHomeOpenTime.text = self.DetailScreenList[0].structHomeOpenData[0].strstart_time
                    }
                    DispatchQueue.main.async {
                        self.setScroll()
                    }
                }else{
                    self.hideProgressHUD()
                }
            })
        }
    }
    // MARK: - ScrollView Delegate Methods
    
    
    func scrollViewDidScroll(_ scrollView1: UIScrollView) {
        if scrollView1 == sscroll{
            let scr = scrollView1.contentOffset.y
            if (0>scr){
//                let abc = abs(scr)
//                scrollView.frame = CGRect(x:scr, y:CGFloat(scr), width:self.scrollView.frame.width*abc,height: CGFloat(300+abc)) // set new position exactly

//                scrollView.backgroundColor = .blue
                scrollView1.frame.origin.y = scr ///
//                scrollView.frame.size.height = 300+abc
//                scrollView.frame.origin.x = scr*2
//                scrollView.frame.size.width = scr*4
            }
//            if (0>scr){
//                scrollView.frame.origin.y = 0
//            }
            if (0 < scr && scr < 250){
                if (0 < scr && scr < 25){
                    viewNavigation.alpha = 0
                }
                if (25 < scr && scr < 50){
                    viewNavigation.alpha = 0.15
                }
                if (50 < scr && scr < 75){
                    viewNavigation.alpha = 0.30
                }
                if (75 < scr && scr < 100){
                    viewNavigation.alpha = 0.45
                }
                if (100 < scr && scr < 125){
                    viewNavigation.alpha = 0.60
                }
                if (125 < scr && scr < 150){
                    viewNavigation.alpha = 0.75
                }
                if (150 < scr && scr < 200){
                    viewNavigation.alpha = 0.80
                }
                if (200 < scr && scr < 250){
                    viewNavigation.alpha = 0.90
                }
            }
            if (250 < scr){
                viewNavigation.alpha = 1.0
            }
            
        }else {
            
        }
        
        if scrollView1 == sscroll{
//            print("received scroll")
////            let scr = scrollView.contentOffset.y
//            if(scrollView.contentOffset.y<400){
//               let scrollOffset = scrollView.contentOffset.y
//                let yPos = (scrollOffset*(scrollOffset / (scrollView.bounds.size.height))/2 );
////                 scrollView.frame(0, yPos, scrollView.frame.size.width, scrollView.frame.size.height);
//                self.scrollView = UIScrollView(frame: CGRect(x:0, y:yPos, width:scrollView.frame.width,height: scrollView.frame.size.height))
//                sscroll.addSubview(self.scrollView)
//
//            }
//             let tempHieght1 = fabs(scrollView.contentOffset.y);
//            if(scrollView.contentOffset.y<1){
//                let yPos = scrollView.contentOffset.y;
////                imgBanner.frame = CGRectMake(0-(tempHieght1/2), yPos, viewBanner.frame.size.width+tempHieght1, viewBanner.frame.size.height+tempHieght1);
//
//                self.scrollView = UIScrollView(frame: CGRect(x:0-(tempHieght1/2), y:yPos, width:scrollView.frame.width+tempHieght1,height: scrollView.frame.size.height+tempHieght1))
//                sscroll.addSubview(self.scrollView)
//            }
            
        }
    }
    func ShowAlertMessage(title : String, message: String, buttonText : String)  {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        UIView.animate(withDuration: 1, animations: { () -> Void in
            self.scrollBottom.constant = keyboardFrame.size.height
            print("Keyboar will appear\(keyboardFrame.size.height)")
            //self.scroll.constraints = keyboardFrame.size.height + 20
        })
    }
    
    func keyboardWillHide(notification: NSNotification) {
        //        print("keyboarhide")
        self.scrollBottom.constant = 0
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print("received scrollViewWillBeginDecelerating")
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        // Test the offset and calculate the current page after scrolling ends
        
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        print(currentPage,scrollView.tag)
        
        var frame: CGRect = self.scrollPrive.frame
        frame.origin.x = frame.size.width * CGFloat(currentPage);
        //        frame.origin.y = 0;
        self.scrollPrive.scrollRectToVisible(frame, animated: true)
        
        var page = Int(currentPage)
        self.currentPreviewPage = page
        print("Current page number: ", currentPreviewPage)
        
        page = page+1
        var count = String(page).appending("/")
        count = count.appending(String(arrayString.count))
        lblCount.text = count
        print(currentPage+1)
    }
}

extension SLPDetailProperty : UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }// called when 'return' key pressed. return NO to ignore.
}

