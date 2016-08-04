 //
//  AppDelegate.swift
//  ibve
//
//  Created by yesway on 16/7/13.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit
import SVProgressHUD
import AFNetworking
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        setupAdditions()
        
        window = UIWindow()
        window?.backgroundColor = UIColor.white()
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
        
        loadAppInfo()
        
        return true
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
extension AppDelegate {
    private func setupAdditions() {
        
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        
        AFNetworkActivityIndicatorManager.shared().isEnabled = true
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization([.alert,.sound,.badge], completionHandler: { (success , error) in
                print("授权" + (success ? "成功" : "失败"))
            })
        } else {
            let notifySetting = UIUserNotificationSettings(types: [.alert,.sound,.badge], categories: nil)
            UIApplication.shared().registerUserNotificationSettings(notifySetting)
        }
    }
    
    private func loadAppInfo() {
        DispatchQueue.global().async {
            
            let url = Bundle.main().urlForResource("main.json", withExtension: nil)
            
            let data = NSData(contentsOf: url!)
            
            let dic = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

            let jsonPath = (dic as NSString).appendingPathComponent("main.json")
            
            
            data?.write(toFile: jsonPath, atomically: true)
            
        }
    }
}
