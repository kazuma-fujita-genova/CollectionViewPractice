//
//  KeywordSearchPracticeCollectionViewCell.swift
//  CollectionViewPractice
//
//  Created by 藤田和磨 on 2018/12/27.
//  Copyright © 2018 藤田和磨. All rights reserved.
//

import UIKit

class KeywordSearchPracticeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var institutionName: UILabel!
    
    @IBOutlet weak var institutionAddress: UILabel!
    
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    @IBOutlet weak var imageScrollParentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // ScrollView左右ページング有効
        imageScrollView.isPagingEnabled = true
    }

}
