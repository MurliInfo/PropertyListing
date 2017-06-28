//
//  AdvanceSearchModel.swift
//  SLP
//
//  Created by Hardik Davda on 6/13/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import Foundation

class AdvanceSearch{
    
    var strLocation: String?
    var strPriceMin: String?
    var strPriceMax: String?
    var strPropertyType: String?
    var strInspectionSchedule: String?
    var strBedroomsMin: String?
    var strBathroomsMin: String?
    var strBedroomsMax: String?
    var strBathroomsMax: String?
    
    var strLandSizeMin: String?
    var strLandSizeMax: String?
    var strSort : String?
    var strSuburbs: String?
    var strSuburbsId: String?
    var strPropertyTypeId: String?
    
    var strGarage: String?
    var strKeyword: String?
    var boolSurroundingSuburb: Bool?
    var boolExcludeUnderOffer: Bool?

    init(location: String?,priceMin:String?,priceMax:String?,PropertyType: String?,InspectionSchedule: String?,BedroomsMin: String?,BedroomsMax: String?,BathroomMin: String?,BathroomMax: String?,LandMin: String?,LandMax: String?,Sort: String?,Suburbs: String?,SuburbsId: String?,PropertyTypeId:String?,Garage:String?,Keyword:String?,Surrounding:Bool?,Exclude:Bool?) {
        self.strLocation = location
        self.strPriceMin = priceMin
        self.strPriceMax = priceMax
        self.strPropertyType = PropertyType
        self.strInspectionSchedule = InspectionSchedule
        self.strBedroomsMin = BedroomsMin
        self.strBedroomsMax = BedroomsMax
        self.strBathroomsMin = BathroomMin
        self.strBathroomsMax = BathroomMax
        self.strLandSizeMin =  LandMin
        self.strLandSizeMax = LandMax
        self.strSort = Sort
        self.strSuburbs = Suburbs
        self.strSuburbsId = SuburbsId
        self.strPropertyTypeId = PropertyTypeId
        self.strGarage = Garage
        self.strKeyword = Keyword
        self.boolSurroundingSuburb = Surrounding
        self.boolExcludeUnderOffer = Exclude
    }
//    func sendObject(object :AdvanceSearch) -> NSArray {
////        var array
//        
//        return
//    }
    
}
