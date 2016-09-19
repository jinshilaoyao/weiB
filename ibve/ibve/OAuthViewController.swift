//
//  OAuthViewController.swift
//  ibve
//
//  Created by yesway on 16/7/27.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit
import SVProgressHUD


class OAuthViewController: UIViewController {
    
    private lazy var webView = UIWebView()
    
    override func loadView() {
        view = webView
        
        view.backgroundColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        
        webView.scrollView.isScrollEnabled = false
        
        webView.delegate = self
        
        title = ""
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", target: self, action: #selector(close), isBack: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "auth", target: self, action: #selector(authFill))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(AppKey)&redirect_uri=\(RedirectURI)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        webView.loadRequest(request)
    }
    
    @objc fileprivate func close() {
        SVProgressHUD.dismiss()
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func authFill() {
        
        let js = "document.getElementById('userId').value = '953345497@qq.com';" + "document.getElementById('passwd').value = 'cherish224';"
        
        webView.stringByEvaluatingJavaScript(from: js)
    }
}

extension OAuthViewController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if request.url?.absoluteString.hasPrefix(RedirectURI) == false {
            return true
        }
        
        if request.url?.query?.hasPrefix("code=") == false {
            close()
            return false
        }
        
        let code = request.url?.query?.substring(from: "code=".endIndex) ?? ""
        
        print("授权码 - \(code)")
        
        NetworkManager.shared.loadAccessToken(code: code) { (isSuccess) in
            
            if !isSuccess {
                SVProgressHUD.showInfo(withStatus: "bad net")
            } else {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: UserLoginSuccessedNotification), object: nil)
                
                self.close()
                
            }
            
        }
        
        return false
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
}
