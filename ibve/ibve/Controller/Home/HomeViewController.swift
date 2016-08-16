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

        NotificationCenter.default.addObserver(self, selector: #selector(browserPhoto), name: NSNotification.Name(rawValue: StatusCellBrowserPhotoNotification), object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc private func browserPhoto(n: Notification) {
        // 1. 从 通知的 userInfo 提取参数
        guard let selectedIndex = n.userInfo?[StatusCellBrowserPhotoSelectedIndexKey] as? Int,
            let urls = n.userInfo?[StatusCellBrowserPhotoURLsKey] as? [String],
            let imageViewList = n.userInfo?[StatusCellBrowserPhotoImageViewsKey] as? [UIImageView]
            else {
                return
        }
        
        // 2. 展现照片浏览控制器
        let vc = HMPhotoBrowserController.photoBrowser(
            withSelectedIndex: selectedIndex,
            urls: urls,
            parentImageViews: imageViewList)
        
        present(vc, animated: true, completion: nil)

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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! StatusCell
        
        cell.viewModel = status
        
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 1. 根据 indexPath 获取视图模型
        let vm = listViewModel.statusList[indexPath.row]
        
        // 2. 返回计算好的行高
        return vm.rowHeight
    }
}

extension HomeViewController: StatusCellDelegate {
    
    func statusCellDidSelectedURLString(cell: StatusCell, urlString: String) {
        print(urlString)
        let web = WebViewController()
        
        web.urlString = urlString
        
        navigationController?.pushViewController(web, animated: true)
        
    }
    
}

extension HomeViewController {
    override func setupTableView() {
        
        super.setupTableView()
        
        tableView?.register(UINib(nibName: "StatusNormalCell", bundle: nil), forCellReuseIdentifier: originalCellId)
        tableView?.register(UINib(nibName: "StatusRetweetedCell", bundle: nil), forCellReuseIdentifier: retweetedCellId)
        
        tableView?.separatorStyle = .none
        
        tableView?.estimatedRowHeight = 300
        
        setUpNavigationItem()
    }
    
    private func setUpNavigationItem() {
        
        title = NetworkManager.shared.userAccount.screen_name
        
    }
    
}

