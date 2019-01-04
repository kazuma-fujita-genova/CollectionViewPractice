//
//  KeywordSearchListViewController
//  CollectionViewPractice
//
//  Created by 藤田和磨 on 2018/12/26.
//  Copyright © 2018 藤田和磨. All rights reserved.
//

import UIKit
import FSPagerView
import FaveButton
import MaterialComponents.MaterialSnackbar
import MaterialComponents.MaterialSnackbar_ColorThemer
import MaterialComponents.MaterialSnackbar_TypographyThemer


class KeywordSearchListViewController: UIViewController {
    

    @IBOutlet weak var keywordSearchCollectionView: UICollectionView!
    
    private var searchController: UISearchController!
    
    // let colorScheme = MDCSemanticColorScheme()
    // let typographyScheme = MDCTypographyScheme()
    let toastMessage = MDCSnackbarMessage()
    
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
        
        // TODO: スナックバーのテーマ変更
        // MDCSnackbarColorThemer.applySemanticColorScheme(colorScheme)
        // MDCSnackbarTypographyThemer.applyTypographyScheme(typographyScheme)

    }
    
    // TODO: カスタムクラス化すること
    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        // 自分を結果表示用ViewControllerに設定
        searchController.searchResultsUpdater = self
        // 検索ボックスのプレースホルダー文言設定
        searchController.searchBar.placeholder = "病院名・地域名・所在地"
        // キャンセルボタン色設定
        searchController.searchBar.tintColor = .black
        // キャンセルボタン文言設定
        searchController.searchBar.setValue("キャンセル", forKey: "_cancelButtonText")
        // キャンセルボタンは非表示
        // searchController.searchBar.setValue("", forKey: "_cancelButtonText")
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
        keywordSearchCollectionView?.register(UINib(nibName: "KeywordSearchInstitutionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
        keywordSearchCollectionView?.dataSource = self
        keywordSearchCollectionView?.delegate = self
    }
}

// MARK: - UISearchResultsUpdating - SearchBar入力文字列から検索結果データ設定
extension KeywordSearchListViewController: UISearchResultsUpdating {
    
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
extension KeywordSearchListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // 表示Cell数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    // Section数
    func numberOfSections(in collectionViesw: UICollectionView) -> Int {
        return 1
    }
    
    // 再利用されるCell取得
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! KeywordSearchInstitutionCollectionViewCell
        cell.institutionName.text = photos[indexPath.row]
        
        cell.pagerView.dataSource = self
        cell.pagerView.delegate = self
        cell.favoriteButton.delegate = self
        
        //セルの背景色をランダムに設定する。
        cell.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
        return cell
            
    }
}

// MARK: - UICollectionViewDelegateFlowLayout - CollectionViewCellサイズ動的変更
extension KeywordSearchListViewController: UICollectionViewDelegateFlowLayout {
    
    // Cellサイズを動的に変更
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 1Column
        // 画面横幅 - Cell外側左右マージン32ポイント分空ける
        var widthSize:CGFloat = self.view.bounds.width - (32 * 2)
        var heightSize:CGFloat = widthSize
        if indexPath.row > 1 {
            // 2Column
            // 1Column横幅の半分 - Cell内側マージン8ポイント分空ける
            widthSize = (widthSize / 2) - 8
            heightSize = widthSize
        }
        return CGSize(width: widthSize, height: heightSize)
    }
    
    // Cell外周のマージン
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // 2Colum表示用。Cell外側左右マージン32ポイント
        return UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
    }
    
    // Cell内側上下間の最小マージン
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    // Cell内側左右間の最小マージン
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

// MARK: - FSPagerViewDataSource, FSPagerViewDelegate
extension KeywordSearchListViewController: FSPagerViewDataSource, FSPagerViewDelegate {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return photos.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "PagerViewCell", at: index)
        
        cell.contentView.layer.shadowOpacity = 0.4
        cell.contentView.layer.opacity = 0.86
        cell.imageView?.image = UIImage(named: photos[index])
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        // TODO: KeywordSearchCellのpageControlが取得できない
        // pageControl.set(progress: targetIndex, animated: true)
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        // TODO: KeywordSearchCellのpageControlが取得できない
        // pageControl.set(progress: pagerView.currentIndex, animated: true)
    }
}

// MARK: - FaveButtonDelegate
extension KeywordSearchListViewController: FaveButtonDelegate {
    func faveButton(_ faveButton: FaveButton, didSelected selected: Bool) {
        // TODO: お気に入りボタンタップ処理
        if selected {
            toastMessage.text = "かかりつけの病院にしました"
            MDCSnackbarManager.show(toastMessage)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
