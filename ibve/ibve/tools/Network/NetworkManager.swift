//
//  NetworkManager.swift
//  ibve
//
//  Created by yesway on 16/7/27.
//  Copyright © 2016年 joker. All rights reserved.
//

import UIKit
import AFNetworking

enum HTTPMethod {
    case GET
    case POST
}

class NetworkManager: AFHTTPSessionManager {
    
    static let shared: NetworkManager = {
       
        let instance = NetworkManager()
        
        instance.responseSerializer.acceptableContentTypes?.insert("text/plain")
        
        return instance
        
    }()
    
    lazy var userAccount = UserAccount()
    
    var userLogin: Bool {
        return userAccount.access_token != nil
    }
    
    
    func tokenRequest(method: HTTPMethod = .GET, URLSrting: String, parameters: [String: AnyObject]?, name: String? = nil, data: Data? = nil, completion: @escaping (_ json: AnyObject?, _ isSuccess: Bool) ->()) {
        
        guard let token = userAccount.access_token else {
            
            print("没有 token 需要登陆")

            NotificationCenter.default.post(name: NSNotification.Name(rawValue: UserShouldLoginNotification), object: nil)
            
            completion(nil, false)
            
            return
        }
        
        var parameters = parameters
        if parameters == nil {
            parameters = [String: AnyObject]()
        }
        
        parameters?["access_token"] = token as AnyObject?
        
        if let name = name, let data = data {
            
            
            
        } else {
        
        request(method: method, URLString: URLSrting, parameters: parameters, completion: completion)
        }
    }
    
    
    func request(method: HTTPMethod = .GET, URLString: String, parameters: [String: AnyObject]?, completion: @escaping (_ json: AnyObject?, _ isSuccess: Bool) ->()) {
        
        let success =  { (task: URLSessionDataTask, json: Any?) ->() in
            completion(json as AnyObject?, true)
        }
        
        let failure = { (task: URLSessionDataTask?, error: Error) -> () in
            
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                print("Token 过期了")
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: UserShouldLoginNotification), object: "bad token")
            }
            
            completion(nil, false)
        }
        
        if method == .GET {
            get(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
            
        } else {
            post(URLString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
        
    }
    
}
