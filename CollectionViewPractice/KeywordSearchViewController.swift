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
    
    private var searchController: UISearchController!
    
    // サムネイル画像の名前
    let photos = ["1","2","3","4","5","6","7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "病院を探す"
        // iOS 11 からの機能
        if #available(iOS 11.0, *) {
            // Large Title
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        // TODO: NavigationBar打ち消し検証
        // self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        // self.navigationController?.navigationBar.shadowImage = UIImage()
        
        setupSearchController()
        setupCollectionView()
    }
    
    // TODO: カスタムクラス化すること
    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        // 自分を結果表示用ViewControllerに設定
        searchController.searchResultsUpdater = self
        // 検索ボックスのプレースホルダー文言設定
        searchController.searchBar.placeholder = "病院名・地域名・所在地"
        // キャンセルボタン色設定
        //searchController.searchBar.tintColor = .black
        // キャンセルボタン文言設定
        //searchController.searchBar.setValue("キャンセル", forKey: "_cancelButtonText")
        // キャンセルボタンは非表示
        searchController.searchBar.setValue("", forKey: "_cancelButtonText")
        // 検索ボックス内背景色設定 TODO: 何故かきかない
        // searchController.searchBar.backgroundColor = .white
        // キーボード表示時、NavigationBarを非表示
        searchController.hidesNavigationBarDuringPresentation = true
        // キーボード表示時、コンテンツをグレー表示
        // searchController.dimsBackgroundDuringPresentation = true
        // 検索結果候補を動的に表示
        // searchController.obscuresBackgroundDuringPresentation = true
        // NavigationBarにSearchControllerをセット
        self.navigationItem.searchController = searchController
        // 画面スクロール時にSearchControllerを隠す
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupCollectionView() {
        keywordSearchCollectionView?.register(UINib(nibName: "KeywordSearchPracticeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionCell")
        keywordSearchCollectionView?.dataSource = self
        keywordSearchCollectionView?.delegate = self
    }
}

// MARK: - UISearchResultsUpdating - SearchBar入力文字列から検索結果データ設定
extension KeywordSearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        // SearchBarに入力したテキストを使って表示データを取得
        let text = searchController.searchBar.text ?? ""
        if text.isEmpty {
            // nop..
        } else {
            // nop..
        }
        keywordSearchCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource UICollectionViewDelegate - CollectionViewCellデータ設定
extension KeywordSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // 表示Cell数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.keywordSearchCollectionView {
            return photos.count
        }
        return 2
        //return photos.count
    }
    
    // Section数
    func numberOfSections(in collectionViesw: UICollectionView) -> Int {
        return 1
    }
    
    // 再利用されるCell取得
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.keywordSearchCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! KeywordSearchPracticeCollectionViewCell
            cell.institutionName.text = photos[indexPath.row]
            
            cell.imageCollectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionCell")
            cell.imageCollectionView.dataSource = self
            cell.imageCollectionView.delegate = self
            
            //セルの背景色をランダムに設定する。
            cell.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
            return cell
            
        } else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! ImageCollectionViewCell
            cell.imageView.image = UIImage(named: photos[indexPath.item])
            cell.imageView.contentMode = .scaleAspectFill
            cell.imageView.clipsToBounds = true
            return cell
        }
        
        
        // cell.institutionImageView.image = UIImage(named: photos[indexPath.row])
        /*cell.imageScrollView.frame = CGRect(x: 0.0, y: 0.0, width: cell.imageScrollParentView.bounds.width, height: cell.imageScrollParentView.bounds.height)
         // cell.imageScrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * 3, height: UIScreen.main.bounds.height)
         cell.imageScrollView.contentSize = CGSize(width: cell.imageScrollParentView.bounds.width * 2.0, height: cell.imageScrollParentView.bounds.width)
         
         cell.imageScrollView.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
         
         // 1枚目の画像
         let firstImageView = UIImageView(image: UIImage(named: "1"))
         firstImageView.frame = cell.imageScrollParentView.bounds
         firstImageView.contentMode = UIView.ContentMode.scaleAspectFill
         firstImageView.clipsToBounds = true
         cell.imageScrollParentView.backgroundColor = .red
         // TODO: clipsToBounds効かない
         // firstImageView.clipsToBounds = true
         // cell.imageScrollView.clipsToBounds = true
         // cell.imageScrollParentView.clipsToBounds = true
         cell.imageScrollParentView.addSubview(firstImageView)
         
         // 2枚目の画像
         let secondImageView = UIImageView(image: UIImage(named: "2"))
         secondImageView.frame = CGRect(x: cell.imageScrollParentView.bounds.width * 2.0, y: 0.0, width: cell.imageScrollParentView.bounds.width, height: cell.imageScrollParentView.bounds.height)
         secondImageView.contentMode = UIView.ContentMode.scaleAspectFill
         secondImageView.clipsToBounds = true
         cell.imageScrollParentView.backgroundColor = .blue
         cell.imageScrollParentView.addSubview(secondImageView)
         
         cell.imageScrollView.isScrollEnabled = true*/
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout - CollectionViewCellサイズ動的変更
extension KeywordSearchViewController: UICollectionViewDelegateFlowLayout {
    
    // Cellサイズを動的に変更
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.keywordSearchCollectionView {
            // 1Column
            // 画面横幅 - Cell外側左右マージン32ポイント分空ける
            var widthSize:CGFloat = self.view.bounds.width - (32 * 2)
            var heightSize:CGFloat = widthSize
            if indexPath.row > 0 {
                // 2Column
                // 1Column横幅の半分 - Cell内側マージン8ポイント分空ける
                widthSize = (widthSize / 2) - 8
                heightSize = widthSize
            }
            return CGSize(width: widthSize, height: heightSize)
        }
        return CGSize(width: keywordSearchCollectionView.frame.width, height: keywordSearchCollectionView.frame.width * 0.5)
        
    }
    
    // Cell外周のマージン
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.keywordSearchCollectionView {
            // 2Colum表示用。Cell外側左右マージン32ポイント
            return UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        }
        return .zero
    }
    
    // Cell内側上下間の最小マージン
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.keywordSearchCollectionView {
            return 32
        }
        return 0
    }
    
    // Cell内側左右間の最小マージン
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.keywordSearchCollectionView {
            return 16
        }
        return 0
    }
}
