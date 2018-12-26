//
//  CollectionBaseTableViewCell.swift
//  CollectionViewPractice
//
//  Created by 藤田和磨 on 2018/12/25.
//  Copyright © 2018 藤田和磨. All rights reserved.
//

import UIKit

class CollectionBaseTableViewCell: UITableViewCell {

    @IBOutlet weak var baseCollectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    // サムネイル画像の名前
    let photos = ["1","2","3","4","5","6","7"]

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        baseCollectionView.register(UINib(nibName: "PracticeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionCell")
        baseCollectionView.dataSource = self
        baseCollectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        // CollectionCell一つ一つの大きさ.
        layout.itemSize = CGSize(width:183, height:183)
        baseCollectionView.collectionViewLayout = layout
        let rowNumber = (photos.count + 1)/2
        collectionViewHeight.constant = CGFloat(rowNumber*183)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

extension CollectionBaseTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! PracticeCollectionViewCell
        cell.name.text = photos[indexPath.row]
        cell.imageView.image = UIImage(named: photos[indexPath.row])
        //セルの背景色をランダムに設定する。
        cell.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
        return cell
    }
    // Screenサイズに応じたセルサイズを返す
    // UICollectionViewDelegateFlowLayoutの設定が必要
    /*
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     // 横方向のスペース調整
     let horizontalSpace:CGFloat = 2
     let cellSize:CGFloat = self.view.bounds.width/2 - horizontalSpace
     // 正方形で返すためにwidth,heightを同じにする
     return CGSize(width: cellSize, height: cellSize)
     }
     */
}



