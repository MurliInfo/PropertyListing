//
//  SLPLoginProfile.swift
//  SLP
//
//  Created by Hardik Davda on 6/16/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class SLPLoginProfile: UIViewController {
    @IBOutlet var viewRightView : UIView!
    @IBOutlet var imgRight : UIImageView!
    
    @IBOutlet var lblName : UILabel!
    @IBOutlet var lblEmail : UILabel!
    @IBOutlet var lblNumber : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewRightView.layer.masksToBounds = true
        viewRightView.layer.cornerRadius = viewRightView.frame.size.height/2
        imgRight.image = imgRight.image!.withRenderingMode(.alwaysTemplate)
        imgRight.layer.masksToBounds = true
        imgRight.tintColor = .white
        
        lblName.text = appDelegate.USERNAME as String
        lblEmail.text = appDelegate.USEREMAIL as String
        lblNumber.text = appDelegate.USERPHONE as String
        // Do any additional setup after loading the view.
    }

    @IBAction func editProfile(_ sender: UIButton) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "MORE", bundle:nil)
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SLPEditLoginProfile") as! SLPEditLoginProfile
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
}
