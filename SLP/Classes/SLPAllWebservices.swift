//
//  SLPAllWebservices.swift
//  SLP
//
//  Created by Hardik Davda on 6/1/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit
let WebPath = SLPAllWebservicesList(fromString: "")
var UserDetail = [AdvanceSearchDataList]()
var PropertyList = [PropertyType]()
var CunsultantDetailList = [CounsultantProfile]()
var SearchScreenList = [SearchDataList]()
var SearchDetailList = [SearchDetailsDataList]()
var userLoginList = [userLoginDetailList]()
var filterList = [filterSavedList]()
var suburbList = [SuburbListData]()
var moreDataList = [MoreList]()
var recordCount = String()
var message = String()
var status = Bool()
let keyboardToolbar = UIToolbar()
var defaults = UserDefaults.standard


class SLPAllWebservices: NSObject {
    func userLogin(with parameters: String, API: String, completion:((([userLoginDetailList]),String,Bool)->())?) {
        
        userLoginList = [userLoginDetailList]()
        let url = NSURL(string: SLPAllWebservicesList(fromString: "").Web_UserLogin as String)
        var request = URLRequest(url: url! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var Parameter : NSString = NSString()
        Parameter = parameters as NSString
        request.httpBody = Parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    status = parsedData["status"] as! Bool
                    message = parsedData["message"] as! String
                    if(!status){
                    }else{
                        let field = parsedData["data"] as! [[String:Any]]
                        print(field.count)
                        var cmd = userLoginDetailList()
                        for blog in field {
                            cmd.strId = (blog["id"] as! NSString) as String!
                            cmd.strName = (blog["name"] as! NSString) as String!
                            cmd.strEmail = (blog["email"] as! NSString) as String!
                            cmd.strPhone = (blog["phone"] as! NSString) as String!
                            cmd.strProfilePicture = (blog["profile_picture"] as! NSString) as String!
                            cmd.strServiceToken = (blog["service_token"] as! NSString) as String!
                            
                            appDelegate.USERID = (blog["id"] as! NSString)
                            appDelegate.USERNAME = (blog["name"] as! NSString)
                            appDelegate.USEREMAIL = (blog["email"] as! NSString)
                            appDelegate.USERPHONE = (blog["phone"] as! NSString)
                            appDelegate.USERPROFILE = (blog["profile_picture"] as! NSString)
                            appDelegate.USERTOKEN = (blog["service_token"] as! NSString)
                            
                            defaults.set(status, forKey: "STATUS")
                            defaults.set(appDelegate.USERID, forKey: "USERID")
                            defaults.set(appDelegate.USERNAME, forKey: "USERNAME")
                            defaults.set(appDelegate.USEREMAIL, forKey: "USEREMAIL")
                            defaults.set(appDelegate.USERPHONE, forKey: "USERPHONE")
                            defaults.set(appDelegate.USERPROFILE, forKey: "USERPROFILE")
                            defaults.set(appDelegate.USERTOKEN, forKey: "TOKEN")

//                            if defaults.bool(forKey: "STATUS") as Bool{
//                                USERID = defaults.string(forKey: "USERID")! as NSString
//                                USERNAME = defaults.string(forKey: "USERNAME")! as NSString
//                                USEREMAIL = defaults.string(forKey: "USEREMAIL")! as NSString
//                                USERPHONE = defaults.string(forKey: "USERPHONE")! as NSString
//                                USERPROFILE = defaults.string(forKey: "USERPROFILE")! as NSString
//                                USERTOKEN = defaults.string(forKey: "TOKEN")! as NSString
//                            }
                            
                            userLoginList.append(cmd)
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                completion?(userLoginList,message,status)
            }
        }
        task.resume()
    }
    
    func signUpUser(with parameters: String, API: String, completion:((String,Bool)->())?) {

        let url = NSURL(string: SLPAllWebservicesList(fromString: "").Web_UserSignup as String)
        var request = URLRequest(url: url! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var Parameter : NSString = NSString()
        Parameter = parameters as NSString
        request.httpBody = Parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
//                    let status = parsedData["status"] as! Bool
                    status = parsedData["status"] as! Bool
                    message = parsedData["message"] as! String
                }
            }
            DispatchQueue.main.async {
                completion?(message,status)
            }
        }
        task.resume()
    }
    
    func SearchDashboardList(with parameters: String, API: String, completion:((([SearchDataList]),String,String)->())?) {
        SearchScreenList = [SearchDataList]()
        
        let url = NSURL(string: SLPAllWebservicesList(fromString: "").Web_PropertyList as String)
        var request = URLRequest(url: url! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var Parameter : NSString = NSString()
        Parameter = parameters as NSString
        request.httpBody = Parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
               if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
//                    print(parsedData)
                    let status = parsedData["status"] as! Bool
//                recordCount = "Showing 15 of 26 resultes"
                    recordCount = parsedData["total_records"] as! String
                message = parsedData["message"] as! String
                    if(!status){
                    }
                    else{
                        let field = parsedData["data"] as! [[String:Any]]
//                        print(field.count)
                        var cmd = SearchDataList()
                        for blog in field{
                            print(blog)
                            cmd.strId = (blog["id"] as! NSString) as String!
                            cmd.strHeading = (blog["heading"] as! NSString) as String!
                            cmd.strLot = (blog["lot"] as! NSString) as String!
                            cmd.strUnit  = (blog["unit"] as! NSString) as String!
                            cmd.strSuburb  = (blog["suburb"] as! NSString) as String!
                            cmd.strStreetNo = (blog["street_number"] as! NSString) as String!
                            cmd.strPoBox = (blog["po_box"] as! NSString) as String!
                            cmd.strStreet = (blog["street"] as! NSString) as String!
                            cmd.strPropertyPriceFrom = (blog["property_price_from"] as! NSString) as String!
                            cmd.strPropertyPriceTo = (blog["property_price_to"] as! NSString) as String!
                            cmd.strBedrooms = (blog["bedrooms"] as! NSString) as String!
                            cmd.strBathrooms = (blog["baathrooms"] as! NSString) as String!
                            cmd.strGarage = (blog["garage"] as! NSString) as String!
                            cmd.arrayPropertyImages = (blog["property_images"] as! Array)
                            cmd.strStatus  = (blog["status"] as! NSString) as String!
                            cmd.strWebsiteBroachurDisplayPrice = (blog["website_brochure_display_price"] as! NSString) as String!
                            cmd.strConsultantOneId = (blog["consultant_one_id"] as! NSString) as String!
                            cmd.strConsultantOneName = (blog["consultant_one_name"] as! NSString) as String!
                            cmd.strConsultantOnePosition = (blog["consultant_one_position"] as! NSString) as String!
                            cmd.strConsultantOneImage = (blog["consultant_one_image"] as! NSString) as String!
                            cmd.strConsultantTwoId = (blog["consultant_two_id"] as! NSString) as String!
                            cmd.strConsultantTwoName = (blog["consultant_two_name"] as! NSString) as String!
                            cmd.strConsultantTwoPosition = (blog["consultant_two_position"] as! NSString) as String!
                            cmd.strConsultantTwoImage = (blog["consultant_two_image"] as! NSString) as String!
                            cmd.isSave =  true
                            cmd.strIsFavourite = (blog["is_favourite"] as! NSString) as String!
                            cmd.IsNew = (blog["is_new"] as! NSString) as String!
//                            print("Fevortys := \(cmd.isSave )")
                            SearchScreenList.append(cmd)
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                completion?(SearchScreenList, recordCount,message)
            }
        }
        task.resume()
    }
    
    func FavoritProperty(with parameters: String, API: String, completion:((String,Bool)->())?) {
        
        let url = NSURL(string: SLPAllWebservicesList(fromString: "").Web_FavoritUnfavorit as String)
        var request = URLRequest(url: url! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var Parameter : NSString = NSString()
        Parameter = parameters as NSString
        request.httpBody = Parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    //                    let status = parsedData["status"] as! Bool
                    status = parsedData["status"] as! Bool
                    message = parsedData["message"] as! String
                }
            }
            DispatchQueue.main.async {
                completion?(message,status)
            }
        }
        task.resume()
    }
    
    func SaveSearch(with parameters: String, API: String, completion:((String,Bool)->())?) {
        
        let url = NSURL(string: SLPAllWebservicesList(fromString: "").Web_FavoritUnfavorit as String)
        var request = URLRequest(url: url! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var Parameter : NSString = NSString()
        Parameter = parameters as NSString
        request.httpBody = Parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    //                    let status = parsedData["status"] as! Bool
                    status = parsedData["status"] as! Bool
                    message = parsedData["message"] as! String
                }
            }
            DispatchQueue.main.async {
                completion?(message,status)
            }
        }
        task.resume()
    }
    

    

    func sendEnquiryDetail(with parameters: String, API: String, completion:((String,Bool)->())?) {
        
        let url = NSURL(string: SLPAllWebservicesList(fromString: "").Web_SendEnquiry as String)
        var request = URLRequest(url: url! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var Parameter : NSString = NSString()
        Parameter = parameters as NSString
        request.httpBody = Parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    //                    let status = parsedData["status"] as! Bool
                    status = parsedData["status"] as! Bool
                    message = parsedData["message"] as! String
                }
            }
            DispatchQueue.main.async {
                completion?(message,status)
            }
        }
        task.resume()
    }
    func removeFilterSaved(with parameters: String, API: String, completion:((String,Bool)->())?) {
        
        let url = NSURL(string: SLPAllWebservicesList(fromString: "").Web_RemoveFilter as String)
        var request = URLRequest(url: url! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var Parameter : NSString = NSString()
        Parameter = parameters as NSString
        request.httpBody = Parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    //                    let status = parsedData["status"] as! Bool
                    status = parsedData["status"] as! Bool
                    message = parsedData["message"] as! String
                }
            }
            DispatchQueue.main.async {
                completion?(message,status)
            }
        }
        task.resume()
    }
    

    
    func SearchDashboardDetailList(with parameters: String, API: String, completion:((([SearchDetailsDataList]),String,String,Bool)->())?) {
        
        SearchDetailList = [SearchDetailsDataList]()
        
        let url = NSURL(string: SLPAllWebservicesList(fromString: "").Web_PropertyDetail as String)
        var request = URLRequest(url: url! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var Parameter : NSString = NSString()
        Parameter = parameters as NSString
        request.httpBody = Parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    status = parsedData["status"] as! Bool
                    recordCount = ""
                    message = parsedData["message"] as! String
                    if(!status){
                    }
                    else{
                        let field = parsedData["data"] as! [[String:Any]]
                        for blog in field {
                            var SearchHome = [SearchDetailHomeOpens]()
                            let homeData = blog["home_open_data"] as! [[String:Any]]
                            if homeData.count == 0{
                            }else{
                                for data in homeData {
                                    var home = SearchDetailHomeOpens()
                                    home.strdate = data["date"] as! String
                                    home.strend_time = data["start_time"] as! String
                                    home.strstart_time = data["end_time"] as! String
                                    SearchHome.append(home)
                                }
                            }
                            let cmd = SearchDetailsDataList(strId: blog["id"] as! String,
                                                            strStreetNumber: blog["street_number"] as! String,
                                                            strStreet: blog["street"] as! String,
                                                            strState: blog["state"] as! String,
                                                            strSuburb: blog["suburb"] as! String,
                                                            strWebsiteBrochureDisplayPrice: blog["website_brochure_display_price"] as! String,
                                                            strBedrooms: blog["bedrooms"] as! String,
                                                            strBathrooms: blog["baathrooms"] as! String,
                                                            strGarage: blog["garage"] as! String,
                                                            arrayPropertyImages: (blog["property_images"] as! Array),
                                                            strFloorImage: blog["floor_image"] as! String,
                                                            strHeading: blog["heading"] as! String,
                                                            strDescription: blog["description"] as! String,
                                                            strPropertyType: blog["property_type"] as! String,
                                                            strLandAreaSqm: blog["land_area_sqm"] as! String,
                                                            strBuildingAreaSqm: blog["building_area_sqm"] as! String,
                                                            strParkingOther: blog["parking_other"] as! String,
                                                            strPool: blog["pool"] as! String,
                                                            strStudy: blog["study"] as! String,
                                                            strExternalLink: blog["external_link"] as! String,
                                                            strVideoLink: blog["video_link"] as! String,
                                                            strLatitude: blog["latitude"] as! String,
                                                            strLongitude: blog["longitude"] as! String,
                                                            strConsultantOneId: blog["consultant_one_id"] as! String,
                                                            strConsultantOneName: blog["consultant_one_name"] as! String,
                                                            strConsultantOnePosition: blog["consultant_one_position"] as! String,
                                                            strConsultantOneImage: blog["consultant_one_image"] as! String,
                                                            strConsultantOneMobile: blog["consultant_one_mobile"] as! String,
                                                            strConsultantOneEmail: blog["consultant_one_email"] as! String,
                                                            strConsultantOneFbUrl: blog["consultant_one_fb_url"] as! String,
                                                            strConsultantOneLinkedinUrl: blog["consultant_one_linkedin_url"] as! String,
                                                            strConsultantOnePinterestUrl: blog["consultant_one_pinterest_url"] as! String,
                                                            strConsultantOneGplusUrl: blog["consultant_one_gplus_url"] as! String,
                                                            strConsultantOneTwitterUrl: blog["consultant_one_twitter_url"] as! String,
                                                            strConsultantTwoId: blog["consultant_two_id"] as! String,
                                                            strConsultantTwoName: blog["consultant_two_name"] as! String,
                                                            strConsultantTwoPosition: blog["consultant_two_position"] as! String,
                                                            strConsultantTwoImage: blog["consultant_two_image"] as! String,
                                                            strConsultantTwoMobile: blog["consultant_two_mobile"] as! String,
                                                            strConsultantTwoEmail: blog["consultant_two_email"] as! String,
                                                            strConsultantTwoFbUrl: blog["consultant_two_fb_url"] as! String,
                                                            strConsultantTwoLinkedinUrl: blog["consultant_two_linkedin_url"] as! String,
                                                            strConsultantTwoPinterestUrl: blog["consultant_two_pinterest_url"] as! String,
                                                            strConsultantTwoGplusUrl: blog["consultant_two_gplus_url"] as! String,
                                                            strConsultantTwoTwitterUrl : blog["consultant_two_twitter_url"] as! String,
                                                            structHomeOpenData: SearchHome)
                            SearchDetailList.append(cmd)
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                completion?(SearchDetailList, recordCount,message,status)
            }
        }
        task.resume()
    }

    func filterDetailList(with parameters: String, API: String, completion:((([filterSavedList]),String,Bool)->())?) {
        filterList = [filterSavedList]()
        let url = NSURL(string: SLPAllWebservicesList(fromString: "").Web_FilterListSaved as String)
        var request = URLRequest(url: url! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var Parameter : NSString = NSString()
        Parameter = parameters as NSString
        request.httpBody = Parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    status = parsedData["status"] as! Bool
                    recordCount = ""
                    message = parsedData["message"] as! String
                    if(!status){
                    }
                    else{
                        let field = parsedData["data"] as! [[String:Any]]
                        
                        
                        for blog in field {
                            var cmd = filterSavedList()
                            let fillData = blog["filter_search"] as! [[String:Any]]
                            for search in fillData {
                                let SelectedValue = AdvanceSearch(location: search["strLocation"] as? String,
                                         priceMin: search["strPriceMin"] as? String,
                                         priceMax: search["strPriceMax"] as? String,
                                         PropertyType: search["strPropertyType"] as? String,
                                         InspectionSchedule: search["strInspectionSchedule"] as? String,
                                         BedroomsMin: search["strBedroomsMin"] as? String,
                                         BedroomsMax: search["strBedroomsMax"] as? String,
                                         BathroomMin: search["strBathroomsMin"] as? String,
                                         BathroomMax: search["strBathroomsMax"] as? String,
                                         LandMin: search["strLandSizeMin"] as? String,
                                         LandMax: search["strLandSizeMax"] as? String,
                                         Sort: search["strSort"] as? String,
                                         Suburbs: search["strSuburbs"] as? String,
                                         SuburbsId: search["strSuburbsId"] as? String,
                                         PropertyTypeId: search["strPropertyTypeId"] as? String,
                                         Garage: search["strGarage"] as? String,
                                         Keyword: search["strKeyword"] as? String,
                                         Surrounding: search["boolSurroundingSuburb"] as? Bool,
                                         Exclude: search["boolExcludeUnderOffer"] as? Bool)
                                    cmd.strObject = SelectedValue
                            }
                            cmd.strId = blog["id"] as!  String
                            cmd.strName = blog["name"] as!  String
                            print(blog["id"]! )
                            filterList.append(cmd)
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                completion?(filterList,message,status)
            }
        }
        task.resume()
    }

    
    func suburbDataFilterList(with parameters: String, API: String, completion:((([SuburbListData]),String,Bool)->())?) {
        
        suburbList = [SuburbListData]()
        let url = NSURL(string: SLPAllWebservicesList(fromString: "").Web_SuburbList as String)
        var request = URLRequest(url: url! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var Parameter : NSString = NSString()
        Parameter = parameters as NSString
        request.httpBody = Parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    status = parsedData["status"] as! Bool
                    message = parsedData["message"] as! String
                    if(!status){
                    }else{
                        let field = parsedData["data"] as! [[String:Any]]
                        print(field.count)
                        var cmd = SuburbListData()
                        for blog in field {
                            cmd.strId = (blog["id"] as! NSString) as String!
                            cmd.strSuburb = (blog["suburb"] as! NSString) as String!
                            cmd.strStatus = (blog["status"] as! NSString) as String!
                            cmd.strStateId = (blog["state"] as! NSString) as String!
                            cmd.strCreatedAt = (blog["created_at"] as! NSString) as String!
                            cmd.strUpdatedAt = (blog["updated_at"] as! NSString) as String!
                            cmd.strStateName = (blog["state_name"] as! NSString) as String!
                            suburbList.append(cmd)
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                completion?(suburbList,message,status)
            }
        }
        task.resume()
    }

    
    func editProfileDetail(with parameters: String, API: String, completion:((([userLoginDetailList]),String,Bool)->())?) {
        
        userLoginList = [userLoginDetailList]()
        let url = NSURL(string: SLPAllWebservicesList(fromString: "").Web_EditProfile as String)
        var request = URLRequest(url: url! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var Parameter : NSString = NSString()
        Parameter = parameters as NSString
        request.httpBody = Parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    status = parsedData["status"] as! Bool
                    message = parsedData["message"] as! String
                    if(!status){
                    }else{
                        let field = parsedData["data"] as! [[String:Any]]
                        print(field.count)
                        var cmd = userLoginDetailList()
                        for blog in field {
                            cmd.strId = (blog["id"] as! NSString) as String!
                            cmd.strName = (blog["name"] as! NSString) as String!
                            cmd.strEmail = (blog["email"] as! NSString) as String!
                            cmd.strPhone = (blog["phone"] as! NSString) as String!
                            cmd.strProfilePicture = (blog["profile_picture"] as! NSString) as String!
                            cmd.strServiceToken = (blog["service_token"] as! NSString) as String!
                            
                            appDelegate.USERID = (blog["id"] as! NSString)
                            appDelegate.USERNAME = (blog["name"] as! NSString)
                            appDelegate.USEREMAIL = (blog["email"] as! NSString)
                            appDelegate.USERPHONE = (blog["phone"] as! NSString)
                            appDelegate.USERPROFILE = (blog["profile_picture"] as! NSString)
                            appDelegate.USERTOKEN = (blog["service_token"] as! NSString)
                            
                            defaults.set(status, forKey: "STATUS")
                            defaults.set(appDelegate.USERID, forKey: "USERID")
                            defaults.set(appDelegate.USERNAME, forKey: "USERNAME")
                            defaults.set(appDelegate.USEREMAIL, forKey: "USEREMAIL")
                            defaults.set(appDelegate.USERPHONE, forKey: "USERPHONE")
                            defaults.set(appDelegate.USERPROFILE, forKey: "USERPROFILE")
                            defaults.set(appDelegate.USERTOKEN, forKey: "TOKEN")
                            
                            //                            if defaults.bool(forKey: "STATUS") as Bool{
                            //                                USERID = defaults.string(forKey: "USERID")! as NSString
                            //                                USERNAME = defaults.string(forKey: "USERNAME")! as NSString
                            //                                USEREMAIL = defaults.string(forKey: "USEREMAIL")! as NSString
                            //                                USERPHONE = defaults.string(forKey: "USERPHONE")! as NSString
                            //                                USERPROFILE = defaults.string(forKey: "USERPROFILE")! as NSString
                            //                                USERTOKEN = defaults.string(forKey: "TOKEN")! as NSString
                            //                            }
                            
                            userLoginList.append(cmd)
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                completion?(userLoginList,message,status)
            }
        }
        task.resume()
    }

    
    func sortListingByDataList(with parameters: String, API: String, completion:(([AdvanceSearchDataList])->())?) {
        UserDetail = [AdvanceSearchDataList]()
        var cmd = AdvanceSearchDataList(strTitle: "Newest", strData: "", isSelect: false)
        UserDetail.append(cmd)
        cmd = AdvanceSearchDataList(strTitle: "Lowest Price", strData: "", isSelect: false)
        UserDetail.append(cmd)
        cmd = AdvanceSearchDataList(strTitle: "Highest Price", strData: "", isSelect: false)
        UserDetail.append(cmd)
        cmd = AdvanceSearchDataList(strTitle: "Earliest Inspection", strData: "", isSelect: false)
        UserDetail.append(cmd)
        cmd = AdvanceSearchDataList(strTitle: "Suburb", strData: "", isSelect: false)
        UserDetail.append(cmd)
        
        DispatchQueue.main.async {
            completion?(UserDetail)
        }
    }
    
    func SearchListDate(with parameters: String, API: String, completion:(([AdvanceSearchDataList])->())?) {
        UserDetail = [AdvanceSearchDataList]()
        var cmd = AdvanceSearchDataList(strTitle: "Location", strData: "Map Area", isSelect: false)
        UserDetail.append(cmd)
        
        cmd = AdvanceSearchDataList(strTitle: "Surrounding Suburbs", strData: "Switch", isSelect: false)
        UserDetail.append(cmd)

        cmd = AdvanceSearchDataList(strTitle: "Price", strData: "Any", isSelect: false)
        UserDetail.append(cmd)

        cmd = AdvanceSearchDataList(strTitle: "Property Type", strData: "Any", isSelect: false)
        UserDetail.append(cmd)
        
        cmd = AdvanceSearchDataList(strTitle: "Inspections Scheduled", strData: "At any time", isSelect: false)
        UserDetail.append(cmd)
        
        cmd = AdvanceSearchDataList(strTitle: "Bedrooms", strData: "Any", isSelect: false)
        UserDetail.append(cmd)

        cmd = AdvanceSearchDataList(strTitle: "Bathrooms", strData: "Any", isSelect: false)
        UserDetail.append(cmd)
        
        cmd = AdvanceSearchDataList(strTitle: "Garage", strData: "Any", isSelect: false)
        UserDetail.append(cmd)
        
        cmd = AdvanceSearchDataList(strTitle: "Land size", strData: "Any", isSelect: false)
        UserDetail.append(cmd)
        
        cmd = AdvanceSearchDataList(strTitle: "Keywords", strData: "TextField", isSelect: false)
        UserDetail.append(cmd)
        
        cmd = AdvanceSearchDataList(strTitle: "Exclude Under Offer", strData: "Switch", isSelect: false)
        UserDetail.append(cmd)

        DispatchQueue.main.async {
            completion?(UserDetail)
        }
    }
    
    func SearchPropertyType(with parameters: String, API: String, completion:((([PropertyType]),String,Bool) ->())?) {
        PropertyList = [PropertyType]()
        
        
        let url = NSURL(string: SLPAllWebservicesList(fromString: "").Web_PropertyTypeList as String)
        var request = URLRequest(url: url! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var Parameter : NSString = NSString()
        Parameter = parameters as NSString
        request.httpBody = Parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    status = parsedData["status"] as! Bool
                    message = parsedData["message"] as! String
                    if(!status){
                    }else{
                        let field = parsedData["data"] as! [[String:Any]]
                        print(field.count)
                        var cmd = PropertyType()
                        for blog in field {
                            cmd.strId = (blog["id"] as! NSString) as String!
                            cmd.strPropertyType = (blog["property_type"] as! NSString) as String!
                            cmd.strStatus = (blog["status"] as! NSString) as String!
                            cmd.strCreatedAt = (blog["created_at"] as! NSString) as String!
                            cmd.strUpdatedAt = (blog["updated_at"] as! NSString) as String!
                            cmd.isSelect = false
                            PropertyList.append(cmd)
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                completion?(PropertyList,message,status)
            }
        }
        task.resume()
    

    
    
        
        
//        var cmd = AdvanceSearchDataList(strTitle: "Any", strData: "", isSelect: false)
//        UserDetail.append(cmd)
//        
//        cmd = AdvanceSearchDataList(strTitle: "House", strData: "", isSelect: false)
//        UserDetail.append(cmd)
//        
//        cmd = AdvanceSearchDataList(strTitle: "Apartment / Unit / Flat", strData: "", isSelect: false)
//        UserDetail.append(cmd)
//        cmd = AdvanceSearchDataList(strTitle: "Townhouse", strData: "", isSelect: false)
//        UserDetail.append(cmd)
//        cmd = AdvanceSearchDataList(strTitle: "Land", strData: "", isSelect: false)
//        UserDetail.append(cmd)
//        cmd = AdvanceSearchDataList(strTitle: "Rural", strData: "", isSelect: false)
//        UserDetail.append(cmd)
//        cmd = AdvanceSearchDataList(strTitle: "New Apartments / Off the plan", strData: "", isSelect: false)
//        UserDetail.append(cmd)
//        cmd = AdvanceSearchDataList(strTitle: "New Home Designs", strData: "", isSelect: false)
//        UserDetail.append(cmd)
//        cmd = AdvanceSearchDataList(strTitle: "New House and Land", strData: "", isSelect: false)
//        UserDetail.append(cmd)
//       
//        DispatchQueue.main.async {
//            completion?(UserDetail)
//        }
    }
    
    func InspectionScheduled(with parameters: String, API: String, completion:(([AdvanceSearchDataList])->())?) {
        UserDetail = [AdvanceSearchDataList]()
       
        var cmd = AdvanceSearchDataList(strTitle: "Any", strData: "", isSelect: false)
        UserDetail.append(cmd)
        
        cmd = AdvanceSearchDataList(strTitle: "Today", strData: "", isSelect: false)
        UserDetail.append(cmd)
        
        cmd = AdvanceSearchDataList(strTitle: "This Weekend", strData: "", isSelect: false)
        UserDetail.append(cmd)
        
        cmd = AdvanceSearchDataList(strTitle: "Next Weekend", strData: "", isSelect: false)
        UserDetail.append(cmd)
        cmd = AdvanceSearchDataList(strTitle: "Next 7 days", strData: "", isSelect: false)
        UserDetail.append(cmd)
        cmd = AdvanceSearchDataList(strTitle: "This Month", strData: "", isSelect: false)
        UserDetail.append(cmd)
        
        DispatchQueue.main.async {
            completion?(UserDetail)
        }
    }
    
    func moreListData(with parameters: String, API: String, completion:(([MoreList])->())?) {
        moreDataList = [MoreList]()
        
        var cmd = MoreList(strTitle: "Profile", imgIcones: #imageLiteral(resourceName: "iconeProfileAvtar"), isSelect: false)
        moreDataList.append(cmd)
//        
//        cmd = MoreList(strTitle: "Alerts", imgIcones: #imageLiteral(resourceName: "iconNotification"), isSelect: false)
//        moreDataList.append(cmd)
//        
        cmd = MoreList(strTitle: "Rat us", imgIcones: #imageLiteral(resourceName: "iconRating"), isSelect: false)
        moreDataList.append(cmd)
        
        cmd = MoreList(strTitle: "Feedback", imgIcones: #imageLiteral(resourceName: "iconComments"), isSelect: false)
        moreDataList.append(cmd)
        
        cmd = MoreList(strTitle: "Change Password", imgIcones: #imageLiteral(resourceName: "iconLockBlack"), isSelect: false)
        moreDataList.append(cmd)
        
        cmd = MoreList(strTitle: "Logout", imgIcones: #imageLiteral(resourceName: "iconLogout"), isSelect: false)
        moreDataList.append(cmd)
        
        
        DispatchQueue.main.async {
            completion?(moreDataList)
        }
    }
    
    
    func CunsultantView(with parameters: String, API: String, completion:((([CounsultantProfile]),String,Bool) ->())?) {
        CunsultantDetailList = [CounsultantProfile]()
        let url = NSURL(string: SLPAllWebservicesList(fromString: "").Web_ProfileView as String)
        var request = URLRequest(url: url! as URL)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var Parameter : NSString = NSString()
        Parameter = parameters as NSString
        request.httpBody = Parameter.data(using: String.Encoding.utf8.rawValue)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error!)                                 // some fundamental network error
                return
            }
            do {
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    status = parsedData["status"] as! Bool
                    message = parsedData["message"] as! String
                    if(!status){
                    }else{
                        let field = parsedData["data"] as! [[String:Any]]
                        print(field.count)
                        var cmd = CounsultantProfile()
                        for blog in field {
                            cmd.strId = (blog["id"] as! NSString) as String!
                            cmd.strName = (blog["name"] as! NSString) as String!
                            cmd.strPhoto = (blog["photo"] as! NSString) as String!
                            cmd.strDescription = (blog["description"] as! NSString) as String!
                            cmd.strPosition = (blog["position"] as! NSString) as String!
                            cmd.strPhone = (blog["phone"] as! NSString) as String!
                            cmd.strMobile = (blog["mobile"] as! NSString) as String!
                            cmd.strEmail = (blog["email"] as! NSString) as String!
                            cmd.strWebsite = (blog["website"] as! NSString) as String!
                            cmd.strProfileVideoUrl = (blog["profile_video_url"] as! NSString) as String!
                            cmd.strFacebookProfileUrl = (blog["facebook_profile_url"] as! NSString) as String!
                            cmd.strTwitterProfileUrl = (blog["twitter_profile_url"] as! NSString) as String!
                            cmd.strLinkedinProfileUrl = (blog["linkedin_profile_url"] as! NSString) as String!
                            cmd.strPinterestProfileUrl = (blog["pinterest_profile_url"] as! NSString) as String!
                            cmd.strGooglePlusProfileUrl = (blog["google_plus_profile_url"] as! NSString) as String!
                            cmd.strStateName = (blog["state_name"] as! NSString) as String!
                          CunsultantDetailList.append(cmd)
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                completion?(CunsultantDetailList,message,status)
            }
        }
        task.resume()
    }
}
extension String {
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
}

