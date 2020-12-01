//
//  UpdateTableViewCell.swift
//  StaySafe
//
//  Created by knight on 11/26/20.
//

import UIKit

class UpdateTableCell: UITableViewCell {

    @IBOutlet weak var phaseImage: UIImageView!
    @IBOutlet weak var cases: UILabel!
    @IBOutlet weak var county: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
