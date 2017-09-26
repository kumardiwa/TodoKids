//
//  AutoCompletePlaceCell.swift
//  letstrack
//
//  Created by Diwakar Kumar on 16/06/17.
//  Copyright © 2017 Prima Business. All rights reserved.
//

import UIKit

class AutoCompletePlaceCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setCellData(_ place : DKGooglePlace){
        titleLabel.font = UIFont(name: DKTitleLabel.fontName, size: DKTitleLabel.fontSize)
        subtitleLabel.font = UIFont(name: DKTitleLabel.fontName, size: DKTitleLabel.fontSize)
        titleLabel.text = place.title ?? ""
        subtitleLabel.text = place.subtitle ?? ""
    }
    
}
