//
//  SLPViewProfile.swift
//  SLP
//
//  Created by Hardik Davda on 6/14/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit
import Foundation
import MessageUI

class SLPViewProfile: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet var scroll : UIScrollView!
    @IBOutlet var scrollBottom: NSLayoutConstraint!
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var btnReadMore : UIButton!
    @IBOutlet var viewProfile : UIView!
    
    @IBOutlet var viewEmailMe : UIView!
    @IBOutlet var viewContactDetail : UIView!
    @IBOutlet var viewContactDetailPhone : UIView!
    @IBOutlet var viewContactDetailWebsite : UIView!
    
    @IBOutlet var viewPersonalInfo: UIView!
    @IBOutlet var viewReadmore : UIView!
    
    @IBOutlet var viewContactAgent : UIView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblDesignation: UILabel!
    @IBOutlet var lblPhone: UILabel!
    @IBOutlet var lblWebsite: UILabel!
    @IBOutlet var lblLine1: UILabel!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtPhone: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtMessage: UITextView!

    var CunsultantDetailList = [CounsultantProfile]()
    var getCounsultantId = String()
    let font = UIFont.systemFont(ofSize: 13)
    var hight : CGFloat = 0.0
    var Y = CGFloat()
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(keyboardWillShow(notification:)),
                           name: .UIKeyboardWillShow,
                           object: nil)
        
        center.addObserver(self,
                           selector: #selector(keyboardWillHide(notification:) ),
                           name: .UIKeyboardWillHide,
                           object: nil)

        Y = 0.0
      
        self.getProfile()
        
//        lblLine1.layer.borderColor = UIColor.lightGray.cgColor
//        lblLine1.layer.borderWidth = 5
//        lblLine1.clipsToBounds = true
//        lblLine1.layer.shadowColor = UIColor.white.cgColor
//        lblLine1.layer.shadowOpacity = 0.6
        
//        scroll.contentSize = CGSize(width:self.view.frame.width, height:viewContactDetailWebsite.frame.height+viewContactDetailWebsite.frame.origin.y+10)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //    print(appDelegate.SHORTINGVALUE)
        
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor().orangColor()
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor().orangColor()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor().hexStringToUIColor(hex: "F37C2D")
    }
    
    // MARK: - IBAction Methods (Button click)
    
    @IBAction func cancel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
//        let mobile = ("telprompt://0402930908")
//        guard let number = URL(string: mobile) else { return }
//        if #available(iOS 10.0, *) {
//            UIApplication.shared.open(number, options: [:], completionHandler: nil)
//        }

    }
    
    @IBAction func currentListing(_ sender: UIButton) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPPropertyListing") as! SLPPropertyListing
        secondViewController.getTitle = "Current Listing"
        secondViewController.getCounsultantId = CunsultantDetailList[0].strId
        secondViewController.isSold = "NO"
        self.present(secondViewController, animated: true, completion: nil)
    }
    
    @IBAction func recentSales(_ sender: UIButton) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPPropertyListing") as! SLPPropertyListing
        secondViewController.getTitle = "Current Listing"
        secondViewController.getCounsultantId = CunsultantDetailList[0].strId
        secondViewController.isSold = "YES"
        self.present(secondViewController, animated: true, completion: nil)
    }
    
    @IBAction func faceBook(_ sender: UIButton) {
        if CunsultantDetailList[0].strFacebookProfileUrl != ""{
            
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPWebdata") as! SLPWebdata
        secondViewController.strUrl = "https://www.google.co.in"
        secondViewController.strTitle = "Facebook"
            self.present(secondViewController, animated: true, completion: nil)
        }else{
            self.ShowAlertMessage(title: "", message: "Data not available.", buttonText: "OK")
        }
    }
 
    @IBAction func twitter(_ sender: Any) {
        if CunsultantDetailList[0].strTwitterProfileUrl != ""{
            
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPWebdata") as! SLPWebdata
            secondViewController.strUrl = CunsultantDetailList[0].strTwitterProfileUrl
            secondViewController.strTitle = "Twitter"
            self.present(secondViewController, animated: true, completion: nil)
        }else{
            self.ShowAlertMessage(title: "", message: "Data not available.", buttonText: "OK")
        }
    }

    @IBAction func linkLn(_ sender: UIButton) {
        if CunsultantDetailList[0].strLinkedinProfileUrl != ""{
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPWebdata") as! SLPWebdata
            secondViewController.strUrl = CunsultantDetailList[0].strLinkedinProfileUrl
            secondViewController.strTitle = "Linkln"
            self.present(secondViewController, animated: true, completion: nil)
        }else{
            self.ShowAlertMessage(title: "", message: "Data not available.", buttonText: "OK")
        }
    }
    
    @IBAction func site(_ sender: UIButton) {
        if CunsultantDetailList[0].strWebsite != ""{
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPWebdata") as! SLPWebdata
            secondViewController.strUrl = CunsultantDetailList[0].strWebsite
            secondViewController.strTitle = "Website"
            self.present(secondViewController, animated: true, completion: nil)
        }else{
            self.ShowAlertMessage(title: "", message: "Data not available.", buttonText: "OK")
        }
    }

    @IBAction func makeCall(_ sender: UIButton) {
        let str =  CunsultantDetailList[0].strPhone.replacingOccurrences(of: " ", with: "")
        let mobile = ("tel://").appending(str)
        if let url = URL(string: mobile) {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func EmailMe(_ sender: UIButton) {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        composeVC.setToRecipients([CunsultantDetailList[0].strEmail])
        composeVC.setSubject("")
        composeVC.setMessageBody("", isHTML: false)
        self.present(composeVC, animated: true, completion: nil)
    
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
                        let paramter = "name=".appending(txtName.text!).appending("&from_email=").appending(txtEmail.text!).appending("&to_email=").appending(CunsultantDetailList[0].strEmail).appending("&phone=").appending(txtPhone.text!).appending("&message=").appending(txtMessage.text!)
                        
                        SLPAllWebservices().sendEnquiryDetail(with: paramter, API: "", completion: {(message,status)in
                            self.ShowAlertMessage(title: "", message: message, buttonText: "OK")
                        })
                        
        }

    }
    
    @IBAction func readMore(_ sender: UIButton) {
        let btn = sender
        if btn.tag == 1{
            Y = viewPersonalInfo.frame.origin.y+hight
            viewReadmore.frame = (CGRect(x: 0, y: CGFloat(Y), width: self.view.frame.width, height: 46))
            self.scroll.addSubview(viewReadmore)
            Y = Y + viewReadmore.frame.height
            btn.tag = 2
        }else{
            Y = viewPersonalInfo.frame.origin.y + 130
            viewReadmore.frame = (CGRect(x: 0, y: CGFloat(Y), width: self.view.frame.width, height: 86))
            self.scroll.addSubview(viewReadmore)
            Y = Y + viewReadmore.frame.height
            btn.tag = 1
        }
        self.setForm()
//        scroll.contentSize = CGSize(width:self.view.frame.width, height:Y)
    }
    // MARK: - User define
    func getProfile(){
        self.showProgressHUD()  
        let parameter = "id=".appending(getCounsultantId)
        print("Counsultant Id\(getCounsultantId)")
        SLPAllWebservices().CunsultantView(with: parameter, API: "", completion: {(listData,message,stutas)in
            if (status){
                print(listData)
                self.CunsultantDetailList = listData
//                let profileURL =  URL(string:  self.CunsultantDetailList[0].strPhoto)//"http://test2.rettest.com/slp_website/storage/app/uploads/public/590/c46/d00/590c46d00a963019050104.jpg"
//                self.imgProfile.sd_setImage(with: profileURL, placeholderImage: #imageLiteral(resourceName: "Avtar"))
                if let url = NSURL(string: self.CunsultantDetailList[0].strPhoto as String) {
                    do {
                        let weatherData = try NSData(contentsOf: url as URL, options: NSData.ReadingOptions())
                        print(weatherData)
                        self.imgProfile.layer.masksToBounds = true
                        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.size.height/2
                        self.imgProfile.image = UIImage(data: weatherData as Data)
                        self.imgProfile.layer.cornerRadius = self.imgProfile.frame.size.height/2
                    } catch {
                        print(error)
                    }
                    self.imgProfile.layer.masksToBounds = true
                    self.imgProfile.layer.cornerRadius = self.imgProfile.frame.size.height/2
//                    if let data = NSData(contentsOfURL:url as URL) {
//                        self.imgProfile.image = UIImage(data: data)
//                    }        
                }
                self.lblName.text = self.CunsultantDetailList[0].strName
                self.lblDesignation.text = self.CunsultantDetailList[0].strPosition
                self.lblPhone.text = self.CunsultantDetailList[0].strPhone
                self.lblWebsite.text = self.CunsultantDetailList[0].strWebsite
                self.setFrame()
                self.hideProgressHUD()
            }else{
                self.hideProgressHUD()
            }
        })
    }
    func setFrame(){
        Y = 0.0
        viewProfile.frame = (CGRect(x: 0, y: Y, width: self.view.frame.width, height: 404))
        self.scroll.addSubview(viewProfile)
        Y = Y+viewProfile.frame.height
        viewEmailMe.layer.cornerRadius = 25.0
        if lblPhone.text != "" || lblWebsite.text != ""{
            viewContactDetail.frame = (CGRect(x: 0, y: Y, width: self.view.frame.width, height: 44))
            self.scroll.addSubview(viewContactDetail)
            Y = Y+viewContactDetail.frame.height
            if lblPhone.text != ""{
                viewContactDetailPhone.frame = (CGRect(x: 0, y: Y, width: self.view.frame.width, height: 64))
                self.scroll.addSubview(viewContactDetailPhone)
                Y = Y+viewContactDetailPhone.frame.height
            }
            if lblWebsite.text != ""{
                viewContactDetailWebsite.frame = (CGRect(x: 0, y: Y, width: self.view.frame.width, height: 64))
                self.scroll.addSubview(viewContactDetailWebsite)
                Y = Y+viewContactDetailWebsite.frame.height
            }
        }
        hight = GlobalMethods().heightForView(text: lblDescription.text!, font: font, width: self.view.frame.size.width-32)+64
        viewPersonalInfo.frame = (CGRect(x: 0, y: CGFloat(Y), width: self.view.frame.width, height: hight))
        self.scroll.addSubview(viewPersonalInfo)
        Y = Y + 130
        print(Y)
        if (hight > 130){
            viewReadmore.frame = (CGRect(x: 0, y: CGFloat(Y), width: self.view.frame.width, height: 86))
            self.scroll.addSubview(viewReadmore)
            Y = Y + viewReadmore.frame.height
        }else{
             Y = Y + hight
        }
        self.setForm()
    }
    
    func setForm()  {
        viewContactAgent.frame = (CGRect(x: 0, y: CGFloat(Y), width: self.view.frame.width, height: 382))
        self.scroll.addSubview(viewContactAgent)
        Y = Y + viewContactAgent.frame.height
        scroll.contentSize = CGSize(width:self.view.frame.width, height:Y)
        self.addDoneButton()
    }
    
    func addDoneButton() {
                //        let keyboardToolbar = UIToolbar()
                keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
                                            target: view, action: #selector(UIView.endEditing(_:)))
        
                keyboardToolbar.items = [flexBarButton,doneBarButton]
                txtEmail.inputAccessoryView = keyboardToolbar
                txtName.inputAccessoryView = keyboardToolbar
                txtPhone.inputAccessoryView = keyboardToolbar
                txtMessage.inputAccessoryView = keyboardToolbar
    }

    func ShowAlertMessage(title : String, message: String, buttonText : String)  {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Keyboard Method
    
    func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.scrollBottom.constant = keyboardFrame.size.height
            print("Keyboar will appear\(keyboardFrame.size.height)")
            //self.scroll.constraints = keyboardFrame.size.height + 20
        })
    }
    
    func keyboardWillHide(notification: NSNotification) {
        //        print("keyboarhide")
        self.scrollBottom.constant = 0
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension SLPViewProfile : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
