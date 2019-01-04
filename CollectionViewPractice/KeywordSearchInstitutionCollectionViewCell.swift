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
    
    var photos = ["1"]
    
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
            self.pageControl.inactiveTransparency = 0.8
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pagerView.dataSource = self
        pagerView.delegate = self

        pagerView.addSubview(pageControl)
        pagerView.addSubview(favoriteButton)
    }
}


// MARK: - FSPagerViewDataSource, FSPagerViewDelegate
extension KeywordSearchInstitutionCollectionViewCell: FSPagerViewDataSource, FSPagerViewDelegate {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        // pageControl設定
        pageControl.numberOfPages = photos.count

        return photos.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "PagerViewCell", at: index)
        
        // cell.contentView.layer.shadowOpacity = 0.4
        // cell.contentView.layer.opacity = 0.86
        cell.imageView?.image = UIImage(named: self.photos[index])
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        pageControl.set(progress: targetIndex, animated: true)
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        pageControl.set(progress: pagerView.currentIndex, animated: true)
    }
}
