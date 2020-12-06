//
//  SafeTipsTableViewCell.swift
//  StaySafe
//
//  Created by knight on 11/30/20.
//

import UIKit

class SafeTipsTableViewCell: UITableViewCell {

    @IBOutlet weak var safeTipName: UILabel! {
        didSet {
            safeTipName.numberOfLines = 0
        }
    }
    @IBOutlet weak var safeTipImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
