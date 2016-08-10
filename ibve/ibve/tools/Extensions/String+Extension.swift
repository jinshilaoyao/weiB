//
//  String+Extension.swift
//  ibve
//
//  Created by yesway on 16/8/9.
//  Copyright © 2016年 joker. All rights reserved.
//

import Foundation

extension String {
    
    func cz_href() -> (link: String, text: String)? {
        
        // 0. 匹配方案
        let pattern = "<a href=\"(.*?)\".*?>(.*?)</a>"
        
        // 1. 创建正则表达式，并且匹配第一项
        guard let regx = try? RegularExpression(pattern: pattern, options: []),
            result = regx.firstMatch(in: self, options: [], range: NSRange(location: 0, length: characters.count))
            else {
                return nil
        }
        
        // 2. 获取结果
        let link = (self as NSString).substring(with: result.range(at: 1))
        let text = (self as NSString).substring(with: result.range(at: 2))
        
        return (link, text)
    }

    
}
