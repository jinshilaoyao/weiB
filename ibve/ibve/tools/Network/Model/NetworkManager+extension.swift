//
//  NetworkManager+extension.swift
//  ibve
//
//  Created by yesway on 16/8/1.
//  Copyright © 2016年 joker. All rights reserved.
//

import Foundation


// MARK: - OAuth方法
extension NetworkManager {
    
    func loadAccessToken(code: String, completion: (isSuccess: Bool) -> ()) {
        
        let urlString = "https://api.weibo.com/oauth2/access_token"
        
        let params = ["client_id": AppKey,
                      "client_secret": AppSecret,
                      "grant_type": "authorization_code",
                      "code": code,
                      "redirect_uri": RedirectURI]
        
        request(method: .POST,URLString: urlString, parameters: params) { (json, isSuccess) in
            print(json)
            
            self.userAccount.yy_modelSet(with: (json as? [String: AnyObject]) ?? [:])
            
            self.loadUserInfo(completion: { (dict) in
                
                self.userAccount.yy_modelSet(with: dict)
                
                self.userAccount.saveAccount()
                
                print(self.userAccount)
                
                completion(isSuccess: isSuccess)
                
            })
        }
    }
}

extension NetworkManager {
    func loadUserInfo(completion: (dict: [String: AnyObject]) -> ()) {
        guard let uid = userAccount.uid  else {
            return
        }
        
        let url = "https://api.weibo.com/2/users/show.json"
        
        let params = ["uid":uid];
        
        tokenRequest(URLSrting: url, parameters: params) { (json, isSuccess) in
            
            completion(dict: (json as? [String: AnyObject]) ?? [:])
            
        }
    }
}
