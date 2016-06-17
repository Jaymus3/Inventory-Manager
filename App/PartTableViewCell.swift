//
//  MealTableViewCell.swift
//  Food Tracker
//
//  Created by Sturtevant Auto on 5/31/16.
//  Copyright © 2016 Sturtevant Auto. All rights reserved.
//

import UIKit

class PartTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var warningImage: UIImageView!
    @IBOutlet weak var cellSwitch: UISwitch!
    @IBOutlet weak var switchButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
