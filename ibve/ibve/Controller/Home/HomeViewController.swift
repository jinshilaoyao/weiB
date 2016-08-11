//
//  HomeViewController.swift
//  ibve
//
//  Created by yesway on 16/7/18.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit

/// 原创微博可重用 cell id
private let originalCellId = "originalCellId"
/// 被转发微博的可重用 cell id
private let retweetedCellId = "retweetedCellId"

class HomeViewController: BaseViewController {

    private lazy var listViewModel = StatusListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadData() {
        
        print("准备刷新")
        
        refeshControl?.beginRefreshing()
        
        listViewModel.loadStatus(pullUp: isPullup) { (isSuccess, shouldRefresh) in
           
            if isSuccess {
                self.refeshControl?.endRefreshing()
                
                self.isPullup = false
                
                if shouldRefresh {
                    self.tableView?.reloadData()
                }
            }
            
        }
    }
}

extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let status = listViewModel.statusList[indexPath.row] as StatusViewModel
        
        let cellID = (status.status.retweeted_status != nil) ? retweetedCellId : originalCellId
        
        let cell = tableView.dequeueReusableCell(withIdentifier: originalCellId, for: indexPath) as! StatusCell
//        let cell = tableView.dequeueReusableCell(withIdentifier: originalCellId)
        
        cell.viewModel = status
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 1. 根据 indexPath 获取视图模型
        let vm = listViewModel.statusList[indexPath.row]
        
        // 2. 返回计算好的行高
        return vm.rowHeight
    }
}

extension HomeViewController {
    override func setupTableView() {
        
        super.setupTableView()
        
        tableView?.register(UINib(nibName: "StatusNormalCell", bundle: nil), forCellReuseIdentifier: originalCellId)
        tableView?.register(UINib(nibName: "StatusRetweetedlCell", bundle: nil), forCellReuseIdentifier: retweetedCellId)
        
        tableView?.separatorStyle = .none
        
        tableView?.estimatedRowHeight = 300
        
        setUpNavigationItem()
    }
    
    private func setUpNavigationItem() {
        
        title = NetworkManager.shared.userAccount.screen_name
        
    }
    
}

