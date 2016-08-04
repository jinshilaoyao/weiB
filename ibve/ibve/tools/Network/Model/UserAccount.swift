//
//  UserAccount.swift
//  ibve
//
//  Created by yesway on 16/7/27.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit
import YYModel
private let accountFile: NSString = "useraccount.json"

class UserAccount: NSObject {
    
    var access_token: String?
    
    var uid: String?
    
    var expires_in: TimeInterval = 0 {
        didSet {
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    
    var expiresDate: Date?
    
    var screen_name: String?
    
    var avatar_large: String?

    override var description: String {
        return yy_modelDescription()
    }
    
    override init() {
        super.init()
        
        guard let path = accountFile.cz_appendDocumentDir(),
            data = NSData(contentsOfFile: path),
            dict = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String: AnyObject] else {
            return
        }
        
        yy_modelSet(with: dict ?? [:])
        
        if expiresDate?.compare(Date()) != .orderedDescending {
            print("账户过期")
            access_token = nil
            uid = nil
            
            _ = try? FileManager.default().isDeletableFile(atPath: path)
            
        }
    }
    
    func saveAccount() {
        
        var dict = (self.yy_modelToJSONObject() as? [String: AnyObject]) ?? [:]
        
        dict.removeValue(forKey: "expires_in")
        
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []),
            filePath = accountFile.cz_appendDocumentDir()
        else {
            return
        }
        
        (data as NSData).write(toFile: filePath, atomically: true)
    }
    
    
    
}
