//
//  StatusListDAL.swift
//  ibve
//
//  Created by yesway on 16/8/9.
//  Copyright © 2016年 joker. All rights reserved.
//

import Foundation

class StatusListDAL {
    
    class func loadStatus(since_id: Int64 = 0, max_id: Int64 = 0, completion:@escaping (_ list: [[String: AnyObject]]?, _ isSuccess:Bool) ->()) {
        
        guard let userid = NetworkManager.shared.userAccount.uid else {
            return
        }
        
        NetworkManager.shared.statusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            
            if !isSuccess {
                completion(nil, false)
            }
            
            guard let list = list else {
                completion(nil, false)
                return
            }
            
            completion(list, isSuccess)
            
        }
        
    }
    
}
