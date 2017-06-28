//
//  ViewController.swift
//  SLP
//
//  Created by Hardik Davda on 6/1/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var viewSignUp: UIView!
     @IBOutlet var viewSignIn: UIView!
    @IBOutlet var viewSignContent: UIView!
    @IBOutlet var viewContent: UIView!
    @IBOutlet var scroll: UIScrollView!
    @IBOutlet var scrollBottom: NSLayoutConstraint!
    @IBOutlet var signInTop: NSLayoutConstraint!
    @IBOutlet var signUpTop: NSLayoutConstraint!
    
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!

    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtPhone: UITextField!
    @IBOutlet var txtSEmail: UITextField!
    @IBOutlet var txtSPassword: UITextField!
    @IBOutlet var txtSConfirmPassword: UITextField!

    @IBOutlet var imgMail: UIImageView!
    @IBOutlet var imgLock: UIImageView!
    @IBOutlet var imgName: UIImageView!
    @IBOutlet var imgCall: UIImageView!
    @IBOutlet var imgSMail: UIImageView!
    var timer: Timer!
    override func viewDidLoad() {
        super.viewDidLoad()
        let color = UIColor.white
        txtEmail.attributedPlaceholder = NSAttributedString(string: txtEmail.placeholder!, attributes: [NSForegroundColorAttributeName : color])
        
        txtPassword.attributedPlaceholder = NSAttributedString(string: txtPassword.placeholder!, attributes: [NSForegroundColorAttributeName : color])
        
        txtName.attributedPlaceholder = NSAttributedString(string: txtName.placeholder!, attributes: [NSForegroundColorAttributeName : color])
        
        txtPhone.attributedPlaceholder = NSAttributedString(string: txtPhone.placeholder!, attributes: [NSForegroundColorAttributeName : color])
        
        txtSEmail.attributedPlaceholder = NSAttributedString(string: txtSEmail.placeholder!, attributes: [NSForegroundColorAttributeName : color])
        
        txtSPassword.attributedPlaceholder = NSAttributedString(string: txtSPassword.placeholder!, attributes: [NSForegroundColorAttributeName : color])
        
        txtSConfirmPassword.attributedPlaceholder = NSAttributedString(string: txtSConfirmPassword.placeholder!, attributes: [NSForegroundColorAttributeName : color])
        
        
        imgMail.tintColor = UIColor.white
        imgLock.tintColor = UIColor.white
        imgName.tintColor = UIColor.white
        imgCall.tintColor = UIColor.white
        imgSMail.tintColor = UIColor.white
        
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(keyboardWillShow(notification:)),
                           name: .UIKeyboardWillShow,
                           object: nil)
        
        center.addObserver(self,
                           selector: #selector(keyboardWillHide(notification:) ),
                           name: .UIKeyboardWillHide,
                           object: nil)
        
        viewContent.frame = (CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height+20))
        self.scroll.addSubview(viewContent)
        
        viewSignContent.frame = (CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height+20))
        self.viewSignIn.addSubview(viewSignContent)
        
        scroll.contentSize = CGSize(width:self.view.frame.width, height:self.view.frame.height+20)
        self.viewSignUp.isHidden = true
//        self.addDoneButton()
    }
    func hideKeypad(_ sender: UIButton)  {
        self.view.endEditing(true)
//iconNext
    }
    func nextField(_ sender: Any)  {
    
        switch inputToolbar.tag {
        case 1:
            txtEmail.resignFirstResponder()
            txtPassword.becomeFirstResponder()
            break
        case 2:
            txtPassword.resignFirstResponder()
            txtEmail.becomeFirstResponder()
            break
        case 3:
            txtName.resignFirstResponder()
            txtPhone.becomeFirstResponder()
            break
        case 4:
            txtPhone.resignFirstResponder()
            txtSEmail.becomeFirstResponder()
            break
        case 5:
            txtSEmail.resignFirstResponder()
            txtSPassword.becomeFirstResponder()
            break
        case 6:
            txtSPassword.resignFirstResponder()
            txtSConfirmPassword.becomeFirstResponder()
            break
        case 7:
            txtSConfirmPassword.resignFirstResponder()
            txtName.becomeFirstResponder()
            break
        default:
            break
        }
        print("Next\(inputToolbar.tag)")
  
    }
    func prious(_ sender: UIButton)  {
       
        switch inputToolbar.tag {
        case 1:
            txtEmail.resignFirstResponder()
            txtPassword.becomeFirstResponder()
            break
        case 2:
            txtPassword.resignFirstResponder()
            txtEmail.becomeFirstResponder()
            break
        case 3:
            txtName.resignFirstResponder()
            txtSConfirmPassword.becomeFirstResponder()
            break
        case 4:
            txtPhone.resignFirstResponder()
            txtName.becomeFirstResponder()
            break
        case 5:
            txtSEmail.resignFirstResponder()
            txtPhone.becomeFirstResponder()
            break
        case 6:
            txtSPassword.resignFirstResponder()
            txtSEmail.becomeFirstResponder()
            break
        case 7:
            txtSConfirmPassword.resignFirstResponder()
            txtSPassword.becomeFirstResponder()
            break
        default:
            break
        }
        print("Prious")
        //iconNext
    }
    
//    func addDoneButton() {
//        //        let keyboardToolbar = UIToolbar()
//        keyboardToolbar.sizeToFit()
//         let nextButton  = UIBarButtonItem(image: #imageLiteral(resourceName: "iconNext"), style: .plain, target: self, action: #selector(self.nextField))
//        
//        let previousButton  = UIBarButtonItem(image: #imageLiteral(resourceName: "iconBefore"), style: .plain, target: self, action: #selector(self.prious))
//        
//        
//        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
//                                            target: nil, action: nil)
//        
//        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done,
//                                            target: nil, action: #selector(self.hideKeypad))
//        
//        keyboardToolbar.items = [previousButton,nextButton,flexBarButton, doneBarButton]
//        txtEmail.inputAccessoryView = keyboardToolbar
//        txtPassword.inputAccessoryView = keyboardToolbar
//        txtName.inputAccessoryView = keyboardToolbar
//        txtPhone.inputAccessoryView = keyboardToolbar
//        txtSEmail.inputAccessoryView = keyboardToolbar
//        txtSPassword.inputAccessoryView = keyboardToolbar
//        txtSConfirmPassword.inputAccessoryView = keyboardToolbar
//    }
    
    @IBAction func signIn(_ sender: UIButton) {
        self.view.endEditing(true)
        txtEmail.text = txtEmail.text!.removeSpace()
        txtPassword.text = txtPassword.text!.removeSpace()
        if txtEmail.text!.isEmpty || !GlobalMethods().isValidEmail(testStr: txtEmail.text!){
            self.ShowAlertMessage(title: "", message: "Please enter valid email address.", buttonText: "OK")
        }else if txtPassword.text!.isEmpty{
            self.ShowAlertMessage(title: "", message: "Please enter password.", buttonText: "OK")
        }else{
            self.showProgressHUD()
            print("Done")
            var parameter = String()
            parameter = "email=".appending(txtEmail.text!).appending("&password=").appending(txtPassword.text!)
         SLPAllWebservices().userLogin(with: parameter as String, API: "", completion: {(ListData,message,status) in
            print("Login detail \(ListData)")
            if status{
               self.hideProgressHUD()
                
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBar
                self.present(secondViewController, animated: true, completion: nil)
//                self.navigationController?.pushViewController(secondViewController, animated: true)
                
        }else{
                self.ShowAlertMessage(title: "", message: message, buttonText: "OK")
            }
            self.hideProgressHUD()
         })
//
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBar
        self.navigationController?.pushViewController(secondViewController, animated: true)
        print("signIn")
        }
    }
  
    @IBAction func signUp(_ sender: UIButton) {
        self.view.endEditing(true)
        txtName.text = txtName.text!.removeSpace()
        txtPhone.text = txtPhone.text!.removeSpace()
        txtSEmail.text = txtSEmail.text!.removeSpace()
        txtSPassword.text = txtSPassword.text!.removeSpace()
        txtSConfirmPassword.text = txtSConfirmPassword.text!.removeSpace()
        if txtName.text!.isEmpty{
            self.ShowAlertMessage(title: "", message: "Please enter valid name.", buttonText: "OK")
        }else if txtSEmail.text!.isEmpty || !GlobalMethods().isValidEmail(testStr: txtSEmail.text!){
            self.ShowAlertMessage(title: "", message: "Please enter valid email address.", buttonText: "OK")
        }else if txtSPassword.text!.isEmpty{
            self.ShowAlertMessage(title: "", message: "Please enter confirm password.", buttonText: "OK")
        }else if txtSConfirmPassword.text!.isEmpty  || txtSConfirmPassword.text! != txtSPassword.text!{
            self.ShowAlertMessage(title: "", message: "Confirm password does not match with password.", buttonText: "OK")
        }else{
            self.showProgressHUD()
            var parameter = String()
            parameter = "name=".appending(txtName.text!).appending("&email=").appending(txtSEmail.text!).appending("&password=").appending(txtSPassword.text!)
            if !txtPhone.text!.isEmpty{
                parameter =  parameter.appending("&phone=").appending(txtPhone.text!)
            }
            SLPAllWebservices().signUpUser(with: parameter as String, API: "", completion: {(message,status) in
                if status{
                    self.ShowAlertMessage(title: "", message: message, buttonText: "OK")
                    self.hideProgressHUD()
                    self.SignInScreen(sender)
                }else{
                    self.ShowAlertMessage(title: "", message: message, buttonText: "OK")
                    self.hideProgressHUD()
                }
            })
        }
    }
    
    @IBAction func SignInScreen(_ sender: UIButton) {
        self.view.endEditing(true)

//        UIView.animate(withDuration: 1, animations: { () -> Void in
//            self.viewSignUp.isHidden = true
//        })
        self.view.layoutIfNeeded()
//        self.viewSignUp.isHidden = true
        self.viewSignIn.isHidden = false
//        signInTop.constant = -(self.view.frame.height+20)
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1, animations: { () -> Void in
            self.signUpTop.constant = self.view.frame.height+20
            self.signInTop.constant = -20
            self.view.layoutIfNeeded()
            
        })
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1, animations: { () -> Void in
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.hideSignUp), userInfo: nil, repeats: false)
            self.view.layoutIfNeeded()
       })
    }

    @IBAction func forgotPassword(_ sender: UIButton) {
        self.view.endEditing(true)
        print("forgotPassword")
    }
    
    @IBAction func signUpScreen(_ sender: UIButton) {
        self.view.endEditing(true)

        print("Signup")
        self.view.layoutIfNeeded()
        self.viewSignUp.isHidden = false
//         self.viewSignIn.isHidden = true
        
        signUpTop.constant = self.view.frame.height+20
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1, animations: { () -> Void in
            self.signUpTop.constant = -20
            self.signInTop.constant = -(self.view.frame.height+20)
            self.view.layoutIfNeeded()
        })
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1, animations: { () -> Void in
            
             self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.hideSignIn), userInfo: nil, repeats: false)
            self.view.layoutIfNeeded()
        })
    }
    func hideSignIn() {
        self.viewSignIn.isHidden = true
   }
    func hideSignUp() {
        self.viewSignUp.isHidden = true
    }
    // MARK: - Keyboard Hide Show

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
    
    func ShowAlertMessage(title : String, message: String, buttonText : String)  {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    lazy var inputToolbar: UIToolbar = {
        var toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        var doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.hideKeypad(_:)))
        var flexibleSpaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        var fixedSpaceButton = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        
        var nextButton = UIBarButtonItem(image: #imageLiteral(resourceName: "iconNext"), style: .plain, target: self, action: #selector(self.nextField(_:)))
        var previousButton = UIBarButtonItem(image: #imageLiteral(resourceName: "iconBefore"), style: .plain, target: self, action: #selector(self.prious(_:)))
        
        toolbar.setItems([fixedSpaceButton, previousButton, fixedSpaceButton, nextButton, flexibleSpaceButton, doneButton], animated: false)
        toolbar.isUserInteractionEnabled = true
        
        return toolbar
    }()
    
}

extension ViewController : UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        if textField == txtPassword{
            print("Login fiyer")
        }
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        inputToolbar.tag = textField.tag
        
        textField.inputAccessoryView = inputToolbar
        return true
    }
    
}
