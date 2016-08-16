//
//  Data+Extension.swift
//  ibve
//
//  Created by yesway on 16/8/9.
//  Copyright © 2016年 joker. All rights reserved.
//

import Foundation

private let dateFormatter = DateFormatter()

private let calendar = Calendar.current

extension Date {
    
    static func cz_dateString(delta: TimeInterval) -> String {
        let date = Date(timeIntervalSinceNow: delta)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: date)
    }
    
    static func cz_sinaDate(string: String) -> Date? {
        
        dateFormatter.dateFormat = "EEE MMM dd HH:mm:ss zzz yyyy"
        
        return dateFormatter.date(from: string)
        
    }
    
    var cz_dateDescription: String {
        
        // 1. 判断日期是否是今天
        if calendar.isDateInToday(self) {
            
            let delta = -Int(self.timeIntervalSinceNow)
            
            if delta < 60 {
                return "刚刚"
            }
            
            if delta < 3600 {
                return "\(delta / 60) 分钟前"
            }
            
            return "\(delta / 3600) 小时前"
        }
        
        // 2. 其他天
        var fmt = " HH:mm"
        
        if calendar.isDateInYesterday(self) {
            fmt = "昨天" + fmt
        } else {
            fmt = "MM-dd" + fmt
            
            let year = calendar.component(.year, from: self)
            let thisYear = calendar.component(.year, from: Date())
            
            if year != thisYear {
                fmt = "yyyy-" + fmt
            }
        }
        
        // 设置日期格式字符串
        dateFormatter.dateFormat = fmt
        
        return dateFormatter.string(from: self)
    }
    
}
