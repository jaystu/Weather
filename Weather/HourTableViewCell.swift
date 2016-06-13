//
//  HourTableViewCell.swift
//  Weather
//
//  Created by John Stuart on 6/12/16.
//  Copyright © 2016 John Stuart. All rights reserved.
//

import UIKit

class HourTableViewCell: UITableViewCell {
    
    // Mark: - Properties
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
