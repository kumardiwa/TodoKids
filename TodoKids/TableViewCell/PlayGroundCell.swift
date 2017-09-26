//
//  PlayGroundCell.swift
//  TodoKids
//
//  Created by Diwakar Kumar on 22/09/17.
//  Copyright © 2017 SmartDeveloper. All rights reserved.
//

import UIKit
import Cosmos
import SDWebImage

class PlayGroundCell: UITableViewCell {

    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var rattingLabel: UILabel!
    @IBOutlet weak var rattingView: CosmosView!
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblDesription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCellData(_ place : DKNearbyPlace){
        var addressArr : [String]? = place.vicinity?.components(separatedBy: ",")
        if (addressArr?.count)! > 6 {
            let count : Int = (addressArr?.count)!
            let address = "\((addressArr?[0])!), \((addressArr?[1])!),\((addressArr?[2])!),\((addressArr?[3])!),\((addressArr?[count-2])!),\((addressArr?[count-1])!),"
            lblDesription.text = address
        }
        else{
            lblDesription.text = place.vicinity
        }
        
        placeName.text = place.name
        setupPlaceType(place.type ?? .restaurant)
        if place.rating == 0.0 {
            rattingView.isHidden = false
            rattingLabel.text = "4.0"
            rattingView.rating = 4.0
            
        }
        else{
            rattingView.isHidden = false
            rattingLabel.text = "\(place.rating)"
            rattingView.rating = Double(place.rating)
        }
       
        
        lblAddress.text = "Close Now"
        if place.image != nil {
            self.iconImageView.image = place.image!
        }
        else{
            self.iconImageView.image = #imageLiteral(resourceName: "restaurantPlaceHolder")
            place.loadFirstPhoto { (image, errorStr) in
                if errorStr == nil{
                    self.iconImageView.image = image!
                }
            }
        }
        
    }
    func setupPlaceType(_ type : DKPlaceType){
        switch type {
        case .restaurant,.food,.meal_delivery,.meal_takeaway:
            lblType.text = "Restaurant"
        case .park:
            lblType.text = "Park"
        case .night_club:
            lblType.text = "Night Club"
        case .casino:
            lblType.text = "Casino"
        default:
            lblType.text = "Default"
        }
    }
    
}
