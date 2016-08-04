//
//  MainViewController.swift
//  ibve
//
//  Created by yesway on 16/7/13.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit
import SVProgressHUD


class MainViewController: UITabBarController {
    
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildControllers()
        setupComposerButton()
        setupTimer()
        
        setupNewFeatureViews()
        
        delegate = self
        
        NotificationCenter.default().addObserver(self, selector: #selector(userLogin), name: NSNotification.Name(rawValue: UserShouldLoginNotification), object: nil)
    }
    
    deinit {
        timer?.invalidate()
        
        NotificationCenter.default().removeObserver(self)
    }
    
    @objc private func composeStatus() {
        
    }
    
    @objc private func userLogin(n: Notification) {
        
        print("登陆通知\(n)")
        
         var when = DispatchTime.now()
        
        if n.object != nil {
            
            SVProgressHUD.setDefaultMaskType(.gradient)
            
            SVProgressHUD.showInfo(withStatus: "重新登陆")
            
            when = DispatchTime.now() + 2
        }
        
        DispatchQueue.main.after(when: when) { 
            SVProgressHUD.setDefaultMaskType(.clear)
            
            let nav = UINavigationController(rootViewController: OAuthViewController())
            
            self.present(nav, animated: true, completion: nil)
        }
        
    }

    private lazy var compostButton: UIButton = UIButton.cz_imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
}
extension MainViewController: UITabBarControllerDelegate {
    
}

extension Bundle {
    var namespace: String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
}

extension MainViewController {
    
    private func setupNewFeatureViews() {
        
        
        
    }
    
    
    
}

extension MainViewController {
    
    private func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(updataTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updataTimer() {
        
        
        
    }
    
}

extension MainViewController {
    
    private func setupChildControllers() {
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
        
        var data = NSData(contentsOfFile: jsonPath)
        
        if data == nil {
            let path = Bundle.main().pathForResource("main.json", ofType: nil)
            
            data = NSData(contentsOfFile: path!)
        }
        
        guard let array = try? JSONSerialization.jsonObject(with: data as! Data, options: []) as? [[String: AnyObject]] else {
            return
        }
        
        var arrayM = [UIViewController]()
        
        for dict in array! {
            arrayM.append(controller(dict: dict))
        }
        
        viewControllers = arrayM
    }
    
    private func controller(dict: [String: AnyObject]) -> UIViewController {
        guard let clsName = dict["clsName"] as? String,
            title = dict["title"] as? String,
            imageName = dict["imageName"] as? String,
            visitorDict = dict["visitorInfo"] as? [String: String],
            cls = NSClassFromString(Bundle.main().namespace + "." + clsName) as? BaseViewController.Type
            else { return UIViewController() }
        
        let vc = cls.init()
        
        vc.title = title
        
        vc.visitorInfoDictionary = visitorDict
        
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orange()], for: .highlighted)
        
        vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12)], for: UIControlState(rawValue: 0))
        
        let nav = NavigationController(rootViewController: vc)
        
        
        return nav
    }
    
    
    private func setupComposerButton() {
        
        tabBar.addSubview(compostButton)
        
        let count = CGFloat(childViewControllers.count)
        
        let w  = tabBar.bounds.width / count
        
        compostButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        
        print("\(compostButton.frame.size.width)")
        
        compostButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
        
    }
    
}
