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
    // var collectionView: UICollectionView!
    
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
        tableView.register(UINib(nibName: "CollectionBaseTableViewCell", bundle: nil), forCellReuseIdentifier: "collectionBaseCell")
        
        // CollectionViewのレイアウトを生成
        // let layout = UICollectionViewFlowLayout()
        // CollectionCell一つ一つの大きさ.
        // layout.itemSize = CGSize(width:200, height:200)
        
        //collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        //collectionView.dataSource = self
        //collectionView.delegate = self
        // collectionView.register(UINib(nibName: "PracticeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionCell")
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

        switch indexPath.section {
        case 0: // 評判の医院
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! PracticeTableViewCell
            cell.nameLabel.text = photos[indexPath.row]
            //cell.clipsToBounds = true
            //cell.imageView?.clipsToBounds = true
            cell.practiceImageView?.clipsToBounds = true
            //cell.parentView?.clipsToBounds = true
            cell.practiceImageView?.image = UIImage(named: photos[indexPath.row])
            
            //セルの背景色をランダムに設定する。
            cell.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha:1.0)
            return cell
        default: // 近くの医院
            let cell = tableView.dequeueReusableCell(withIdentifier: "collectionBaseCell", for: indexPath) as! CollectionBaseTableViewCell
            return cell
        }
    }

    // Table Viewのセルの数を指定
    func tableView(_ table: UITableView, numberOfRowsInSection section: Int) -> Int {
        // レコメンド医院
        if section == 0 {
            return 2
        } // その他の医院
        else if section == 1 {
            // UICollectionViewを設定するセル
            return 1
        }
        else {
            return 0
        }
    }
    
    //この関数内でセクションの設定を行う
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label : UILabel = UILabel()
        
        label.backgroundColor = .white
        if section == 0 {
            label.font = UIFont.boldSystemFont(ofSize: CGFloat(30))
            label.text = sectionTitle[section]
        }
        else if section == 1 {
            label.font = UIFont.boldSystemFont(ofSize: CGFloat(25))
            label.text = sectionTitle[section]
        }
        return label
    }

}
