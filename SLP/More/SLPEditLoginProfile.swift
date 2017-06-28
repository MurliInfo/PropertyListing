
//
//  SLPEditLoginProfile.swift
//  SLP
//
//  Created by Hardik Davda on 6/16/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class SLPEditLoginProfile: UIViewController {
    @IBOutlet var scroll : UIScrollView!
    @IBOutlet var scrollBottom: NSLayoutConstraint!
    @IBOutlet var viewAll : UIView!
    @IBOutlet var txtUserName : UITextField!
    @IBOutlet var txtNumber: UITextField!
    @IBOutlet var txtEmail : UITextField!
    @IBOutlet var viewRightView : UIView!
    @IBOutlet var imgRight : UIImageView!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        viewRightView.layer.masksToBounds = true
        viewRightView.layer.cornerRadius = viewRightView.frame.size.height/2
        imgRight.layer.masksToBounds = true
        imgRight.tintColor = .white

        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(keyboardWillShow(notification:)),
                           name: .UIKeyboardWillShow,
                           object: nil)
        
        center.addObserver(self,
                           selector: #selector(keyboardWillHide(notification:) ),
                           name: .UIKeyboardWillHide,
                           object: nil)

        viewAll.frame = (CGRect(x: 0, y: 0, width: self.view.frame.width, height: 400))
        self.scroll.addSubview(viewAll)
        scroll.contentSize = CGSize(width:self.view.frame.width, height:400)

        txtUserName.text = appDelegate.USERNAME as String
        txtEmail.text = appDelegate.USEREMAIL as String
        txtNumber.text = appDelegate.USERPHONE as String
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
        txtUserName.inputAccessoryView = keyboardToolbar
        txtEmail.inputAccessoryView = keyboardToolbar
        txtNumber.inputAccessoryView = keyboardToolbar
    }

    @IBAction func Save(_ sender: Any) {
        if txtUserName.text == ""{
            self.ShowAlertMessage(title: "", message: "Please enter user name.", buttonText: "OK")
       }else
        if txtEmail.text == "" || !GlobalMethods().isValidEmail(testStr: txtEmail.text!) {
            self.ShowAlertMessage(title: "", message: "Please enter proper email.", buttonText: "OK")
        }else{
            var parameter = "user_id=".appending(appDelegate.USERID as String).appending("&name=").appending(txtUserName.text!).appending("&email=").appending(txtEmail.text!)
            if txtNumber.text != ""{
                parameter = parameter.appending("&phone=").appending(txtNumber.text!)
            }
            
            SLPAllWebservices().editProfileDetail(with: parameter as String, API: "", completion: {(ListData,message,status) in
                print("Login detail \(ListData)")
                self.ShowAlertMessage(title: "", message: message, buttonText: "OK")
//                if status{
//                    self.hideProgressHUD()
//                    
//                }else{
//                    self.ShowAlertMessage(title: "", message: message, buttonText: "OK")
//                }
                self.hideProgressHUD()
            })

        }
    }
    
    // MARK: - Keyboard Method
    
    func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.scrollBottom.constant = keyboardFrame.size.height - 49
            print("Keyboar will appear\(keyboardFrame.size.height)")
            //self.scroll.constraints = keyboardFrame.size.height + 20
        })
    }
    
    func keyboardWillHide(notification: NSNotification) {
        //        print("keyboarhide")
        self.scrollBottom.constant = 0
    }
    
    func ShowAlertMessage(title : String, message: String, buttonText : String)  {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension SLPEditLoginProfile : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder()
        return true
    }
}
