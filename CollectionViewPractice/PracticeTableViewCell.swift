//
//  PracticeTableViewCell.swift
//  CollectionViewPractice
//
//  Created by 藤田和磨 on 2018/12/18.
//  Copyright © 2018 藤田和磨. All rights reserved.
//

import UIKit

class PracticeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var practiceImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        // practiceImageView.clipsToBounds = true
    }
    
}
