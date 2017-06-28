//
//  SLPCustomCell.swift
//  SLP
//
//  Created by Hardik Davda on 6/1/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class SLPCustomCell: UITableViewCell {
    @IBOutlet var lblHeading: UILabel!
    @IBOutlet var lblSuburb: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblBedrooms: UILabel!
    @IBOutlet var lblBathrooms: UILabel!
    @IBOutlet var lblGarage: UILabel!
    @IBOutlet var lblPropertyType: UILabel!
    @IBOutlet var lblConsultantName: UILabel!
      @IBOutlet var lblConsultantEmail: UILabel!
    @IBOutlet var imgConsultantProfile: UIImageView!
    @IBOutlet var imgStar: UIImageView!
    var indPath: IndexPath!
    @IBOutlet var btnFavorit: UIButton!
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var scroll: UIScrollView!
    @IBOutlet var lblSelected: UILabel!
    @IBOutlet var imgCheck: UIImageView!
    var scrollViewTapHandler :((IndexPath)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(SLPSearch.someAction))
//        self.scroll.addGestureRecognizer(gesture)

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func someAction(_ sender: Any)  {
    
        print("Inside cell\((sender as AnyObject).tag)")
        print(self.indPath.row)
        if let hendler = scrollViewTapHandler{
            hendler(self.indPath)
        }
    }
}
