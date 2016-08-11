//
//  BaseViewController.swift
//  ibve
//
//  Created by yesway on 16/7/13.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var visitorInfoDictionary: [String: String]?
    
    var tableView: UITableView?
    
    var refeshControl: CZRefreshControl?
    
    var isPullup = false
    
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        NetworkManager.shared.userLogin ? loadData() : ()
        
        NotificationCenter.default().addObserver(self, selector: #selector(loginSuccess), name: NSNotification.Name(rawValue: UserLoginSuccessedNotification), object: nil)
        
        
    }
    
    deinit {
        NotificationCenter.default().removeObserver(self)
    }
    
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
    
    func loadData() {
        refeshControl?.endRefreshing()
    }
    
    @objc private func loginSuccess() {
        print("login Success!")
        
        navItem.leftBarButtonItem = nil
        navItem.rightBarButtonItem = nil
        
        view = nil
        
        NotificationCenter.default().removeObserver(self)
    }
}
extension BaseViewController {
    
    private func setupUI() {
        
        view.backgroundColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        
        NetworkManager.shared.userLogin ? setupTableView() : setupVisitorView()
        
    }
    
    func setupTableView() {
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        view.insertSubview(tableView!, belowSubview: navigationBar)
        
        tableView?.dataSource = self
        tableView?.delegate = self
        
        // 设置内容缩进
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height,
                                               left: 0,
                                               bottom: tabBarController?.tabBar.bounds.height ?? 49,
                                               right: 0)
//
        // 修改指示器的缩进 - 强行解包是为了拿到一个必有的 inset
        tableView?.scrollIndicatorInsets = tableView!.contentInset
        
        refeshControl = CZRefreshControl()
        
        tableView?.addSubview(refeshControl!)
        
        refeshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
    }
    
    private func setupVisitorView() {
        let visitorView = VisitorView(frame: view.bounds)
        
        view.insertSubview(visitorView, belowSubview: navigationBar)
        
        visitorView.visitorInfo = visitorInfoDictionary
        
        visitorView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        visitorView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        navItem.leftBarButtonItem = UIBarButtonItem(title: "regist", style: .plain, target: self, action: #selector(register))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "login", style: .plain, target: self, action: #selector(login))
    }
    
    @objc private func login() {
        NotificationCenter.default().post(name: NSNotification.Name(rawValue: UserShouldLoginNotification), object: nil, userInfo: nil)
    }
    
    @objc private func register() {
        print("用户注册")
    }
    
    
    private func setupNavigationBar() {
        
        view.addSubview(navigationBar)
        
        navigationBar.items = [navItem]
        
        navigationBar.barTintColor = #colorLiteral(red: 0.9647058824, green: 0.9647058824, blue: 0.9647058824, alpha: 1)
        
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.darkGray()]
        
        navigationBar.tintColor = UIColor.orange()
        
    }
}

extension BaseViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let row = indexPath.row
        
        let section = tableView.numberOfSections - 1
        
        if row < 0 || section < 0 { return }
        
        let count = tableView.numberOfRows(inSection: section)
        
        if row == (count - 1) && !isPullup {
            print("上拉刷新")
            
            isPullup = true
            
            loadData()
        }
        
    }
}
