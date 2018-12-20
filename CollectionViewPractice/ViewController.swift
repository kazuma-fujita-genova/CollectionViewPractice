//
//  ViewController.swift
//  CollectionViewPractice
//
//  Created by 藤田和磨 on 2018/12/18.
//  Copyright © 2018 藤田和磨. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //@IBOutlet weak var collectionView: UICollectionView!
    var collectionView: UICollectionView!
    
    // サムネイル画像の名前
    let photos = ["1","2","3","4","5","6","7"]
    
    // Sectionタイトル
    let sectionTitle = ["評判の病院", "近くの病院"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TableViewの罫線を消す
        tableView.separatorStyle = .none
        // テーブル行の高さをAutoLayoutで自動調整
        tableView.rowHeight = UITableView.automaticDimension
        // テーブル行の高さの概算値を設定
        tableView.estimatedRowHeight = 280

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "PracticeTableViewCell", bundle: nil), forCellReuseIdentifier: "tableCell")
        
        // CollectionViewのレイアウトを生成
        let layout = UICollectionViewFlowLayout()
        // CollectionCell一つ一つの大きさ.
        layout.itemSize = CGSize(width:200, height:200)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "PracticeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionCell")
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Section数
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    // Sectionタイトル
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section] as String
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! PracticeTableViewCell
        if indexPath.section == 0 {
            cell.nameLabel.text = photos[indexPath.row]
            //cell.clipsToBounds = true
            //cell.imageView?.clipsToBounds = true
            cell.practiceImageView?.clipsToBounds = true
            //cell.parentView?.clipsToBounds = true
            cell.imageView?.image = UIImage(named: photos[indexPath.row])
            
            //セルの背景色をランダムに設定する。
            cell.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha:1.0)
        }
        else if indexPath.section == 1 {
            cell.addSubview(collectionView)
        }
        return cell
    }

    // Table Viewのセルの数を指定
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        // レコメンド医院
        if section == 0 {
            return 5
        } // その他の医院
        else if section == 1 {
            // UICollectionViewを設定するセル
            return 1
        }
        else {
            return 0
        }
    }

}

// extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
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


