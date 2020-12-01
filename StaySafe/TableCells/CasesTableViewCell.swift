//
//  CasesTableViewCell.swift
//  StaySafe
//
//  Created by knight on 11/28/20.
//

import UIKit

class CasesTableViewCell: UITableViewCell {

    @IBOutlet weak var casesLabel: UILabel!
    @IBOutlet weak var lastUpdate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
