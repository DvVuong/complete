//
//  ListsTableViewCell.swift
//  Combine_MVVM
//
//  Created by admin on 17/10/2022.
//

import UIKit

class ListsTableViewCell: UITableViewCell {
    @IBOutlet weak var lbName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
