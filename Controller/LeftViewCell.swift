//
//  LeftViewCell.swift
//  TodoKids
//
//  Created by Diwakar Kumar on 25/09/17.
//  Copyright © 2017 SmartDeveloper. All rights reserved.
//

import UIKit

class LeftViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCellData(title : String?, icon : UIImage){
        titleLabel.text = title
        iconImageView.image = icon

    }
    
}
