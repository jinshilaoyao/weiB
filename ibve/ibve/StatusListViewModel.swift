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
    
    func loadStatus(pullUp: Bool,completion: @escaping (_ isSuccess: Bool, _ shouldRefresh: Bool) ->()) {
        
        if pullUp && pullUpErrorTimes > maxPullupTryTimes {
            
            completion(true, false)
            
            return
        }
        
        let since_id = pullUp ? 0 : (statusList.first?.status.id ?? 0)
        
        let max_id = !pullUp ? 0 : (statusList.last?.status.id ?? 0)
        
        StatusListDAL.loadStatus(since_id: since_id, max_id: max_id) { (list, isSuccess) in
            
            if !isSuccess {
                completion(false, false)
            }
            
            var array = [StatusViewModel]()
            
            for statusDict in list ?? [] {
                
                let status = Status()
                
                status.yy_modelSet(with: statusDict)
                
                let viewModel = StatusViewModel(model: status)
                
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
                completion(isSuccess, false)
            } else {
                completion(isSuccess, true)
            }
        }
    }
    
}
