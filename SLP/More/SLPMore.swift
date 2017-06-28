//
//  SLPMore.swift
//  SLP
//
//  Created by Hardik Davda on 6/1/17.
//  Copyright © 2017 SLP-World. All rights reserved.
//

import UIKit

class SLPMore: UIViewController {
    @IBOutlet var table: UITableView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblEmail: UILabel!
  
    var PrintListData = [MoreList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SLPAllWebservices().moreListData(with: "", API: "", completion: {(ListData) in
            self.PrintListData = ListData
            self.table.reloadData()
        })
    }
}

// MARK: - Uitablevie Delagate and Data source


extension SLPMore :UITableViewDelegate,UITableViewDataSource{
// MARK: - Uitablevie Data source
    public func numberOfSections(in tableView: UITableView) -> Int{
        return 2
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1;
        }else{
            return self.PrintListData.count
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell:SLPCustomCell = tableView.dequeueReusableCell(withIdentifier: "cell1") as UITableViewCell! as! SLPCustomCell
            let profileURL =  URL(string:  appDelegate.USERPROFILE as String)
            print(appDelegate.USERPROFILE)
            cell.imgConsultantProfile.sd_setImage(with: profileURL, placeholderImage: #imageLiteral(resourceName: "Avtar"))
            
            cell.imgConsultantProfile.layer.masksToBounds = true
            cell.imgConsultantProfile.layer.cornerRadius = cell.imgConsultantProfile.frame.size.height/2
            
            cell.lblConsultantName.text = appDelegate.USERNAME as String
            cell.lblConsultantEmail.text = appDelegate.USEREMAIL as String
            return cell
        }else{
            let cell:SLPCustomCell = tableView.dequeueReusableCell(withIdentifier: "cell2") as UITableViewCell! as! SLPCustomCell
            let print = self.PrintListData[indexPath.row]
            cell.lblTitle.text = print.strTitle
            cell.imgCheck.image = print.imgIcones
            return cell
        }
    }
    
  // MARK: - Uitablevie Delagate
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?{
        if indexPath.section == 1{
            if indexPath.row == 0{
                let storyBoard : UIStoryboard = UIStoryboard(name: "MORE", bundle:nil)
                let secondViewController = storyBoard.instantiateViewController(withIdentifier: "SLPLoginProfile") as! SLPLoginProfile
                self.navigationController?.pushViewController(secondViewController, animated: true)
            }else
            if indexPath.row == 1{
                    
            }else
            if indexPath.row == 2{
                let storyBoard : UIStoryboard = UIStoryboard(name: "MORE", bundle:nil)
                let secondViewController = storyBoard.instantiateViewController(withIdentifier: "SLPFeedback") as! SLPFeedback
                self.navigationController?.pushViewController(secondViewController, animated: true)
            }else
            if indexPath.row == 3{
                let storyBoard : UIStoryboard = UIStoryboard(name: "MORE", bundle:nil)
                let secondViewController = storyBoard.instantiateViewController(withIdentifier: "SLPUserChangePassword") as! SLPUserChangePassword
                self.navigationController?.pushViewController(secondViewController, animated: true)
            }
            if indexPath.row == 4 {
                let alert = UIAlertController(title: "Are you sure want to logout?", message: "", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                    print(action.style)
                    switch action.style{
                    case .default:
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let secondViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                        self.present(secondViewController, animated:true, completion: nil)
//                        self.navigationController?.pushViewController(secondViewController, animated: true)
                    case .cancel:
                        print("cancel")
                    case .destructive:
                        print("destructive")
                    }
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
            return indexPath
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0{
            return 188
        }else{
            return 54
        }
    }
    
}
