//
//  SLPStructure.swift
//  SLP
//
//  Created by Hardik Davda on 6/1/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import Foundation
import UIKit

struct userLoginDetailList{
    var strId: String!
    var strName: String!
    var strEmail: String!
    var strPhone: String!
    var strProfilePicture: String!
    var strServiceToken: String!
}
struct GetSuburb{
    var strSuburbId : String
    var strSuburbName : String
}


struct SearchDetailsDataList{
    var strId: String!
    var strStreetNumber: String!
    var strStreet: String!
    var strState: String!
    var strSuburb: String!
    var strWebsiteBrochureDisplayPrice: String!
    var strBedrooms: String!
    var strBathrooms: String!
    var strGarage: String!
    var arrayPropertyImages: Array<String>!
    var strFloorImage: String!
    var strHeading: String!
    var strDescription: String!
    var strPropertyType: String!
    var strLandAreaSqm: String!
    var strBuildingAreaSqm: String!
    var strParkingOther: String!
    var strPool: String!
    var strStudy: String!
    var strExternalLink: String!
    var strVideoLink: String!
    var strLatitude: String!
    var strLongitude: String!
    var strConsultantOneId: String!
    var strConsultantOneName: String!
    var strConsultantOnePosition: String
    var strConsultantOneImage: String!
    var strConsultantOneMobile: String!
    var strConsultantOneEmail: String!
    var strConsultantOneFbUrl: String!
    var strConsultantOneLinkedinUrl: String!
    var strConsultantOnePinterestUrl: String!
    var strConsultantOneGplusUrl: String!
    var strConsultantOneTwitterUrl: String!
    var strConsultantTwoId: String!
    var strConsultantTwoName: String!
    var strConsultantTwoPosition: String!
    var strConsultantTwoImage: String!
    var strConsultantTwoMobile: String!
    var strConsultantTwoEmail: String!
    var strConsultantTwoFbUrl: String!
    var strConsultantTwoLinkedinUrl: String!
    var strConsultantTwoPinterestUrl: String!
    var strConsultantTwoGplusUrl: String!
    var strConsultantTwoTwitterUrl: String!
    var structHomeOpenData = [SearchDetailHomeOpens]()
}

struct SearchDataList{
    var strId : String!
    var strHeading : String!
    var strLot : String!
    var strUnit : String!
    var strSuburb : String!
    var strStreetNo : String!
    var strPoBox : String!
    var strStreet : String!
    var strPropertyPriceFrom : String!
    var strPropertyPriceTo: String!
    var strBedrooms: String!
    var strBathrooms: String!
    var strGarage : String!
    var arrayPropertyImages : Array<String>!
    var strStatus : String!
    var strWebsiteBroachurDisplayPrice : String!
    var strConsultantOneId : String!
    var strConsultantOneName : String!
    var strConsultantOnePosition : String!
    var strConsultantOneImage : String!
    var strConsultantTwoId : String!
    var strConsultantTwoName : String!
    var strConsultantTwoPosition : String!
    var strConsultantTwoImage : String!
    var isSave : Bool!
    var strIsFavourite : String!
    var IsNew : String!
}
    
struct SearchDetailHomeOpens{
    var strdate: String!
    var strstart_time: String!
    var strend_time: String!
}

struct PropertyTypeListData {
    var strId : String!
    var strPropertyType : String!
    var boolStatus : Bool
}
struct filterSavedList{
    var strId : String!
    var strName : String!
    var strObject : AdvanceSearch!
}

struct SuburbListData {
    var strId : String!
    var strStateId : String!
    var strSuburb : String!
    var strStatus : String!
    var strCreatedAt : String!
    var strUpdatedAt: String!
    var strStateName: String!
}

struct PropertyType{
    var strId : String!
    var strPropertyType : String!
    var strStatus : String!
    var strCreatedAt : String!
    var strUpdatedAt : String!
    var isSelect : Bool!
 
}

struct AdvanceSearchDataList{
    var strTitle : String!
    var strData : String!
    var isSelect : Bool!
}

struct MoreList{
    var strTitle : String!
    var imgIcones : UIImage!
    var isSelect : Bool!
}

struct CounsultantProfile{
    var strId : String!
    var strName : String!
    var strPhoto : String!
    var strDescription : String!
    var strPosition : String!
    var strPhone : String!
    var strMobile : String!
    var strEmail : String!
    var strWebsite : String!
    var strProfileVideoUrl : String!
    var strFacebookProfileUrl : String!
    var strTwitterProfileUrl : String!
    var strLinkedinProfileUrl : String!
    var strPinterestProfileUrl : String!
    var strGooglePlusProfileUrl : String!
    var strStateName : String!
}
