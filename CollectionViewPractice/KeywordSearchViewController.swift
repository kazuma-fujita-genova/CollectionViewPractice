//
//  KeywordSearchViewController.swift
//  CollectionViewPractice
//
//  Created by 藤田和磨 on 2018/12/26.
//  Copyright © 2018 藤田和磨. All rights reserved.
//

import UIKit

class KeywordSearchViewController: UIViewController {

    @IBOutlet weak var keywordSearchCollectionView: UICollectionView!
    
    // サムネイル画像の名前
    let photos = ["1","2","3","4","5","6","7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        keywordSearchCollectionView.register(UINib(nibName: "KeywordSearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionCell")
        keywordSearchCollectionView.dataSource = self
        keywordSearchCollectionView.delegate = self
        
        //let layout = UICollectionViewFlowLayout()
        // CollectionCell一つ一つの大きさ.
        //layout.itemSize = CGSize(width:348, height:280)
        //keywordSearchCollectionView.collectionViewLayout = layout
        //let rowNumber = (photos.count + 1)/2
        //keywordSearchCollectionView.constant = CGFloat(rowNumber*183)
    }
}


extension KeywordSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    // 表示Cell数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    // Section数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // 再利用されるCell取得
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! KeywordSearchCollectionViewCell
        cell.institutionName.text = photos[indexPath.row]
        cell.institutionImageView.image = UIImage(named: photos[indexPath.row])
        //セルの背景色をランダムに設定する。
        cell.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
        return cell
    }
}

extension KeywordSearchViewController: UICollectionViewDelegateFlowLayout {
    
    // Cellサイズを動的に変更
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        // 1Column
        // 画面横幅 - Cell左右マージン32ポイント
        var widthSize:CGFloat = self.view.bounds.width - (32 * 2)
        var heightSize:CGFloat = widthSize
        if indexPath.row > 0 {
            // 2Column
            // 1Column横幅の半分 - 左右隣り合わせのCellマージン8ポイント
            widthSize = (widthSize / 2) - 8
            heightSize = widthSize
        }
        return CGSize(width: widthSize, height: heightSize)
     }
    
    // Cell外周のマージン
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // 2Colum表示用。Cell左右マージン32ポイント
        return UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
    }
    
    // Cell上下間の最小マージン
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
}
