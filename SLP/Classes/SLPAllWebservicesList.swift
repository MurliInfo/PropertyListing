//
//  SLPAllWebservicesList.swift
//  SLP
//
//  Created by Hardik Davda on 6/6/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit
let appDelegate = UIApplication.shared.delegate as! AppDelegate

class SLPAllWebservicesList: NSObject {
    
    var WEBPATH = appDelegate.WEBPATH as NSString     //Live Server
    var Web_UserLogin: NSString
    var Web_UserSignup: NSString
    var Web_PropertyList: NSString
    var Web_PropertyDetail: NSString
    var Web_PropertyTypeList: NSString
    var Web_SuburbList: NSString
    var Web_FavoritUnfavorit: NSString
    var Web_FilterListSaved: NSString
    var Web_RemoveFilter: NSString
    var Web_SaveFilter: NSString
    var Web_SendEnquiry: NSString
    var Web_ProfileView: NSString
    var Web_EditProfile: NSString


    init(fromString string: NSString) {
        print("URl\(WEBPATH)")
        print(appDelegate.WEBPATH)
        self.Web_PropertyList = (WEBPATH as String) + "getPropertyList" as NSString
        self.Web_PropertyDetail = (WEBPATH as String) + "getPropertyDetails" as NSString
        self.Web_PropertyTypeList = (WEBPATH as String) + "getPropertyTypeList" as NSString
        self.Web_SuburbList = (WEBPATH as String) + "getSuburbList" as NSString
        self.Web_UserLogin = (WEBPATH as String) + "login" as NSString
        self.Web_UserSignup = (WEBPATH as String) + "registration" as NSString
        self.Web_FavoritUnfavorit = (WEBPATH as String) + "favorite-unfavourite" as NSString
        self.Web_FilterListSaved = (WEBPATH as String) + "filter-list" as NSString
        self.Web_SaveFilter = (WEBPATH as String) + "filter-save" as NSString
        self.Web_SendEnquiry = (WEBPATH as String) + "sendEnquiry" as NSString
        self.Web_RemoveFilter = (WEBPATH as String) + "filter-remove" as NSString
        self.Web_ProfileView = (WEBPATH as String) + "consultant-profile" as NSString
        self.Web_EditProfile = (WEBPATH as String) + "profile-update" as NSString
    }
}


extension String{
    mutating func removeTag () -> String {
     self = self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        return self
    }
    mutating func removeSpace () -> String {
        self = self.replacingOccurrences(of: " ", with: "", options: String.CompareOptions.regularExpression, range: nil)
        return self
    }
}

extension UIColor{
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    //var lineColor : UIColor {return GlobalMethods().hexStringToUIColor(hex: "F7F7F7")}
    func lineColor() -> UIColor {
        return self.hexStringToUIColor(hex: "F7F7F7")
    }
    
    func orangColor() -> UIColor {
        return self.hexStringToUIColor(hex: "F37C2D")
    }
    func grayColor() -> UIColor {
        return self.hexStringToUIColor(hex: "737373")  // Email and phone same as placeholder
    }
    
    func placeholder() -> UIColor {
        return self.hexStringToUIColor(hex: "C7C7CD")
    }
    
    func textFieldBackgroundColor() -> UIColor {
        return self.hexStringToUIColor(hex: "EFEFEF")
    }
    
    func selectTintColor() -> UIColor {
        return self.hexStringToUIColor(hex: "666666")
    }
    
    func tintColor() -> UIColor {
        return self.hexStringToUIColor(hex: "3F51B5")
    }
    
   
    
    func dateColor() -> UIColor {
        return self.hexStringToUIColor(hex: "737373")
    }
    
    func selectCellColor() -> UIColor {
        return self.hexStringToUIColor(hex: "E0E0E0")
    }
    func yelloColor() -> UIColor {
        return self.hexStringToUIColor(hex: "FFA000")
    }
    // AAF000
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
}
