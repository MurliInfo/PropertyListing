//
//  SLPWebdata.swift
//  SLP
//
//  Created by Hardik Davda on 6/27/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class SLPWebdata: UIViewController  ,UIWebViewDelegate{
    @IBOutlet var lblTitel: UILabel!
    @IBOutlet var webLoad: UIWebView!
    
    var strUrl : String = String()
    var strTitle : String = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitel.text = strTitle
        
        let url = NSURL (string: strUrl);
        let requestObj = NSURLRequest(url: url! as URL);
        print(requestObj)
        webLoad.loadRequest(requestObj as URLRequest);
    }

    @IBAction func back(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
