//
//  HomeViewController.swift
//  ibve
//
//  Created by yesway on 16/7/18.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    private lazy var listViewModel = StatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadData() {
        
        print("准备刷新")
        
        refeshControl?.beginRefreshing()
        
        listViewModel.loadStatus(pullUp: isPullup) { (isSuccess, shouldRefresh) in
            
        }
        
    }
}
