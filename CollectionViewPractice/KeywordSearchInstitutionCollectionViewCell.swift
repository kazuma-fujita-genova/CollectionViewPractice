//
//  KeywordSearchInstitutionCollectionViewCell.swift
//  CollectionViewPractice
//
//  Created by 藤田和磨 on 2018/12/27.
//  Copyright © 2018 藤田和磨. All rights reserved.
//

import UIKit
import FSPagerView
import CHIPageControl
import FaveButton

class KeywordSearchInstitutionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var institutionName: UILabel!
    
    @IBOutlet weak var institutionAddress: UILabel!

    @IBOutlet weak var favoriteButton: FaveButton!
    
    @IBOutlet weak var faveButtonHeight: NSLayoutConstraint!
    
    @IBOutlet weak var faveButtonWidth: NSLayoutConstraint!
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            // 再利用する画像PagerViewCell設定
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "PagerViewCell")
            // 無限ループ設定
            self.pagerView.isInfinite = true
            // Automatic Slider
            // pagerView.automaticSlidingInterval = 4
            // エフェクト coverFlow .linear, .overlap は以下を有効
            // pagerView.transformer = FSPagerViewTransformer(type: .linear)
            // pagerView.itemSize = CGSize(width: 300, height: 200)
            // pagerView.itemSize = FSPagerView.automaticSize
            // pagerView.interitemSpacing = 16
            // エフェクト .crossFading, .zoomOut, .depth のときは以下を有効
            // pagerView.transformer = FSPagerViewTransformer(type: .zoomOut)
            self.pagerView.itemSize = FSPagerView.automaticSize
            self.pagerView.decelerationDistance = 1
        }
    }
    
    @IBOutlet weak var pageControl: CHIPageControlAleppo! {
        didSet {
            // コントローラーUIViewサイズ
            self.pageControl.frame = CGRect(x: 0, y:0, width: 100, height: 20)
            // コントローラーUIViewの背景色
            self.pageControl.backgroundColor = .none
            // ドットの大きさ
            self.pageControl.radius = 4
            // ドットの幅
            self.pageControl.padding = 8
            // ドット色
            self.pageControl.tintColor = .white
            // アクティブなドット色
            self.pageControl.currentPageTintColor = .white
            // 非アクティブなドットの透明度
            self.pageControl.inactiveTransparency = 0.7
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pagerView.addSubview(pageControl)
        pagerView.addSubview(favoriteButton)
    }
}
