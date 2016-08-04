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
    
//    var refeshControl: CZRedfreshControl;
    
    var isPullup = false
    
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        NotificationCenter.default().addObserver(self, selector: #selector(loginSuccess), name: NSNotification.Name(rawValue: UserLoginSuccessedNotification), object: nil)
        
        
        let path = "useraccount.json"
        
        print(path.cz_appendDocumentDir())
        
        print(path.cz_appendCacheDir)
        
        print(path.cz_appendTempDir())
        
        
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
        
    }
    
    @objc private func loginSuccess() {
        
    }
}
extension BaseViewController {
    
    private func setupUI() {
        
        view.backgroundColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        
        setupVisitorView()
        
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
