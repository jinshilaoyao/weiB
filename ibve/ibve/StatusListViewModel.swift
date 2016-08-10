//
//  StatusListViewModel.swift
//  ibve
//
//  Created by yesway on 16/8/9.
//  Copyright © 2016年 joker. All rights reserved.
//

import Foundation

private let maxPullupTryTimes = 3

class StatusListViewModel {
    
    private var pullUpErrorTimes = 0;
    
    lazy var statusList = [StatusViewModel]()
    
    func loadStatus(pullUp: Bool,completion: (isSuccess: Bool, shouldRefresh: Bool) ->()) {
        
        if pullUp && pullUpErrorTimes > maxPullupTryTimes {
            
            completion(isSuccess: true, shouldRefresh: false)
            
            return
        }
        
        let since_id = pullUp ? Int64(0) : 0
        
        let max_id = !pullUp ? Int64(0) : 0
        
        StatusListDAL.loadStatus(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            
            if !isSuccess {
                completion(isSuccess: false, shouldRefresh: false)
            }
            
            var array = [StatusViewModel]()
            
            for statusDict in list ?? [] {
                
                let status = Status()
                
                status.yy_modelSet(with: statusDict)
                
                let viewModel = StatusViewModel()
                
                array.append(viewModel)
            }
            
            print("刷新到\(array.count) 条数据")
            
            if pullUp {
                self.statusList += array
            } else {
                self.statusList = array + self.statusList
            }
            
            if pullUp && array.count == 0 {
                self.pullUpErrorTimes += 1
                completion(isSuccess: isSuccess, shouldRefresh: false)
            } else {
                
            }
        }
    }
    
}
