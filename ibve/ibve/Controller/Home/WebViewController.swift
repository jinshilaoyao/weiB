//
//  WebViewController.swift
//  ibve
//
//  Created by yesway on 16/8/16.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit

class WebViewController: BaseViewController {

    var urlString: String? {
        didSet {
            
            guard let urlString = urlString, let url = URL(string: urlString) else {
                return
            }
            
            webView.loadRequest(URLRequest(url: url))
            
        }
    }
    
    private var webView = UIWebView(frame: UIScreen.main.bounds)
    
    override func setupTableView() {
        super.setupTableView()
        
        
        view.insertSubview(webView, belowSubview: navigationBar)
        // Do any additional setup after loading the view.
        
        view.backgroundColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        
        webView.scrollView.contentInset.top = navigationBar.bounds.height
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
