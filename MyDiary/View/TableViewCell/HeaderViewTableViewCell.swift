//
//  HeaderViewTableViewCell.swift
//  My Dairy
//
//  Created by 46tech on 06/12/20.
//

import UIKit

class HeaderViewTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setTitle(title: String) {
        titleLabel.text = title
    }
    
}
