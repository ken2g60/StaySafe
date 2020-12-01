//
//  HomeUpdateCell.swift
//  StaySafe
//
//  Created by knight on 11/26/20.
//

import UIKit

class HomeTableCell: UITableViewCell {

    @IBOutlet var statusImage: UIImageView!
    @IBOutlet weak var cases: UILabel!
    @IBOutlet weak var county: UILabel!
    @IBOutlet weak var last_update: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
