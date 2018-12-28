//
//  TabBarViewController.swift
//  CollectionViewPractice
//
//  Created by 藤田和磨 on 2018/12/26.
//  Copyright © 2018 藤田和磨. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let keywordSearchViewController = storyboard.instantiateViewController(withIdentifier:"KeywordSearch")
        let rootViewController = UINavigationController(rootViewController: keywordSearchViewController)

        let keywordSearchListViewController = storyboard.instantiateViewController(withIdentifier:"KeywordSearchList")
        let keywordSearchListViewRootController = UINavigationController(rootViewController: keywordSearchListViewController)


        setViewControllers([keywordSearchListViewRootController,rootViewController], animated: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
