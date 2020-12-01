//
//  CasesAnalyticTableViewCell.swift
//  StaySafe
//
//  Created by knight on 11/28/20.
//

import UIKit

class CaseLocationTableViewCell: UITableViewCell {

    @IBOutlet weak var county: UILabel!
    @IBOutlet weak var status: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
