//
//  AboutDescriptionCellTableViewCell.swift
//  StaySafe
//
//  Created by knight on 11/29/20.
//

import UIKit

class AboutDescriptionCellTableViewCell: UITableViewCell {

    @IBOutlet weak var aboutDescription: UILabel! {
        didSet {
            aboutDescription.numberOfLines = 0
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
