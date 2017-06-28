//
//  AppDelegate.swift
//  SLP
//
//  Created by Hardik Davda on 6/1/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var WEBPATH = NSString()
    var SHORTINGVALUESEARCH = NSString()
    var SHORTINGVALUESHORT = NSString()
    
    var USERID = NSString()
    var USERNAME = NSString()
    var USEREMAIL = NSString()
    var USERPHONE = NSString()
    var USERPROFILE = NSString()
    var USERTOKEN = NSString()
    var SEARCh = NSString()
    
    
    var FILTERPRICEMIN = NSString()
    var FILTERPRICEMAX = NSString()
    var FILTERPROPERTYTYPE = NSString()
    var FILTERINSPECTIONSCHEDULE = NSString()
    var FILTERBEDROOMSMIN = NSString()
    var FILTERBEDROOMSMAX = NSString()
    var FILTERBATHROOMMIN = NSString()
    var FILTERBATHROOMMAX = NSString()
    var FILTERLANDMIN = NSString()
    var FILTERLANDMAX = NSString()
    var FILTERSORT = NSString()
    var FILTERSUBURBS = NSString()
    var FILTERSUBURBSID = NSString()
    var FILTERPROPERTYTYPEID = NSString()
    var FILTERGARAGE = NSString()
    var FILTERKEYWORD = NSString()
    var FILTERSURROUNDING = Bool()
    var FILTEREXCLUDE = Bool()
    
    let defaults = UserDefaults.standard

    var SelectedData = AdvanceSearch(location: "Any",
                                     priceMin: "Any",
                                     priceMax: "Any",
                                     PropertyType: "Any",
                                     InspectionSchedule: "Any",
                                     BedroomsMin: "Any",
                                     BedroomsMax: "Any",
                                     BathroomMin: "Any",
                                     BathroomMax: "Any",
                                     LandMin: "Any",
                                     LandMax: "Any",
                                     Sort: "Newest",
                                     Suburbs: "Any",
                                     SuburbsId: "Any",
                                     PropertyTypeId: "Any",
                                     Garage: "Any",
                                     Keyword: "",
                                     Surrounding: false,
                                     Exclude: false)

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UITabBar.appearance().tintColor = UIColor().hexStringToUIColor(hex: "F37C2D")
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let IsLive = false
        if IsLive{
            WEBPATH = "https://retptyltd.com/phone_call/api/"
        }else{
            WEBPATH = "http://test2.rettest.com/slp_website/"
        }
        SHORTINGVALUESEARCH = "Newest"
        SHORTINGVALUESHORT = "Newest"

        appDelegate.SEARCh = "NO"
        FILTERPRICEMIN = ""
        FILTERPRICEMAX = ""
        FILTERPROPERTYTYPE = ""
        FILTERINSPECTIONSCHEDULE = ""
        FILTERBEDROOMSMIN = ""
        FILTERBEDROOMSMAX = ""
        FILTERBATHROOMMIN = ""
        FILTERBATHROOMMAX = ""
        FILTERLANDMIN = ""
        FILTERLANDMAX = ""
        FILTERSORT = ""
        FILTERSUBURBS = ""
        FILTERSUBURBSID = ""
        FILTERPROPERTYTYPEID = ""
        FILTERGARAGE = ""
        FILTERKEYWORD = ""
        FILTERSURROUNDING = false
        FILTEREXCLUDE = false
        

        self.applicationTheme()
        UIApplication.shared.statusBarStyle = .lightContent
        UIApplication.shared.statusBarStyle = .lightContent
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        var destinationController = UIViewController()
//        var frontNavigationController = UINavigationController(rootViewController: destinationController)
        print(defaults.bool(forKey: "STATUS"))
         if defaults.bool(forKey: "STATUS") as Bool{
            USERID = defaults.string(forKey: "USERID")! as NSString
            USERNAME = defaults.string(forKey: "USERNAME")! as NSString
            USEREMAIL = defaults.string(forKey: "USEREMAIL")! as NSString
            USERPHONE = defaults.string(forKey: "USERPHONE")! as NSString
            USERPROFILE = defaults.string(forKey: "USERPROFILE")! as NSString
            USERTOKEN = defaults.string(forKey: "TOKEN")! as NSString
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "MainTabBar")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
         }else{
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }
        
//        if defaults.bool(forKey: "STATUS") as Bool{
//            USERID = defaults.string(forKey: "USERID")! as NSString
//            USERNAME = defaults.string(forKey: "USERNAME")! as NSString
//            USEREMAIL = defaults.string(forKey: "USEREMAIL")! as NSString
//            USERPHONE = defaults.string(forKey: "USERPHONE")! as NSString
//            USERPROFILE = defaults.string(forKey: "USERPROFILE")! as NSString
//            USERTOKEN = defaults.string(forKey: "TOKEN")! as NSString
//            
//            destinationController = (storyboard.instantiateViewController(withIdentifier: "MainTabBar") as? MainTabBar)!
//            frontNavigationController = UINavigationController(rootViewController: destinationController)
//        }else
//        {
//            
//            destinationController = (storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController)!
//            frontNavigationController = UINavigationController(rootViewController: destinationController)
//        }
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        
////        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LoginSignupVC")
//        
//        self.window?.rootViewController = frontNavigationController
//        self.window?.makeKeyAndVisible()
//        
        return true
        

    }
    var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func applicationTheme(){
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor().hexStringToUIColor(hex: "F37C2D")
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

